package org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger
{
	// all local imports
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Report;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Screenshot;
	import org.foomo.zugspitze.services.namespaces.php.zugspitze.services.logger.Capabilities;

	[RemoteClass(alias='Zugspitze.Services.Logger.Report')]

	[Bindable]
	public class Report
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------
		public static const LEVEL_FATAL:int = 1000;
		public static const LEVEL_ERROR:int = 8;
		public static const LEVEL_WARN:int = 8;
		public static const LEVEL_INFO:int = 4;
		public static const LEVEL_DEBUG:int = 2;
		public static const LEVEL_ALL:int = 0;
		/**
		 * Set if included in logging setttings | LEVEL_
		 */
		public var level:int;
		/**
		 * Human readable level
		 */
		public var levelName:String;
		/**
		 * Set if included in logging setttings | DD-MM-YYY
		 */
		public var date:String;
		/**
		 * Set if included in logging setttings | HH:MM:SS
		 */
		public var time:String;
		/**
		 * Set if included in logging setttings
		 */
		public var category:String;
		/**
		 * Set if included in logging setttings
		 */
		public var location:String;
		/**
		 * Set if included in logging setttings
		 */
		public var screenshot:Screenshot;
		/**
		 * Set if included in logging setttings
		 */
		public var capabilities:Capabilities;
		/**
		 * The amount of memory (in bytes) currently in use by Adobe® Flash® Player or Adobe® AIR®.
		 */
		public var totalMemory:int;
		/**
		 * Message
		 */
		public var message:String;
	}
}