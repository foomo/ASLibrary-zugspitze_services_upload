package org.foomo.zugspitze.services.upload.events
{
	import flash.net.FileReference;

	import org.foomo.zugspitze.events.OperationEvent;

	public class LoadFileReferenceOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const LOAD_FILE_REFERENCE_OPERATION_COMPLETE:String = 'loadFileReferenceOperationComplete';
		public static const LOAD_FILE_REFERENCE_OPERATION_PROGRESS:String = 'loadFileReferenceOperationProgress';
		public static const LOAD_FILE_REFERENCE_OPERATION_ERROR:String = 'loadFileReferenceOperationError';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LoadFileReferenceOperationEvent(type:String, result:FileReference=null, error:*=null, total:Number=0, progress:Number=0)
		{
			super(type, result, error, total, progress);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():FileReference
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