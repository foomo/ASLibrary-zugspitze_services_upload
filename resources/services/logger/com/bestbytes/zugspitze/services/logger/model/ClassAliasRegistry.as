package org.foomo.zugspitze.services.logger.model {

	import flash.net.registerClassAlias;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Report;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Screenshot;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Capabilities;

	public class ClassAliasRegistry 
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------
	
		/**
		 *
		 */
		public static function registerClassAliases():void
		{
			registerClassAlias('Zugspitze.Services.Logger.Report', Report);
			registerClassAlias('Zugspitze.Services.Logger.Screenshot', Screenshot);
			registerClassAlias('Zugspitze.Services.Logger.Capabilities', Capabilities);
		}
	}
}