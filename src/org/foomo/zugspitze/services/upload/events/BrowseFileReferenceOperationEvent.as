package org.foomo.zugspitze.services.upload.events
{
	import flash.events.Event;
	import flash.net.FileReference;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;

	public class BrowseFileReferenceOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
<<<<<<< HEAD
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
=======
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function BrowseFileReferenceOperationEvent(type:String, operation:IOperation)
		{
			super(type, operation);
>>>>>>> 5640fd29a329df87b3612e18fdcfe35ae537a3ff
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():FileReference
		{
<<<<<<< HEAD
			return this.untypedResult;
=======
			return FileReference(this.operation.result);
>>>>>>> 5640fd29a329df87b3612e18fdcfe35ae537a3ff
		}

		/**
		 *
		 */
<<<<<<< HEAD
		public function get error():Event
		{
			return this.untypedError;
=======
		public function get error():*
		{
			return this.operation.error;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			return new BrowseFileReferenceOperationEvent(this.type, this.operation);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString('BrowseFileReferenceOperationEvent');
>>>>>>> 5640fd29a329df87b3612e18fdcfe35ae537a3ff
		}
	}
}