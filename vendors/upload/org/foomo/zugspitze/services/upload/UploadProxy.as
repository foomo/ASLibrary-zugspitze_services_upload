package org.foomo.zugspitze.services.upload
{
	import org.foomo.zugspitze.zugspitze_internal;
	import org.foomo.zugspitze.services.core.proxy.Proxy;
	import org.foomo.zugspitze.services.upload.calls.ChunkUploadCall;
	import org.foomo.zugspitze.services.upload.calls.CancelChunkUploadCall;
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;

	public class UploadProxy extends Proxy
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const VERSION:Number 		= 0.1;
		public static const CLASS_NAME:String 	= 'Foomo\\Zugspitze\\Services\\Upload';

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static var defaultEndPoint:String = 'http://foomo.radact.interact.com/foomo/index.php/Foomo/showMVCApp/Foomo.Zugspitze.ProxyGenerator/serve';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadProxy(endPoint:String=null)
		{
			super((endPoint != null) ? endPoint : defaultEndPoint, CLASS_NAME, VERSION);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function chunkUpload(chunk:String, totalLength:int, uploadName:String, uploadId:String):ChunkUploadCall
		{
			return zugspitze_internal::sendMethodCall(new ChunkUploadCall(chunk, totalLength, uploadName, uploadId));
		}

		/**
		 *
		 */
		public function cancelChunkUpload(uploadId:String):CancelChunkUploadCall
		{
			return zugspitze_internal::sendMethodCall(new CancelChunkUploadCall(uploadId));
		}
	}
}
