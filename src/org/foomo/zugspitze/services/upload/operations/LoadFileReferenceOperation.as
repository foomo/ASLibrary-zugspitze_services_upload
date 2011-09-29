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

	import org.foomo.memory.IUnload;
	import org.foomo.zugspitze.operations.ProgressOperation;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class LoadFileReferenceOperation extends ProgressOperation implements IUnload
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
			this._fileReference = fileReference;
			this._fileReference.addEventListener(Event.COMPLETE, this.fileReference_completeHandler);
			this._fileReference.addEventListener(IOErrorEvent.IO_ERROR, this.fileReference_errorHandler);
			this._fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.fileReference_errorHandler);
			this._fileReference.addEventListener(ProgressEvent.PROGRESS, this.fileReference_progressHandler);
			this._fileReference.load();
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
			this._fileReference = null;
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