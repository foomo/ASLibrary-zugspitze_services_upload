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
package org.foomo.zugspitze.services.upload.commands
{
	import flash.events.Event;

	import org.foomo.core.IUnload;
	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.events.LoadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.events.UploadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.models.FileReferenceModel;
	import org.foomo.zugspitze.utils.OperationUtil;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class SelectAndUploadFileCommand extends Command implements ICommand, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public var model:FileReferenceModel;
		/**
		 *
		 */
		public var typeFilter:Array;
		/**
		 *
		 */
		public var maxSize:int;
		/**
		 *
		 */
		public var minSize:int

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function SelectAndUploadFileCommand(fileReferenceModel:FileReferenceModel, typeFilter:Array, maxSize:int=0, minSize:int=0, setBusyStatus:Boolean=false)
		{
			this.model = fileReferenceModel;
			this.typeFilter = typeFilter;
			this.maxSize = maxSize;
			this.minSize = minSize;

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
			OperationUtil.register(this.model.browseFileReference(this.typeFilter, maxSize,  minSize), this.model_operationCompleteHandler, model_operationErrorHandler);
		}

		/**
		 * @see org.foomo.zugspitze.core.IUnload
		 */
		public function unload():void
		{
			this.model = null;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		private function model_operationCompleteHandler(event:Event):void
		{
			switch (true) {
				case (event is BrowseFileReferenceOperationEvent):
					OperationUtil.register(this.model.loadFileReference(), this.model_operationCompleteHandler, model_operationErrorHandler);
					break;
				case (event is LoadFileReferenceOperationEvent):
					OperationUtil.register(this.model.uploadFileReference(), this.model_operationCompleteHandler, model_operationErrorHandler);
					break;
				case (event is UploadFileReferenceOperationEvent):
					this.dispatchCommandCompleteEvent();
					break;
				default:
					throw new Error('Unhandled usecase');
					break;
			}
		}

		private function model_operationErrorHandler(event:OperationEvent):void
		{
			this.dispatchCommandCompleteEvent();
		}
	}
}