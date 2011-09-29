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
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;

	import org.foomo.managers.LogManager;
	import org.foomo.memory.IUnload;
	import org.foomo.zugspitze.operations.ProgressOperation;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class LoadFileReferenceListOperation extends ProgressOperation implements IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _fileReferenceList:FileReferenceList;
		/**
		 *
		 */
		private var _fileReference:FileReference;
		/**
		 *
		 */
		private var _fileReferences:Array = [];

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LoadFileReferenceListOperation(fileReferenceList:FileReferenceList)
		{
			this._fileReferenceList = fileReferenceList;
			this.loadFileReference();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		override public function unload():void
		{
			super.unload();
			this._fileReferenceList = null;
			this._fileReferences = null;
			this._fileReference = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		protected function loadFileReference():void
		{
			if (this._fileReferences.length < this._fileReferenceList.fileList.length) {
				this._fileReference = this._fileReferenceList.fileList[this._fileReferences.length];
				this._fileReference.addEventListener(Event.COMPLETE, this.fileReference_completeHandler);
				this._fileReference.addEventListener(IOErrorEvent.IO_ERROR, this.fileReference_errorHandler);
				this._fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.fileReference_errorHandler);
				this._fileReference.addEventListener(ProgressEvent.PROGRESS, this.fileReference_progressHandler);
				this._fileReference.load();
			} else {
				this.dispatchOperationCompleteEvent(this._fileReferenceList);
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function fileReference_progressHandler(event:ProgressEvent):void
		{
			var part:Number = 100 / this._fileReferenceList.fileList.length;
			var progress:Number = event.bytesLoaded / event.bytesTotal * part + this._fileReferences.length * part;
			this.dispatchOperationProgressEvent(100, Math.round(progress));
		}

		/**
		 *
		 */
		protected function fileReference_completeHandler(event:Event):void
		{
			this._fileReference.removeEventListener(Event.COMPLETE, this.fileReference_completeHandler);
			this._fileReference.removeEventListener(IOErrorEvent.IO_ERROR, this.fileReference_errorHandler);
			this._fileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.fileReference_errorHandler);
			this._fileReference.removeEventListener(ProgressEvent.PROGRESS, this.fileReference_progressHandler);
			this._fileReferences.push(this._fileReference);
			this.loadFileReference();
		}

		/**
		 *
		 */
		protected function fileReference_errorHandler(event:Event):void
		{
			this._fileReference.removeEventListener(Event.COMPLETE, this.fileReference_completeHandler);
			this._fileReference.removeEventListener(IOErrorEvent.IO_ERROR, this.fileReference_errorHandler);
			this._fileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.fileReference_errorHandler);
			this._fileReference.removeEventListener(ProgressEvent.PROGRESS, this.fileReference_progressHandler);
			LogManager.warn(this, 'Could not load local file: {0}', event['text']);
			this.loadFileReference();
		}
	}
}