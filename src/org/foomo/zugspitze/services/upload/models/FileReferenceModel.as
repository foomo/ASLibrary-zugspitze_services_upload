package org.foomo.zugspitze.services.upload.models
{
	import flash.net.FileReference;

	import org.foomo.zugspitze.core.ZugspitzeModel;
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.events.BrowseFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.events.FileReferenceModelEvent;
	import org.foomo.zugspitze.services.upload.events.UploadFileReferenceOperationEvent;
	import org.foomo.zugspitze.services.upload.operations.BrowseFileReferenceOperation;
	import org.foomo.zugspitze.services.upload.operations.LoadFileReferenceOperation;
	import org.foomo.zugspitze.services.upload.operations.UploadFileReferenceOperation;
	import org.foomo.zugspitze.services.upload.vos.UploadReference;

	[Event(name="fileReferenceChanged", type="org.foomo.zugspitze.examples.components.upload.events.FileReferenceModelEvent")]
	[Event(name="uploadReferenceChanged", type="org.foomo.zugspitze.examples.components.upload.events.FileReferenceModelEvent")]
	[Event(name="uploadReferenceUriChanged", type="org.foomo.zugspitze.examples.components.upload.events.FileReferenceModelEvent")]

	public class FileReferenceModel extends ZugspitzeModel
	{
		//-----------------------------------------------------------------------------------------
		// ~ Proxy
		//-----------------------------------------------------------------------------------------

		public var uploadProxy:UploadProxy;

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _uploadReference:UploadReference;

		private var _uploadReferenceURI:String;

		private var _fileReference:FileReference

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function FileReferenceModel(endPoint:String)
		{
			this.uploadProxy = new UploadProxy(endPoint);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public accessor methods
		//-----------------------------------------------------------------------------------------

		[Bindable(event="fileReferenceChanged")]
		public function get fileReference():FileReference
		{
			return this._fileReference;
		}
		public function set fileReference(value:FileReference):void
		{
			if (this._fileReference === value) return;
			this._fileReference = value;
			this.dispatchEvent(new FileReferenceModelEvent(FileReferenceModelEvent.FILE_REFERENCE_CHANGED));
		}

		[Bindable(event="uploadReferenceChanged")]
		public function get uploadReference():UploadReference
		{
			return this._uploadReference;
		}

		[Bindable(event="uploadReferenceUriChanged")]
		public function get uploadReferenceURI():String
		{
			return this._uploadReferenceURI;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function browseFileReference(typeFiler:Array, maxSize:int=0, minSize:int=0):BrowseFileReferenceOperation
		{
			return this.registerOperation(new BrowseFileReferenceOperation(typeFiler, maxSize, minSize),this.browseFileReferenceOperation_resultHandler);
		}

		/**
		 *
		 */
		public function loadFileReference():LoadFileReferenceOperation
		{
			if (!this.fileReference) throw new Error('No file reference present');
			return this.registerOperation(new LoadFileReferenceOperation(this.fileReference));
		}

		/**
		 *
		 */
		public function uploadFileReference():UploadFileReferenceOperation
		{
			if (!this.fileReference) throw new Error('No file reference present');
			return this.registerOperation(new UploadFileReferenceOperation(this.uploadProxy, this.fileReference),this.uploadFileReferenceOperation_resultHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		protected function browseFileReferenceOperation_resultHandler(event:BrowseFileReferenceOperationEvent):void
		{
			if (!event.result) return;
			this.fileReference = event.result;
			this.dispatchEvent(event);
		}

		private function uploadFileReferenceOperation_resultHandler(event:UploadFileReferenceOperationEvent):void
		{
			this._uploadReference = event.result;
			this.dispatchEvent(new FileReferenceModelEvent(FileReferenceModelEvent.UPLOAD_REFERENCE_CHANGED));
			this._uploadReferenceURI = this.uploadReference.getReflectionUri(this.uploadProxy.client.endPoint);
			this.dispatchEvent(new FileReferenceModelEvent(FileReferenceModelEvent.UPLOAD_REFERENCE_URI_CHANGED));
			this.dispatchEvent(event);
		}
	}
}