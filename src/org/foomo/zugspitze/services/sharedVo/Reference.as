package org.foomo.zugspitze.services.sharedVo
{
	/**
	 * value object containing flash client side of an uploaded file plus its uploadId
	 */
	[RemoteClass(alias="Zugspitze.Services.Upload.Reference")]
	public class Reference
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * upload id - references the upload on the server
		 */
		public var id:String;
		/**
		 * name of the creator
		 */
		public var creator:String;
		/**
		 * extension of the file air only
		 */
		public var extension:String;
		/**
		 * name on the local disk
		 */
		public var name:String;
		/**
		 * a flash mess
		 */
		public var type:String;
		/**
		 * filesize in bytes
		 */
		public var size:int;
		/**
		 * date of creation
		 */
		public var creationDate:int;
		/**
		 * date of last mod
		 */
		public var modificationDate:int;

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * if you want to download the file, here it is - only works in your session from your IP
		 *
		 * @param download if true, file will be offered as a download
		 */
		public function getReflectionUri(endPoint:String, download:Boolean=false):String
		{
			var uri:String = endPoint.substring(0, endPoint.search('/services/upload.php')) + '/upload.php?id=' + this.id;
			if (download) uri += '&amp;d';
			return uri;
		}
	}
}