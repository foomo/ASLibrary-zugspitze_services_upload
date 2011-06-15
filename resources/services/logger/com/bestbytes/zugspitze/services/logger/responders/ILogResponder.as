package org.foomo.zugspitze.services.logger.responders
{
	import mx.rpc.IResponder;


	public interface ILogResponder
	{
		/**
		 * Handle result
		 */
		function result(data:Boolean):void;
		/**
		 * Handle fault
		 */
		function fault(info:Object):void;
		/**
		 * Handle messages
		 */
		function messages(messages:Array):void;
		/**
		 * Handle exception
		 */
		function exception(exception:Object):void;
	}
}