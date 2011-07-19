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
package org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload
{
									
	[Bindable]
	[RemoteClass(alias='Foomo.Zugspitze.Services.Upload.Info')]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class Info	{
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