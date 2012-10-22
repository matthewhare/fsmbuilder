package framework.events
{
	import flash.events.Event;

	public class PayloadEvent extends Event
	{
		private var _payload:Object;

		public function PayloadEvent(type:String, payload:Object)
		{
			super(type,false,false);

			this._payload = payload;
		}

		public function get payload():Object
		{
			return _payload;
		}

		public override function clone():Event
		{
			return new PayloadEvent(type,payload);
		}

		public override function toString():String
		{
			return formatToString("PayloadEvent","payload");
		}
	}
}