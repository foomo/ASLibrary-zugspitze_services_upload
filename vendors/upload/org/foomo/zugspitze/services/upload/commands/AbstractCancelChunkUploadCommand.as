package org.foomo.zugspitze.services.upload.commands
{
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.calls.CancelChunkUploadCall;
	import org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent;

	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.core.IUnload;

	/**
	 * Create your own command instance and override the protected event handlers
	 */
	public class AbstractCancelChunkUploadCommand extends Command implements ICommand, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Service proxy
		 */
		public var proxy:UploadProxy;
		/**
		 * 
		 */
		public var uploadId:String;
		/**
		 * Returned call from the proxy
		 */
		protected var _methodCall:CancelChunkUploadCall;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * @param uploadId ;
		 * @param proxy Service proxy
		 * @param setBusyStatus Set busy status while pending
		 */
		public function AbstractCancelChunkUploadCommand(uploadId:String, proxy:UploadProxy, setBusyStatus:Boolean=false)
		{
			this.uploadId = uploadId;
			this.proxy = proxy;
			super(setBusyStatus);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @see org.foomo.zugspitze.commands.ICommand
		 */
		public function execute():void
		{
			this._methodCall = this.proxy.cancelChunkUpload(this.uploadId);
			this._methodCall.addEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_ERROR, this.abstractErrorHandler);
			this._methodCall.addEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_PROGRESS, this.abstractProgressHandler);
			this._methodCall.addEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_COMPLETE, this.abstractCompleteHandler);
		}

		/**
		 * @see org.foomo.zugspitze.core.IUnload
		 */
		public function unload():void
		{
			this.proxy = null;
			this.uploadId = '';
			if (this._methodCall) {
				this._methodCall.removeEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_ERROR, this.abstractErrorHandler);
				this._methodCall.removeEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_PROGRESS, this.abstractProgressHandler);
				this._methodCall.removeEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_COMPLETE, this.abstractCompleteHandler);
				this._methodCall = null;
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 * Handle method call progress
		 *
		 * @param event Method call event
		 */
		protected function abstractProgressHandler(event:CancelChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
		}

		/**
		 * Handle method call result
		 *
		 * @param event Method call event
		 */
		protected function abstractCompleteHandler(event:CancelChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
			this.dispatchCommandCompleteEvent();
		}

		/**
		 * Handle method call error
		 *
		 * @param event Method call event
		 */
		protected function abstractErrorHandler(event:CancelChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
			this.dispatchCommandErrorEvent(event.error);
		}
	}
}