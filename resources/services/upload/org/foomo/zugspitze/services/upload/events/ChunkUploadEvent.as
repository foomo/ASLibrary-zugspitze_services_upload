package org.foomo.zugspitze.services.upload.events
{
	// all local imports
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.upload.Info;

	import flash.events.Event;

	public class ChunkUploadEvent extends Event
	{
		public static const RESULT:String = 'chunkUploadResult';
		public static const FAULT:String  = 'chunkUploadFault';

		public var result:Info;
		public var messages:Array;

		public function ChunkUploadEvent(type:String, result:*, messages:Array = null)
		{
			this.result = result as Info;
			if(messages) {
				this.messages = messages;
			} else {
				this.messages = [];
			}
			super(type);
		}
	}
}