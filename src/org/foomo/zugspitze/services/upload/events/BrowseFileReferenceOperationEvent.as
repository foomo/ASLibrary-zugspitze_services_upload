package org.foomo.zugspitze.services.upload.events
{
	import flash.events.Event;
	import flash.net.FileReference;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;

	public class BrowseFileReferenceOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function BrowseFileReferenceOperationEvent(type:String, operation:IOperation)
		{
			super(type, operation);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():FileReference
		{
			return FileReference(this.operation.result);
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
			return new BrowseFileReferenceOperationEvent(this.type, this.operation);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString('BrowseFileReferenceOperationEvent');
		}
	}
}