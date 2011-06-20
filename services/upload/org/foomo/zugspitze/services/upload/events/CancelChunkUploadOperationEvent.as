package org.foomo.zugspitze.services.upload.events
{
	import org.foomo.zugspitze.services.core.proxy.events.ProxyMethodOperationEvent;

	/**
	 *
	 */
	public class CancelChunkUploadOperationEvent extends ProxyMethodOperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const CANCEL_CHUNK_UPLOAD_OPERATION_COMPLETE:String = 'cancelChunkUploadOperationComplete';
		public static const CANCEL_CHUNK_UPLOAD_OPERATION_PROGRESS:String = 'cancelChunkUploadOperationProgress';
		public static const CANCEL_CHUNK_UPLOAD_OPERATION_ERROR:String = 'cancelChunkUploadOperationError';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CancelChunkUploadOperationEvent(type:String, result:*=null, error:*=null, messages:Array=null, total:Number=0, progress:Number=0)
		{
			super(type, result, error, messages, total, progress);
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

		/**
		 *
		 */
		public function get error():*
		{
			return this.untypedError;
		}
	}
}