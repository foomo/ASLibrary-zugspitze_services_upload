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
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;

	import org.foomo.memory.IUnload;
	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.operations.Operation;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class BrowseFileReferenceListOperation extends Operation implements IOperation, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const IO_ERROR:String 		= 'ioError';
		public static const SIZE_TOO_BIG:String 	= 'sizeTooBig';
		public static const SIZE_TOO_SMALL:String 	= 'sizeTooSmall';
		public static const SECURITY_ERROR:String 	= 'securityError';
		public static const NO_FILE_SELECTED:String = 'noFileSelected';

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
		private var _maxSize:int;
		/**
		 *
		 */
		private var _minSize:int;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function BrowseFileReferenceListOperation(typeFiler:Array=null, maxSize:int=0, minSize:int=0)
		{
			this._maxSize = maxSize;
			this._minSize = minSize;
			this._fileReferenceList = new FileReferenceList;
			this._fileReferenceList.addEventListener(Event.SELECT, this.fileReferenceList_selectHandler);
			this._fileReferenceList.addEventListener(Event.CANCEL, this.fileReferenceList_cancelHandler);
			this._fileReferenceList.browse(typeFiler);
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
			this._fileReferenceList.removeEventListener(Event.SELECT, this.fileReferenceList_selectHandler);
			this._fileReferenceList.removeEventListener(Event.CANCEL, this.fileReferenceList_cancelHandler);
			this._fileReferenceList = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function fileReferenceList_selectHandler(event:Event):void
		{
			for each (var fileReference:FileReference in this._fileReferenceList.fileList) {
				if (this._maxSize > 0 && this._maxSize < fileReference.size) {
					this.dispatchOperationErrorEvent(SIZE_TOO_BIG);
					return;
				} else if (this._minSize > 0 && this._minSize > fileReference.size) {
					this.dispatchOperationErrorEvent(SIZE_TOO_SMALL);
					return;
				} else {
					// all good
				}
			}
			this.dispatchOperationCompleteEvent(this._fileReferenceList);
			this._fileReferenceList = null;
		}

		/**
		 *
		 */
		protected function fileReferenceList_cancelHandler(event:Event):void
		{
			this.dispatchOperationErrorEvent(NO_FILE_SELECTED);
			this._fileReferenceList = null;
		}
	}
}