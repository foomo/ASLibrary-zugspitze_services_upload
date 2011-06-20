package org.foomo.zugspitze.services.upload.calls
{
	import org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent;
	import org.foomo.zugspitze.services.core.proxy.calls.ProxyMethodCall;

	[Event(name="cancelChunkUploadCallComplete", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent")]
	[Event(name="cancelChunkUploadCallProgress", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent")]
	[Event(name="cancelChunkUploadCallError", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent")]

	/**
	 *
	 */
	public class CancelChunkUploadCall extends ProxyMethodCall
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const METHOD_NAME:String = 'cancelChunkUpload';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CancelChunkUploadCall(uploadId:String)
		{
			super(METHOD_NAME, [uploadId], CancelChunkUploadCallEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Method call result
		 */
		public function get result():Boolean
		{
			return this.methodReply.value;
		}
	}
}