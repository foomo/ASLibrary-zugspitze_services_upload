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
package org.foomo.zugspitze.services.upload
{
	import org.foomo.zugspitze.zugspitze_internal;
	import org.foomo.zugspitze.rpc.Proxy;
	import org.foomo.zugspitze.services.upload.calls.ChunkUploadCall;
	import org.foomo.zugspitze.services.upload.calls.CancelChunkUploadCall;
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class UploadProxy extends Proxy
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const VERSION:Number 		= 0.1;
		public static const CLASS_NAME:String 	= 'Foomo\\Zugspitze\\Services\\Upload';

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private static var _instance:UploadProxy;
		/**
		 *
		 */
		public static var defaultEndPoint:String = "http://foomo.radact.interact.com/foomo/modules/Foomo.Zugspitze/services/upload.php/Foomo.Services.RPC/serve";

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UploadProxy(endPoint:String=null)
		{
			if (endPoint == null) endPoint = defaultEndPoint;
			super(endPoint, CLASS_NAME, VERSION);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function chunkUpload(chunk:String, totalLength:int, uploadName:String, uploadId:String):ChunkUploadCall
		{
			return zugspitze_internal::sendMethodCall(new ChunkUploadCall(chunk, totalLength, uploadName, uploadId));
		}

		/**
		 *
		 */
		public function cancelChunkUpload(uploadId:String):CancelChunkUploadCall
		{
			return zugspitze_internal::sendMethodCall(new CancelChunkUploadCall(uploadId));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function get defaultInstance():UploadProxy		{
			if (!_instance) _instance = new UploadProxy(defaultEndPoint);
			return _instance;
		}
	}
}
