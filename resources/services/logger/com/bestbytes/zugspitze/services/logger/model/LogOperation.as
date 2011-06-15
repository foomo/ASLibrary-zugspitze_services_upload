package org.foomo.zugspitze.services.logger.model
{
	import flash.events.EventDispatcher;
	import mx.collections.ArrayCollection;
	import org.foomo.zugspitze.services.rpc.RPCMethodCallToken;
	import org.foomo.zugspitze.services.rpc.events.RPCMethodCallTokenEvent;
	import org.foomo.zugspitze.services.logger.*;
	import org.foomo.zugspitze.services.logger.events.LogEvent;
	import org.foomo.zugspitze.services.logger.responders.ILogResponder;

	// all local imports
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Report;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Screenshot;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Capabilities;

	[Event(name="logResult", type="org.foomo.zugspitze.services.logger.events.LogEvent")]
	[Event(name="logFault", type="org.foomo.zugspitze.services.logger.events.LogEvent")]

	public class LogOperation extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Command is pending
		 */
		public var pending:Boolean = false;
		/**
		 *
		 */
		public var report:Report;
		/**
		 * Last opertion result
		 */
		public var lastResult:Boolean;
		/**
		 * Last messages
		 */
		public var lastMessages:Array;
		/**
		 * Service proxy
		 */
		public var proxy:LoggerProxy;
		/**
		 * Service responders
		 */
		protected var _responders:Object = new Object;

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function send(responder:ILogResponder=null):RPCMethodCallToken
		{
			this.pending = true;
			var token:RPCMethodCallToken = this.proxy.rpcClient.addMethodCall('log', [this.report]);
			if (responder) this._responders[token.methodCallId] = responder;
			token.addEventListener(RPCMethodCallTokenEvent.METHOD_CALL_COMPLETE, this.token_methodCallCompleteHandler);
			token.addEventListener(RPCMethodCallTokenEvent.METHOD_CALL_ERROR, this.token_methodCallFaultHandler);
			this.proxy.rpcClient.sendCall();
			return token;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandlers
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function token_methodCallCompleteHandler(event:RPCMethodCallTokenEvent):void
		{
			this.pending = false;

			var token:RPCMethodCallToken = RPCMethodCallToken(event.currentTarget);
			token.removeEventListener(RPCMethodCallTokenEvent.METHOD_CALL_COMPLETE, this.token_methodCallCompleteHandler);
			token.removeEventListener(RPCMethodCallTokenEvent.METHOD_CALL_ERROR, this.token_methodCallFaultHandler);

			if (this._responders[event.methodReply.id]) {
				var responder:ILogResponder = this._responders[event.methodReply.id];

				this._responders[event.methodReply.id] = null;
				this.lastMessages = event.methodReply.messages;
				responder.messages(this.lastMessages);
				if (event.methodReply.exception) {
					// TODO: should the lastResult be nulled
					// this.lastResult = null;
					var exceptionEvent:LogEvent;
					throw new Error('unhandled exception ' + event.methodReply.exception);
				} else {
					this.lastResult = event.methodReply.value as Boolean;
					this.dispatchEvent(new LogEvent(LogEvent.RESULT, this.lastResult, this.lastMessages));
					responder.result(this.lastResult);
				}
			}
		}

		/**
		 *
		 */
		protected function token_methodCallFaultHandler(event:RPCMethodCallTokenEvent):void
		{
			this.pending = false;

			var token:RPCMethodCallToken = RPCMethodCallToken(event.currentTarget);
			token.removeEventListener(RPCMethodCallTokenEvent.METHOD_CALL_COMPLETE, this.token_methodCallCompleteHandler);
			token.removeEventListener(RPCMethodCallTokenEvent.METHOD_CALL_ERROR, this.token_methodCallFaultHandler);

			this.dispatchEvent(new LogEvent(LogEvent.FAULT, null, null));
			if(this._responders[event.methodCall.id]) {
				var responder:ILogResponder = this._responders[event.methodCall.id];
				responder.fault(null);
				this._responders[event.methodCall.id] = null;
			}
		}
	}
}