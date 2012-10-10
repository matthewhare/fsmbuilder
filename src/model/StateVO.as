package model
{
	import model.DiagramPoint;

	[RemoteClass]
	public class StateVO
	{
		
		private var _name:String;
		
		private var _enteringGuard:String
		private var _exitGuard:String
		private var _entered:String
		private var _teardown:String;
		private var _cancelled:String;
		private var _changed:String;
		
		private var _viewCoords:DiagramPoint = new DiagramPoint(0,0);
		private var _viewColour:int;
		
		private var _transitions:Vector.<TransitionVO>
		
		
		public function StateVO()
		{
			_transitions = new Vector.<TransitionVO>();
		}
		
		
		[Bindable]
		public function get name():String
		{
			trace('StateVO::name: get ['+_name+']');
			return _name;
		}

		public function set name(value:String):void
		{
			trace('StateVO::name: set ['+value+']');
			_name = value;
		}
		
		[Bindable]		
		public function get enteringGuard():String
		{
			return _enteringGuard;
		}

		public function set enteringGuard(value:String):void
		{
			_enteringGuard = value;
		}
		
		[Bindable]
		public function get exitGuard():String
		{
			return _exitGuard;
		}

		public function set exitGuard(value:String):void
		{
			_exitGuard = value;
		}
		
		[Bindable]
		public function get entered():String
		{
			return _entered;
		}

		public function set entered(value:String):void
		{
			_entered = value;
		}

		[Bindable]
		public function get teardown():String
		{
			return _teardown;
		}

		public function set teardown(value:String):void
		{
			_teardown = value;
		}

		[Bindable]
		public function get cancelled():String
		{
			return _cancelled;
		}

		public function set cancelled(value:String):void
		{
			_cancelled = value;
		}

		[Bindable]
		public function get changed():String
		{
			return _changed;
		}

		public function set changed(value:String):void
		{
			_changed = value;
		}

		/**
		 * returns the states as an XML String
		 * */
		public function toXMLString():String
		{
			var result:String =
				'\t\t<state name="'+_name+'">';
				
			if (_enteringGuard && _enteringGuard.length > 0)
				result += '\n\t\t\t<enterguard>\n\t\t\t\t<commandClass classPath="'+_enteringGuard+'"/>\n\t\t\t</enterguard>'
			
			if (_exitGuard && _exitGuard.length > 0)
				result += '\n\t\t\t<exitingguard>\n\t\t\t\t<commandClass classPath="'+_exitGuard+'"/>\n\t\t\t</exitingguard>'
			
			if (_entered && _entered.length > 0)
				result += '\n\t\t\t<entered>\n\t\t\t\t<commandClass classPath="'+_entered+'"/>\n\t\t\t</entered>'
			
			if (_cancelled && _cancelled.length > 0)
				result += '\n\t\t\t<cancelled>\n\t\t\t\t<commandClass classPath="'+_cancelled+'"/>\n\t\t\t</cancelled>'
			
			if (_changed && _changed.length > 0)
				result += '\n\t\t\t<changed>\n\t\t\t\t<commandClass classPath="'+_changed+'"/>\n\t\t\t</changed>'
			
			if (_teardown && _teardown.length > 0)
				result += '\n\t\t\t<teardown>\n\t\t\t\t<commandClass classPath="'+_teardown+'"/>\n\t\t\t</teardown>'
			
				result += '\n';
			// transitions
			if (_transitions)
				for each (var i:int in _transitions) 
				{
				result += "\t\t\t" + _transitions[i].toXMLString() + "\n";
				}
			
					
				result += "\n\t\t</state>\n";
			
			return result;
		}

		[Bindable]
		public function get viewCoords():DiagramPoint
		{
			return _viewCoords;
		}

		public function set viewCoords(value:DiagramPoint):void
		{
			_viewCoords = value;
		}

		[Bindable]
		public function get viewColour():int
		{
			return _viewColour;
		}

		public function set viewColour(value:int):void
		{
			_viewColour = value;
		}
		
		public function addTransition(vo:TransitionVO):void
		{
			for (var i:int = 0; i < _transitions.length; i++) 
			{
				if (_transitions[i] == vo)
					return;
			}
			trace("StateVO::addTransition state["+this.name+"]")
			_transitions.push(vo);
		}
		
		public function removeTranstion(vo:TransitionVO):void
		{
			for (var i:int = 0; i < _transitions.length; i++) 
			{
				if (_transitions[i] == vo)
				{
					_transitions.splice(i,1);
					return
				}
			}
		}

		public function get transitions():Vector.<TransitionVO>
		{
			return _transitions;
		}

		public function set transitions(value:Vector.<TransitionVO>):void
		{
			_transitions = value;
		}

		
	}
}