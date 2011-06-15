package org.foomo.zugspitze.services.upload.operations
{
	import org.foomo.zugspitze.services.operations.RPCClientMethodCallOperation;
	import org.foomo.zugspitze.services.rpc.RPCClient;
	import org.foomo.zugspitze.services.upload.*;
	import org.foomo.zugspitze.services.upload.events.ChunkUploadOperationEvent;

	public class ChunkUploadOperation extends RPCClientMethodCallOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function ChunkUploadOperation(rpcClient:RPCClient, chunk:String, totalLength:int, uploadName:String, uploadId:String)
		{
			super(rpcClient, 'chunkUpload', [chunk, totalLength, uploadName, uploadId], ChunkUploadOperationEvent)
		}
	}
}