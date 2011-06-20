package org.foomo.zugspitze.services.upload.events
{
	import org.foomo.zugspitze.services.upload.calls.CancelChunkUploadCall;

	import flash.events.Event;

	import org.foomo.zugspitze.services.core.proxy.events.ProxyMethodCallEvent;

	/**
	 *
	 */
	public class CancelChunkUploadCallEvent extends ProxyMethodCallEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const CANCEL_CHUNK_UPLOAD_CALL_COMPLETE:String = "cancelChunkUploadCallComplete";
		public static const CANCEL_CHUNK_UPLOAD_CALL_PROGRESS:String = "cancelChunkUploadCallProgress";
		public static const CANCEL_CHUNK_UPLOAD_CALL_ERROR:String = "cancelChunkUploadCallError";

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CancelChunkUploadCallEvent(type:String, result:*=null, error:String='', exception:*=null, messages:Array=null, bytesTotal:Number=0, bytesLoaded:Number=0)
		{
			super(type, result, error, exception, messages, bytesTotal, bytesLoaded);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Method call result
		 */
		public function get result():Boolean
		{
			return this.untypedResult;
		}
	}
}