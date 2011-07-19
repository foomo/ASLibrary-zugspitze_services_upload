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
package org.foomo.zugspitze.services.upload.calls
{
	import org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent;
	import org.foomo.zugspitze.rpc.calls.ProxyMethodCall;

	[Event(name="cancelChunkUploadCallComplete", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent")]
	[Event(name="cancelChunkUploadCallProgress", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent")]
	[Event(name="cancelChunkUploadCallError", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class CancelChunkUploadCall extends ProxyMethodCall
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const METHOD_NAME:String = 'cancelChunkUpload';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CancelChunkUploadCall(uploadId:String)
		{
			super(METHOD_NAME, [uploadId], CancelChunkUploadCallEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Method call result
		 */
		public function get result():Boolean
		{
			return this.methodReply.value;
		}
	}
}