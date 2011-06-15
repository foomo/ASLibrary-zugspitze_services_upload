package org.foomo.zugspitze.services.upload.model
{
	import org.foomo.zugspitze.services.events.ProxyMethodEvent;
	import org.foomo.zugspitze.services.proxy.Proxy;
	import org.foomo.zugspitze.services.upload.events.UploadProxyEvent;

	import org.foomo.zugspitze.core.IUnload;

	public class UploadProxy extends Proxy implements IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const VERSION:Number = 0.1;

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static var defaultEndPoint:String = 'http://radact.interact.com/creation/modules/Zugspitze/services/upload.php/Rad.Services.RPC/serve';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _chunkUploadMethod:ChunkedUploadMethod;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadProxy(endPoint:String=null)
		{
			super((endPoint != null) ? endPoint : defaultEndPoint, 'Zugspitze\\Services\\Upload', VERSION);

			this._chunkUploadMethod = new ChunkedUploadMethod(this);
			this._chunkUploadMethod.addEventListener(ProxyMethodEvent.METHOD_CALL_ERROR, this.chunkUploadMethod_methodCallErrorHandler);
			this._chunkUploadMethod.addEventListener(ProxyMethodEvent.METHOD_CALL_COMPLETE, this.chunkUploadMethod_methodCallCompleteEventHandler);
			this._chunkUploadMethod.addEventListener(ProxyMethodEvent.METHOD_CALL_PROGRESS, this.chunkUploadMethod_methodCallProgressHandler)
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get chunkUploadMethod():ChunkedUploadMethod
		{
			return this._chunkUploadMethod;
		}

		/**
		 *
		 */
		public function unload():void
		{
			this._chunkUploadMethod.removeEventListener(ProxyMethodEvent.METHOD_CALL_ERROR, this.chunkUploadMethod_methodCallErrorHandler);
			this._chunkUploadMethod.removeEventListener(ProxyMethodEvent.METHOD_CALL_COMPLETE, this.chunkUploadMethod_methodCallCompleteEventHandler);
			this._chunkUploadMethod.removeEventListener(ProxyMethodEvent.METHOD_CALL_PROGRESS, this.chunkUploadMethod_methodCallProgressHandler)
			this._chunkUploadMethod = null
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function chunkUploadMethod_methodCallProgressHandler(event:ProxyMethodEvent):void
		{
			this.dispatchEvent(new UploadProxyEvent(UploadProxyEvent.CHUNK_UPLOAD_METHOD_PROGRESS, event.method, event.operation));
			this.dispatchProxyMethodEvent(event);
		}

		/**
		 *
		 */
		protected function chunkUploadMethod_methodCallCompleteEventHandler(event:ProxyMethodEvent):void
		{
			this.dispatchEvent(new UploadProxyEvent(UploadProxyEvent.CHUNK_UPLOAD_METHOD_COMPLETE, event.method, event.operation));
			this.dispatchProxyMethodEvent(event);
		}

		/**
		 *
		 */
		protected function chunkUploadMethod_methodCallErrorHandler(event:ProxyMethodEvent):void
		{
			this.dispatchEvent(new UploadProxyEvent(UploadProxyEvent.CHUNK_UPLOAD_METHOD_ERROR, event.method, event.operation));
			this.dispatchProxyMethodEvent(event);
		}
	}
}
