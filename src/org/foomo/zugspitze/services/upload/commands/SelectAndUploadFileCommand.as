package org.foomo.zugspitze.services.upload.commands
{
	import flash.events.Event;

	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.events.LoadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.events.UploadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.models.FileReferenceModel;
	import org.foomo.zugspitze.utils.OperationUtils;

	/**
	 *
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
			OperationUtils.register(this.model.browseFileReference(this.typeFilter, maxSize,  minSize), this.model_operationCompleteHandler, model_operationErrorHandler);
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
					OperationUtils.register(this.model.loadFileReference(), this.model_operationCompleteHandler, model_operationErrorHandler);
					break;
				case (event is LoadFileReferenceOperationEvent):
					OperationUtils.register(this.model.uploadFileReference(), this.model_operationCompleteHandler, model_operationErrorHandler);
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