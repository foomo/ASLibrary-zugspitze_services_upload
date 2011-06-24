package org.foomo.zugspitze.services.upload.events
{
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;
	import org.foomo.zugspitze.services.upload.calls.ChunkUploadCall;

	import flash.events.Event;

	import org.foomo.zugspitze.services.core.proxy.events.ProxyMethodCallEvent;

	/**
	 *
	 */
	public class ChunkUploadCallEvent extends ProxyMethodCallEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const CHUNK_UPLOAD_CALL_COMPLETE:String = "chunkUploadCallComplete";
		public static const CHUNK_UPLOAD_CALL_PROGRESS:String = "chunkUploadCallProgress";
		public static const CHUNK_UPLOAD_CALL_ERROR:String = "chunkUploadCallError";

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ChunkUploadCallEvent(type:String, result:*=null, error:String='', exception:*=null, messages:Array=null, bytesTotal:Number=0, bytesLoaded:Number=0)
		{
			super(type, result, error, exception, messages, bytesTotal, bytesLoaded);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Method call result
		 */
		public function get result():Info
		{
			return this.untypedResult;
		}
	}
}