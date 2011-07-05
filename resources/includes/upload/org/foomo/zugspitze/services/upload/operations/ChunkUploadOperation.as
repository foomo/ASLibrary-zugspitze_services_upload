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
	import org.foomo.zugspitze.services.namespaces.php.foomo.zugspitze.services.upload.Info;

	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent;

	import org.foomo.zugspitze.rpc.operations.ProxyMethodOperation;

	[Event(name="ChunkUploadOperationComplete", type="org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent")]
	[Event(name="ChunkUploadOperationProgress", type="org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent")]
	[Event(name="ChunkUploadOperationError", type="org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class ChunkUploadOperation extends ProxyMethodOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function ChunkUploadOperation(chunk:String, totalLength:int, uploadName:String, uploadId:String, proxy:UploadProxy)
		{
			super(proxy, 'chunkUpload', [chunk, totalLength, uploadName, uploadId], ChunkUploadOperationEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():Info
		{
			return this.untypedResult;
		}
	}
}