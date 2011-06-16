package org.foomo.zugspitze.services.upload.operations
{
	import org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent;

	import flash.events.Event;
	import flash.net.FileReference;

	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.operations.Operation;
	import org.foomo.zugspitze.operations.IOperation;

	public class BrowseFileReferenceOperation extends Operation implements IOperation, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const SIZE_TOO_BIG_ERROR:String 	= 'sizeTooBig';
		public static const SIZE_TOO_SMALL_ERROR:String = 'sizeTooSmall';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _fileReference:FileReference;
		/**
		 *
		 */
		private var _maxSize:int;
		/**
		 *
		 */
		private var _minSize:int;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function BrowseFileReferenceOperation(typeFiler:Array, maxSize:int=0, minSize:int=0)
		{
			super(BrowseFileReferenceOperationEvent);
			this._maxSize = maxSize;
			this._minSize = minSize;
			this._fileReference = new FileReference;
			this._fileReference.addEventListener(Event.SELECT, this.fileReference_selectHandler);
			this._fileReference.addEventListener(Event.CANCEL, this.fileReference_cancelHandler);
			this._fileReference.browse(typeFiler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function unload():void
		{
			this._fileReference.removeEventListener(Event.SELECT, this.fileReference_selectHandler);
			this._fileReference.removeEventListener(Event.CANCEL, this.fileReference_cancelHandler);
			this._fileReference = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function fileReference_selectHandler(event:Event):void
		{
			if (this._maxSize > 0 && this._maxSize < this._fileReference.size) {
				this.dispatchOperationErrorEvent(SIZE_TOO_BIG_ERROR);
			} else if (this._minSize > 0 && this._minSize > this._fileReference.size) {
				this.dispatchOperationErrorEvent(SIZE_TOO_SMALL_ERROR);
			} else {
				this.dispatchOperationCompleteEvent(this._fileReference);
			}
		}

		/**
		 *
		 */
		protected function fileReference_cancelHandler(event:Event):void
		{
			this.dispatchOperationCompleteEvent(null);
		}
	}
}