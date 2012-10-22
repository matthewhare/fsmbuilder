package framework.events
{
	import flash.events.Event;

	public class CommandEvent extends Event
	{
		public static const COMMAND_FILE_LOAD:String = "commandFileLoad";
		public static const COMMAND_FILE_SAVE:String = "commandFileSave";

		private var _payload:Object;
		private var _payloadType:Class;

		public function CommandEvent(type:String, payload:Object=null, payloadType:Class=null)
		{
			super(type,false,false);

			this._payload = payload;
			this._payloadType = payloadType;
		}

		public function get payload():Object
		{
			return _payload;
		}

		public function get payloadType():Class
		{
			return _payloadType;
		}

		public override function clone():Event
		{
			return new CommandEvent(type,payload,payloadType);
		}

		public override function toString():String
		{
			return formatToString("CommandEvent","payload","payloadType");
		}
	}
}