package org.foomo.zugspitze.services.upload.events
{
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.services.upload.vos.UploadReference;

	public class UploadFileReferenceOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const UPLOAD_FILE_REFERENCE_OPERATION_COMPLETE:String = 'uploadFileReferenceOperationComplete';
		public static const UPLOAD_FILE_REFERENCE_OPERATION_PROGRESS:String = 'uploadFileReferenceOperationProgress';
		public static const UPLOAD_FILE_REFERENCE_OPERATION_ERROR:String = 'uploadFileReferenceOperationError';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadFileReferenceOperationEvent(type:String, result:UploadReference=null, error:*=null, total:Number=0, progress:Number=0)
		{
			super(type, result, error, total, progress);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():UploadReference
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