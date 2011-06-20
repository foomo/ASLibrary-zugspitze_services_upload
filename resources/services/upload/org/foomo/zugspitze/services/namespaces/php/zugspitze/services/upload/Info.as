package org.foomo.zugspitze.services.namespaces.php.zugspitze.services.upload
{
	/**
	 * Class describing a file upload
	 * be careful wit these data, they are user input
	 */
	[RemoteClass(alias='Zugspitze.Services.Upload.Info')]

	[Bindable]
	public class Info
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------
		/**
		 * name of the file on the client computer
		 */
		public var name:String;
		/**
		 * mime type of the file - do not necessarily trust this
		 */
		public var mimeType:String;
		/**
		 * you may want to use self::moveTo() instead
		 * temporary location of the file, if you want to use it, then move it from here
		 */
		public var tempName:String;
		/**
		 * error
		 */
		public var error:int;
		/**
		 * file size of the upload
		 */
		public var size:int;
		/**
		 * id of the upload
		 */
		public var id:String;
		/**
		 * time stamp when the file was uploaded
		 */
		public var uploadTime:int;
		/**
		 * session in which the file was uploaded
		 */
		public var uploadSessionId:String;
		/**
		 * ip the file is coming from
		 */
		public var uploadIp:String;
	}
}