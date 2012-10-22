package mvcs.model.diagram.vo
{
	[RemoteClass]
	public class TransitionVO
	{
		[Transient]
		private var _stateFrom:StateVO;
		
		[Transient]
		private var _stateTarget:StateVO;
		
		private var _action:String;
		
		public function TransitionVO()
		{
		}

		public function get stateFrom():StateVO
		{
			return _stateFrom;
		}

		public function set stateFrom(value:StateVO):void
		{
			_stateFrom = value;
		}

		public function get stateTarget():StateVO
		{
			return _stateTarget;
		}

		public function set stateTarget(value:StateVO):void
		{
			_stateTarget = value;
		}

		public function get action():String
		{
			return _action;
		}

		public function set action(value:String):void
		{
			_action = value;
		}

		public function toXMLString():String
		{
			if (stateTarget)
			var result:String = '<transition action="'+_action+'" target="'+stateTarget.name+'"}/>';
				
				
			return result;
		}
	}
}