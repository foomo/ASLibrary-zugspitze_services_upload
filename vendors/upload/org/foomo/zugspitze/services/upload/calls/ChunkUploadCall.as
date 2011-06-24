package org.foomo.zugspitze.services.upload.calls
{
	import org.foomo.zugspitze.services.upload.events.ChunkUploadCallEvent;
	import org.foomo.zugspitze.services.core.proxy.calls.ProxyMethodCall;
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;

	[Event(name="chunkUploadCallComplete", type="org.foomo.zugspitze.services.upload.events.ChunkUploadCallEvent")]
	[Event(name="chunkUploadCallProgress", type="org.foomo.zugspitze.services.upload.events.ChunkUploadCallEvent")]
	[Event(name="chunkUploadCallError", type="org.foomo.zugspitze.services.upload.events.ChunkUploadCallEvent")]

	/**
	 *
	 */
	public class ChunkUploadCall extends ProxyMethodCall
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const METHOD_NAME:String = 'chunkUpload';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ChunkUploadCall(chunk:String, totalLength:int, uploadName:String, uploadId:String)
		{
			super(METHOD_NAME, [chunk, totalLength, uploadName, uploadId], ChunkUploadCallEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Method call result
		 */
		public function get result():Info
		{
			return this.methodReply.value;
		}
	}
}