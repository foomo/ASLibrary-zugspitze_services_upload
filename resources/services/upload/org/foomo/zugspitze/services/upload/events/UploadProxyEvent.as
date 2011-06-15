package org.foomo.zugspitze.services.upload.events
{
	import org.foomo.zugspitze.services.proxy.ProxyMethod;

	import flash.events.Event;

	import org.foomo.zugspitze.operations.IProgressOperation;

	public class UploadProxyEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const CHUNK_UPLOAD_METHOD_COMPLETE:String = "chunkUploadMethodComplete";
		public static const CHUNK_UPLOAD_METHOD_PROGRESS:String = "chunkUploadMethodProgress";
		public static const CHUNK_UPLOAD_METHOD_ERROR:String 	= "chunkUploadMethodError";

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _method:ProxyMethod;
		/**
		 *
		 */
		private var _operation:IProgressOperation;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadProxyEvent(type:String, method:ProxyMethod, operation:IProgressOperation)
		{
			this._method = method;
			super(type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get method():ProxyMethod
		{
			return this._method;
		}

		/**
		 *
		 */
		public function get operation():IProgressOperation
		{
			return this._operation;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		public override function clone():Event
		{
			return new UploadProxyEvent(this.type, this._method, this._operation);
		}

		/**
		 * @inherit
		 */
		public override function toString():String
		{
			return formatToString("UploadProxyEvent");
		}
	}
}