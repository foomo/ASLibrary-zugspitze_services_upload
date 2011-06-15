package org.foomo.zugspitze.services.upload.commands
{
	import org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.events.LoadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.events.UploadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.models.FileReferenceModel;

	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.events.OperationEvent;

	public class SelectAndUploadFileCommand extends Command implements ICommand, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		public var model:FileReferenceModel;
		public var typeFilter:Array;
		public var maxSize:int;
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

		public function execute():void
		{
			this.model.addEventListener(OperationEvent.OPERATION_COMPLETE, this.model_operationCompleteHandler);
			this.model.addEventListener(OperationEvent.OPERATION_ERROR, this.model_operationErrorHandler);
			this.model.browse(this.typeFilter, maxSize,  minSize);

		}

		public function unload():void
		{
			this.model.removeEventListener(OperationEvent.OPERATION_COMPLETE, this.model_operationCompleteHandler);
			this.model.addEventListener(OperationEvent.OPERATION_ERROR, this.model_operationErrorHandler);
			this.model = null;
		}

		private function model_operationCompleteHandler(event:OperationEvent):void
		{
			switch (true) {
				case (event is BrowseFileReferenceOperationEvent):
					this.model.loadFileReference()
					break;
				case (event is LoadFileReferenceOperationEvent):
					this.model.uploadFileReference()
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