package org.foomo.zugspitze.services.logger.events {
	// all local imports
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Report;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Screenshot;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Capabilities;
	import flash.events.Event;

	public class LogEvent extends Event {
		public static const RESULT:String = 'logResult';
		public static const FAULT:String  = 'logFault';
		public var result:Boolean;
		public var messages:Array;
		public function LogEvent(type:String, result:*, messages:Array = null)
		{
			this.result = result as Boolean;
			if(messages) {
				this.messages = messages;
			} else {
				this.messages = [];
			}
			super(type);
		}
	}
}