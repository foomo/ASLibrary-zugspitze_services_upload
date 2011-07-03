/*
 * This file is part of the foomo Opensource Framework.
 *
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */
package org.foomo.zugspitze.services.upload.operations
{
	import flash.net.FileReference;

	import mx.utils.Base64Encoder;

	import org.foomo.flash.core.IUnload;
	import org.foomo.zugspitze.operations.CompositeOperation;
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent;
	import org.foomo.zugspitze.services.upload.events.UploadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.vos.UploadReference;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @author  jan <jan@bestbytes.de>
	 */
	public class UploadFileReferenceOperation extends CompositeOperation implements IUnload
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
			this.registerOperation(
				new ChunkUploadOperation(
					this._encoder.toString(),
					this._fileReference.size,
					this._fileReference.name,
					(this._uploadInfo) ? this._uploadInfo.id : null,
					this._proxy
				),
				this.chunkedUploadOperation_operationCompleteHandler
			);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		protected function chunkedUploadOperation_operationCompleteHandler(event:ChunkUploadOperationEvent):void
		{
			this._uploadInfo = event.result;

			this.dispatchOperationProgressEvent(this._fileReference.size, this._uploadInfo.size);

			if (this.progress < this.total) {
				this.uploadChunk();
			} else {
				var uploadReference:UploadReference = new UploadReference();
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
	}
}