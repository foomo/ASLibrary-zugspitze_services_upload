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
	import flash.net.FileReferenceList;

	import mx.utils.Base64Encoder;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.OperationChain;
	import org.foomo.zugspitze.operations.ProgressOperation;
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.vos.UploadReference;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class UploadFileReferenceListOperation extends ProgressOperation
	{
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
		private var _fileReferenceList:FileReferenceList;
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
		/**
		 *
		 */
		private var _uploadReferences:Array = [];
		/**
		 *
		 */
		private var _unloadFileReferences:Boolean;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadFileReferenceListOperation(fileReferenceList:FileReferenceList, proxy:UploadProxy, chunkSize:int=65536, unloadFileReferences:Boolean=true)
		{
			this._proxy = proxy;
			this._encoder = new Base64Encoder;
			this._fileReferenceList = fileReferenceList;
			this._unloadFileReferences = unloadFileReferences;
			this._chunkSize = Math.max(chunkSize, UploadFileReferenceOperation.MIN_CHUNK_SIZE);
			this.uploadFileReference();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		override public function unload():void
		{
			super.unload();
			this._fileReferenceList = null;
			this._uploadReferences = null;
			this._fileReference = null;
			this._uploadInfo = null;
			this._encoder = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		protected function uploadFileReference():void
		{
			if (this._uploadReferences.length < this._fileReferenceList.fileList.length) {
				this._fileReference = this._fileReferenceList.fileList[this._uploadReferences.length];
				this.uploadChunk();
			} else {
				this.dispatchOperationCompleteEvent(this._uploadReferences);
			}
		}

		protected function uploadChunk():void
		{
			var offset:uint = (this._uploadInfo) ? this._uploadInfo.size : 0;
			var length:uint = Math.min(this._fileReference.data.length - offset, this._chunkSize);
			this._encoder.encodeBytes(this._fileReference.data, offset, length);
			OperationChain
				.create(ChunkUploadOperation, this._encoder.toString(), this._fileReference.size, this._fileReference.name, (this._uploadInfo) ? this._uploadInfo.id : null, this._proxy)
				.addOperationCompleteListener(this.chunkedUploadOperation_operationCompleteHandler)
				.unloadOnOperationComplete();
			;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		protected function chunkedUploadOperation_operationCompleteHandler(event:OperationEvent):void
		{
			this._uploadInfo = event.operation.result;

			var part:Number = 100 / this._fileReferenceList.fileList.length;
			var progress:Number = this._uploadInfo.size / this._fileReference.size * part + this._uploadReferences.length * part;
			this.dispatchOperationProgressEvent(100, Math.round(progress));

			if (this._uploadInfo.size < this._fileReference.size) {
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
				if (this._unloadFileReferences && this._fileReference.data) this._fileReference.data.clear();
				this._uploadReferences.push(uploadReference);
				this._uploadInfo = null;
				this.uploadFileReference();
			}
		}
	}
}