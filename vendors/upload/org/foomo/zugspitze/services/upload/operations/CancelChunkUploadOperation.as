package org.foomo.zugspitze.services.upload.operations
{
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent;

	import org.foomo.zugspitze.services.core.proxy.operations.ProxyMethodOperation;

	[Event(name="CancelChunkUploadOperationComplete", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent")]
	[Event(name="CancelChunkUploadOperationProgress", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent")]
	[Event(name="CancelChunkUploadOperationError", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent")]

	/**
	 *
	 */
	public class CancelChunkUploadOperation extends ProxyMethodOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function CancelChunkUploadOperation(uploadId:String, proxy:UploadProxy)
		{
			super(proxy, 'cancelChunkUpload', [uploadId], CancelChunkUploadOperationEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():Boolean
		{
			return this.untypedResult;
		}
	}
}