package org.foomo.zugspitze.services.logger.model
{
	import org.foomo.zugspitze.services.rpc.RPCClient;

	public class LoggerProxy extends LoggerProxyBase
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
		private static var _instance:LoggerProxy;
		/**
		 *
		 */
		public static var defaultEndPoint:String = 'http://radact.interact.com/creation/modules/Zugspitze/services/logger.php/Rad.Services.RPC/serve';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------


		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LoggerProxy(endPoint:String=null)
		{
			if(!_instance) _instance = this;
			super((endPoint != null) ? endPoint : defaultEndPoint, 'Zugspitze\\Services\\Logger', VERSION);
			this.loadOperations();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Load and wire operations
		 */
		public function loadOperations():void
		{
			this.operationLog = new LogOperation;
			this.operationLog.proxy = this;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function get defaultInstance():LoggerProxy		{
			if (!_instance) _instance = new LoggerProxy(defaultEndPoint);
			return _instance;
		}
	}
}
