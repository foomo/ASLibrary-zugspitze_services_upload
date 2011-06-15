package org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger
{
	// all local imports
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Report;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Screenshot;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Capabilities;

	/**
	 * Set if included in logging setttings
	 */
	[RemoteClass(alias='Zugspitze.Services.Logger.Screenshot')]

	[Bindable]
	public class Screenshot
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------
		/**
		 * Base64Encoded JPG screenshot
		 */
		public var base64String:String;
	}
}