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
package org.foomo.zugspitze.services.upload.commands
{
	import org.foomo.zugspitze.services.upload.UploadProxy;
	import org.foomo.zugspitze.services.upload.calls.CancelChunkUploadCall;
	import org.foomo.zugspitze.services.upload.events.CancelChunkUploadCallEvent;
	
	import org.foomo.zugspitze.commands.Command;
	import org.foomo.zugspitze.commands.ICommand;
	import org.foomo.core.IUnload;

	/**
	 * Create your own command instance and override the protected event handlers
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class AbstractCancelChunkUploadCommand extends Command implements ICommand, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Service proxy
		 */
		public var proxy:UploadProxy;
		/**
		 * 
		 */
		public var uploadId:String;
		/**
		 * Returned call from the proxy
		 */
		protected var _methodCall:CancelChunkUploadCall;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * @param uploadId ;
		 * @param proxy Service proxy
		 * @param setBusyStatus Set busy status while pending
		 */
		public function AbstractCancelChunkUploadCommand(uploadId:String, proxy:UploadProxy, setBusyStatus:Boolean=false)
		{
			this.uploadId = uploadId;
			this.proxy = proxy;
			super(setBusyStatus);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @see org.foomo.zugspitze.commands.ICommand
		 */
		public function execute():void
		{
			this._methodCall = this.proxy.cancelChunkUpload(this.uploadId);
			this._methodCall.addEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_ERROR, this.abstractErrorHandler);
			this._methodCall.addEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_PROGRESS, this.abstractProgressHandler);
			this._methodCall.addEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_COMPLETE, this.abstractCompleteHandler);
		}

		/**
		 * @see org.foomo.flash.core.IUnload
		 */
		public function unload():void
		{
			this.proxy = null;
			this.uploadId = '';
			if (this._methodCall) {
				this._methodCall.removeEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_ERROR, this.abstractErrorHandler);
				this._methodCall.removeEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_PROGRESS, this.abstractProgressHandler);
				this._methodCall.removeEventListener(CancelChunkUploadCallEvent.CANCEL_CHUNK_UPLOAD_CALL_COMPLETE, this.abstractCompleteHandler);
				this._methodCall = null;
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 * Handle method call progress
		 *
		 * @param event Method call event
		 */
		protected function abstractProgressHandler(event:CancelChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
		}

		/**
		 * Handle method call result
		 *
		 * @param event Method call event
		 */
		protected function abstractCompleteHandler(event:CancelChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
			this.dispatchCommandCompleteEvent();
		}

		/**
		 * Handle method call error
		 *
		 * @param event Method call event
		 */
		protected function abstractErrorHandler(event:CancelChunkUploadCallEvent):void
		{
			// Overwrite this method in your implementation class
			this.dispatchCommandErrorEvent(event.error);
		}
	}
}