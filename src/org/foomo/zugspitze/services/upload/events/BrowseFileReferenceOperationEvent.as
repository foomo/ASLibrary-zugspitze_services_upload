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
package org.foomo.zugspitze.services.upload.events
{
	import flash.events.Event;
	import flash.net.FileReference;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class BrowseFileReferenceOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const BROWSE_FILE_REFERENCE_OPERATION_COMPLETE:String = 'browseFileReferenceOperationComplete';
		public static const BROWSE_FILE_REFERENCE_OPERATION_PROGRESS:String = 'browseFileReferenceOperationProgress';
		public static const BROWSE_FILE_REFERENCE_OPERATION_ERROR:String = 'browseFileReferenceOperationError';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function BrowseFileReferenceOperationEvent(type:String, result:FileReference=null, error:*=null, total:Number=0, progress:Number=0)
		{
			super(type, result, error, total, progress);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():FileReference
		{
			return this.untypedResult;
		}

		/**
		 *
		 */
		public function get error():Event
		{
			return this.untypedError;
		}
	}
}