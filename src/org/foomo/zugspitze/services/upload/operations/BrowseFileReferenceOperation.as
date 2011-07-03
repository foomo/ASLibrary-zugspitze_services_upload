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
	import flash.net.FileReference;

	import org.foomo.flash.core.IUnload;
	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.operations.Operation;
	import org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent;

	[Event(name="browseFileReferenceOperationComplete", type="org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent")]
	[Event(name="browseFileReferenceOperationProgress", type="org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent")]
	[Event(name="browseFileReferenceOperationError", type="org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
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