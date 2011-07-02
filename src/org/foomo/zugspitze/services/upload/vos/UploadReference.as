/*
 * This file is part of the foomo Opensource Framework.
 *
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */
package org.foomo.zugspitze.services.upload.vos
{
	[RemoteClass(alias="Foomo.Zugspitze.Upload.UploadReference")]
	
	/**
	 * value object containing flash client side of an uploaded file plus its uploadId
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class UploadReference
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