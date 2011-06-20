package org.foomo.zugspitze.services.logger.model
{
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Capabilities;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Report;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Screenshot;
	import org.foomo.zugspitze.services.proxy.Proxy;

	[Event(name='load', type='mx.rpc.soap.LoadEvent')]

	public class LoggerProxyBase extends Proxy
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		[Bindable]
		public var operationLog:LogOperation;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LoggerProxyBase(endPoint:String, serviceClassName:String, serviceClassVersion:Number, serviceSessionId:String = null)
		{
			super(endPoint, serviceClassName, serviceClassVersion, serviceSessionId)
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Forcing the compiler to include "vectors".
		 * All vector base classes have to be loaded here.
		 */
		public static function forceCompileVectors():void
		{
			var vectors:Array = [Report, Screenshot, Capabilities];
		}
	}
}