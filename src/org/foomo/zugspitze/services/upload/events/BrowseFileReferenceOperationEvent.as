package org.foomo.zugspitze.services.upload.events
{
	import flash.events.Event;
	import flash.net.FileReference;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;

	public class BrowseFileReferenceOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const BROWSE_FILE_REFERENCE_OPERATION_COMPLETE:String = 'browseFileReferenceOperationComplete';
		public static const BROWSE_FILE_REFERENCE_OPERATION_PROGRESS:String = 'browseFileReferenceOperationProgress';
		public static const BROWSE_FILE_REFERENCE_OPERATION_ERROR:String = 'browseFileReferenceOperationError';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function BrowseFileReferenceOperationEvent(type:String, result:*=null, error:*=null, total:Number=0, progress:Number=0)
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
		public function get error():Event
		{
			return this.untypedError;
		}
	}
}