package org.foomo.zugspitze.services.upload.operations
{
	import org.foomo.zugspitze.services.upload.events.LoadFileReferenceOperationEvent;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;

	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.operations.AbstractProgressOperation;

	public class LoadFileReferenceOperation extends AbstractProgressOperation implements IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _fileReference:FileReference

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LoadFileReferenceOperation(fileReference:FileReference)
		{
			super(LoadFileReferenceOperationEvent);
			this._fileReference = fileReference;
			this._fileReference.addEventListener(Event.COMPLETE, this.fileReference_completeHandler);
			this._fileReference.addEventListener(IOErrorEvent.IO_ERROR, this.fileReference_errorHandler);
			this._fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.fileReference_errorHandler);
			this._fileReference.addEventListener(ProgressEvent.PROGRESS, this.fileReference_progressHandler);
			this._fileReference.load();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function unload():void
		{
			this._fileReference.removeEventListener(Event.COMPLETE, this.fileReference_completeHandler);
			this._fileReference.removeEventListener(IOErrorEvent.IO_ERROR, this.fileReference_errorHandler);
			this._fileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.fileReference_errorHandler);
			this._fileReference.removeEventListener(ProgressEvent.PROGRESS, this.fileReference_progressHandler);
			this._fileReference = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function fileReference_progressHandler(event:ProgressEvent):void
		{
			this.dispatchOperationProgressEvent(event.bytesTotal, event.bytesLoaded);
		}

		/**
		 *
		 */
		protected function fileReference_completeHandler(event:Event):void
		{
			this.dispatchOperationCompleteEvent(this._fileReference);
		}

		/**
		 *
		 */
		protected function fileReference_errorHandler(event:Event):void
		{
			this.dispatchOperationErrorEvent(event['text']);
		}
	}
}