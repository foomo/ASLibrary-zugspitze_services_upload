package org.foomo.zugspitze.services.upload.events
{
	import org.foomo.zugspitze.services.sharedVo.Reference;

	import flash.events.Event;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;

	public class UploadFileReferenceOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadFileReferenceOperationEvent(type:String, operation:IOperation)
		{
			super(type, operation);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():Reference
		{
			return Reference(this.operation.result);
		}

		/**
		 *
		 */
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
			return new UploadFileReferenceOperationEvent(this.type, this.operation);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString('UploadFileReferenceOperationEvent');
		}
	}
}