package org.foomo.zugspitze.services.upload.commands
{
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.calls.ChunkUploadCall;
	import org.foomo.zugspitze.services.upload.events.ChunkUploadCallEvent;

	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.core.IUnload;

	/**
	 * Create your own command instance and override the protected event handlers
	 */
	public class AbstractChunkUploadCommand extends Command implements ICommand, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Service proxy
		 */
		public var proxy:UploadProxy;
		/**
		 * base64 encoded chunk
		 */
		public var chunk:String;
		/**
		 * length of the file to be uploaded
		 */
		public var totalLength:int;
		/**
		 * basename of the file on the client
		 */
		public var uploadName:String;
		/**
		 * null to start a new upload, the upload id as returned from previous calls to continue an upload
		 */
		public var uploadId:String;
		/**
		 * Returned call from the proxy
		 */
		protected var _methodCall:ChunkUploadCall;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * @param chunk base64 encoded chunk;
		 * @param totalLength length of the file to be uploaded;
		 * @param uploadName basename of the file on the client;
		 * @param uploadId null to start a new upload, the upload id as returned from previous calls to continue an upload;
		 * @param proxy Service proxy
		 * @param setBusyStatus Set busy status while pending
		 */
		public function AbstractChunkUploadCommand(chunk:String, totalLength:int, uploadName:String, uploadId:String, proxy:UploadProxy, setBusyStatus:Boolean=false)
		{
			this.chunk = chunk;
			this.totalLength = totalLength;
			this.uploadName = uploadName;
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
			this._methodCall = this.proxy.chunkUpload(this.chunk, this.totalLength, this.uploadName, this.uploadId);
			this._methodCall.addEventListener(ChunkUploadCallEvent.CHUNK_UPLOAD_CALL_ERROR, this.abstractErrorHandler);
			this._methodCall.addEventListener(ChunkUploadCallEvent.CHUNK_UPLOAD_CALL_PROGRESS, this.abstractProgressHandler);
			this._methodCall.addEventListener(ChunkUploadCallEvent.CHUNK_UPLOAD_CALL_COMPLETE, this.abstractCompleteHandler);
		}

		/**
		 * @see org.foomo.zugspitze.core.IUnload
		 */
		public function unload():void
		{
			this.proxy = null;
			this.chunk = '';
			this.totalLength = 0;
			this.uploadName = '';
			this.uploadId = '';
			if (this._methodCall) {
				this._methodCall.removeEventListener(ChunkUploadCallEvent.CHUNK_UPLOAD_CALL_ERROR, this.abstractErrorHandler);
				this._methodCall.removeEventListener(ChunkUploadCallEvent.CHUNK_UPLOAD_CALL_PROGRESS, this.abstractProgressHandler);
				this._methodCall.removeEventListener(ChunkUploadCallEvent.CHUNK_UPLOAD_CALL_COMPLETE, this.abstractCompleteHandler);
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
		protected function abstractProgressHandler(event:ChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
		}

		/**
		 * Handle method call result
		 *
		 * @param event Method call event
		 */
		protected function abstractCompleteHandler(event:ChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
			this.dispatchCommandCompleteEvent();
		}

		/**
		 * Handle method call error
		 *
		 * @param event Method call event
		 */
		protected function abstractErrorHandler(event:ChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
			this.dispatchCommandErrorEvent(event.error);
		}
	}
}