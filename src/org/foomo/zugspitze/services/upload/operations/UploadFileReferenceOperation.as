package org.foomo.zugspitze.services.upload.operations
{
	import org.foomo.zugspitze.services.sharedVo.Reference;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.upload.Info;
	import org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent;
	import org.foomo.zugspitze.services.upload.events.UploadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.model.UploadProxy;

	import flash.net.FileReference;

	import mx.utils.Base64Encoder;

	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.events.ProgressOperationEvent;
	import org.foomo.zugspitze.operations.AbstractProgressOperation;

	public class UploadFileReferenceOperation extends AbstractProgressOperation implements IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		/**
		 * about the chunk size: results of a quick and dirty measurement (local transmission, no network, 2MiB file)
		 *
		 *    CHUNK_SIZE      duration (ms)
		 *          4096         26171
		 *          8192         15282
		 *         16384          8780
		 *         32768          5340
		 *         65536          4135
		 *        131072          3436
		 *        262144          2994
		 *        524288          2834
		 *       1048576          2781
		 */
		public static const DEFAULT_CHUNK_SIZE:int 	= 65536; // 64 KiB
		public static const MIN_CHUNK_SIZE:int 		= 100;

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * hold it internally, not to get confused when it is changed from outside
		 */
		private var _chunkSize:uint;
		/**
		 *
		 */
		private var _uploadInfo:Info;
		/**
		 *
		 */
		private var _fileReference:FileReference
		/**
		 *
		 */
		private var _proxy:UploadProxy;
		/**
		 *
		 */
		private var _encoder:Base64Encoder;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadFileReferenceOperation(proxy:UploadProxy, fileReference:FileReference, chunkSize:int=65536)
		{
			super(UploadFileReferenceOperationEvent);
			this._proxy = proxy;
			this._encoder = new Base64Encoder;
			this._fileReference = fileReference;
			this._chunkSize = Math.max(chunkSize, MIN_CHUNK_SIZE);
			this.uploadChunk();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function unload():void
		{
			this._proxy = null;
			this._encoder = null;
			this._uploadInfo = null;
			this._fileReference = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		protected function uploadChunk():void
		{
			var offset:uint = (this._uploadInfo) ? this._uploadInfo.size : 0;
			var length:uint = Math.min(this._fileReference.data.length - offset, this._chunkSize);
			this._encoder.encodeBytes(this._fileReference.data, offset, length);
			this._proxy.chunkUploadMethod.call(
				this._encoder.toString(),
				this._fileReference.size,
				this._fileReference.name,
				(this._uploadInfo) ? this._uploadInfo.id : null,
				this.chunkedUploadMethodCall_operationCompleteHandler,
				this.chunkedUploadMethodCall_operationProgressHandler,
				this.chunkedUploadMethodCall_operationErrorHandler
			);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		protected function chunkedUploadMethodCall_operationProgressHandler(event:ProgressOperationEvent):void
		{
			trace('[DEBUG] UploadOperation.chunkedUploadMethodCall_operationProgressHandler()');
		}

		protected function chunkedUploadMethodCall_operationCompleteHandler(event:ChunkUploadOperationEvent):void
		{
			this._uploadInfo = Info(event.result.value);

			this.dispatchOperationProgressEvent(this._fileReference.size, this._uploadInfo.size);

			if (this.progress < this.total) {
				this.uploadChunk();
			} else {
				var uploadReference:Reference = new Reference();
				uploadReference.id = this._uploadInfo.id;
				uploadReference.creator = this._fileReference.creator;
				uploadReference.extension = this._fileReference.name.substring(this._fileReference.name.lastIndexOf('.') + 1);
				uploadReference.name = this._fileReference.name;
				uploadReference.type = this._fileReference.type;
				uploadReference.size = this._fileReference.size;
				uploadReference.creationDate = this._fileReference.creationDate.getTime();
				uploadReference.modificationDate = this._fileReference.modificationDate.getTime();
				this.dispatchOperationCompleteEvent(uploadReference);
			}
		}

		protected function chunkedUploadMethodCall_operationErrorHandler(event:ChunkUploadOperationEvent):void
		{
			trace('[DEBUG] ChunkedUploadOperation.chunkedUploadMethodCall_errorHandler()');
		}
	}
}