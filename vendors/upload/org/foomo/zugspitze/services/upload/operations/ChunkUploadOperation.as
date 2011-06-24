package org.foomo.zugspitze.services.upload.operations
{
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;

	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent;

	import org.foomo.zugspitze.services.core.proxy.operations.ProxyMethodOperation;

	[Event(name="ChunkUploadOperationComplete", type="org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent")]
	[Event(name="ChunkUploadOperationProgress", type="org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent")]
	[Event(name="ChunkUploadOperationError", type="org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent")]

	/**
	 *
	 */
	public class ChunkUploadOperation extends ProxyMethodOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function ChunkUploadOperation(chunk:String, totalLength:int, uploadName:String, uploadId:String, proxy:UploadProxy)
		{
			super(proxy, 'chunkUpload', [chunk, totalLength, uploadName, uploadId], ChunkUploadOperationEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():Info
		{
			return this.untypedResult;
		}
	}
}