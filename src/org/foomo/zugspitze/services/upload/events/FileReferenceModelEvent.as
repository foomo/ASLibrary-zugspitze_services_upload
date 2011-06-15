package org.foomo.zugspitze.services.upload.events
{
	import flash.events.Event;

	public class FileReferenceModelEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const FILE_REFERENCE_CHANGED:String 		= 'fileReferenceChanged';
		public static const UPLOAD_REFERENCE_CHANGED:String 	= 'uploadReferenceChanged';
		public static const UPLOAD_REFERENCE_URI_CHANGED:String = 'uploadReferenceUriChanged';

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function FileReferenceModelEvent(type:String)
		{
			super(type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			return new FileReferenceModelEvent(this.type);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString('FileReferenceModelEvent');
		}
	}
}