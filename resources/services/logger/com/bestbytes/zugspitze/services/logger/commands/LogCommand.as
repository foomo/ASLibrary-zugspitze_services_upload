package org.foomo.zugspitze.services.logger.commands
{
	import flash.events.EventDispatcher;
	import org.foomo.zugspitze.services.logger.*;
	import org.foomo.zugspitze.services.logger.events.LogEvent;
	import org.foomo.zugspitze.services.logger.responders.ILogResponder;
	import org.foomo.zugspitze.services.logger.model.LoggerProxy;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.events.CommandEvent;
	import org.foomo.zugspitze.commands.Command;

	// all local imports
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Report;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Screenshot;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Capabilities;

	[Event(name="logResult", type="org.foomo.zugspitze.services.logger.events.LogEvent")]
	[Event(name="logFault", type="org.foomo.zugspitze.services.logger.events.LogEvent")]
	/**
	 * Log a error report
	 */
	public class LogCommand extends Command implements ICommand, ILogResponder
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Sevice proxy
		 */
		private var _proxy:LoggerProxy;
		/**
		 * Last service message
		 */
		[Bindable]
		public var lastMessages:Array;
		/**
		 * Last service result
		 */
		[Bindable]
		public var lastResult:Boolean;
		/**
		 *
		 */
		public var parameterReport:Report;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LogCommand(report:Report, proxy:LoggerProxy=null, setBusyStatus:Boolean=false)
		{
			super(setBusyStatus);
			this._proxy = (proxy) ? proxy : LoggerProxy.defaultInstance;
			this.parameterReport = report;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		public function execute():void
		{
			this._proxy.operationLog.report = this.parameterReport;
			this._proxy.operationLog.send(this);
		}

		/**
		 * @inherit
		 */
		public function result(data:Boolean):void
		{
			this.lastResult = this._proxy.operationLog.lastResult = data;
			this.dispatchEvent(new LogEvent(LogEvent.RESULT, data, this.lastMessages));
			this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_COMPLETE, this));
		}

		/**
		 * @inherit
		 */
		public function fault(info:Object):void
		{
			this.dispatchEvent(new CommandEvent(CommandEvent.COMMAND_ERROR, this));
			this.dispatchEvent(new LogEvent(LogEvent.FAULT, null, null));
		}

		/**
		 * @inherit
		 */
		public function messages(messages:Array):void
		{
			this.lastMessages = messages;
		}

		/**
		 * @inherit
		 */
		public function exception(exception:Object):void
		{
			this.dispatchCommandCompleteEvent();
		}
	}
}