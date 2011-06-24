package org.foomo.zugspitze.services.upload.events
{
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;

	import org.foomo.zugspitze.services.core.proxy.events.ProxyMethodOperationEvent;

	/**
	 *
	 */
	public class ChunkUploadOperationEvent extends ProxyMethodOperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const CHUNK_UPLOAD_OPERATION_COMPLETE:String = 'chunkUploadOperationComplete';
		public static const CHUNK_UPLOAD_OPERATION_PROGRESS:String = 'chunkUploadOperationProgress';
		public static const CHUNK_UPLOAD_OPERATION_ERROR:String = 'chunkUploadOperationError';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ChunkUploadOperationEvent(type:String, result:*=null, error:*=null, messages:Array=null, total:Number=0, progress:Number=0)
		{
			super(type, result, error, messages, total, progress);
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

		/**
		 *
		 */
		public function get error():*
		{
			return this.untypedError;
		}
	}
}