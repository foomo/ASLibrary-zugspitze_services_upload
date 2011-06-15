package org.foomo.zugspitze.services.upload.model
{
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.upload.Info;
	import org.foomo.zugspitze.services.proxy.Proxy;
	import org.foomo.zugspitze.services.proxy.ProxyMethod;
	import org.foomo.zugspitze.services.upload.operations.ChunkUploadOperation;

	import org.foomo.zugspitze.operations.IOperation;

	public class ChunkedUploadMethod extends ProxyMethod
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ChunkedUploadMethod(proxy:Proxy)
		{
			super(proxy);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public accessor methods
		//-----------------------------------------------------------------------------------------

		public function get result():Info
		{
			return this._result;
		}
		public function set result(value:Info):void
		{
			this._result = value;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function call(chunk:String, totalLength:int, uploadName:String, uploadId:String, completeHandler:Function=null, progressHandler:Function=null, errorHandler:Function=null):IOperation
		{
			return this.runOperation(new ChunkUploadOperation(this._proxy.rpcClient, chunk, totalLength, uploadName, uploadId), completeHandler, progressHandler, errorHandler);
		}
	}
}