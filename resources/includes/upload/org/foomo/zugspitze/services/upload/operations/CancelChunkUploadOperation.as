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
package org.foomo.zugspitze.services.upload.operations
{
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent;

	import org.foomo.zugspitze.rpc.operations.ProxyMethodOperation;

	[Event(name="CancelChunkUploadOperationComplete", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent")]
	[Event(name="CancelChunkUploadOperationProgress", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent")]
	[Event(name="CancelChunkUploadOperationError", type="org.foomo.zugspitze.services.upload.events.CancelChunkUploadOperationEvent")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class CancelChunkUploadOperation extends ProxyMethodOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function CancelChunkUploadOperation(uploadId:String, proxy:UploadProxy)
		{
			super(proxy, 'cancelChunkUpload', [uploadId], CancelChunkUploadOperationEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():Boolean
		{
			return this.untypedResult;
		}
	}
}