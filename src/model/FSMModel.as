package model
{
	[RemoteClass]
	public class FSMModel
	{
		
		private var _states:Vector.<StateVO>;
		
		private var _packageName:String = "org.fsmbuilder.fsm"
		
		
		public function FSMModel()
		{
			_states = new Vector.<StateVO>();
		}
		
		
		public function get packageName():String
		{
			return _packageName;
		}
		
		public function set packageName(value:String):void
		{
			_packageName = value;
		}
		
		public function get states():Vector.<StateVO>
		{
			return _states;
		}

		public function set states(value:Vector.<StateVO>):void
		{
			_states = value;
		}
		
		
		
		/**
		 * create a new state, stores it in the model, and returns it
		 * */
		public function createNewStateVO():StateVO
		{
			var vo:StateVO = new StateVO;
				vo.name = "not set"
			_states.push(vo);
			return vo;
		}
		
		
		/**
		 * removes a states Vo from the model
		 * */
		public function deleteState(vo:StateVO):void
		{
			for (var i:int = 0; i < _states.length; i++) 
			{
				if (_states[i] == vo)
					_states.splice(i,1);
				break;
			}
		}
		
		
		/**
		 * returns the whole FSM as ActionScript
		 * */
		public function getActionScript():String
		{
			if (_states.length < 1)
				return "Please add some states to see the output.";
			
			var result:String = "package mvcs.controller \n{\n\n\tpublic class FSMConstants \n\t{\n";
				result += '\t\tpublic static const FSM:XML = <fsm initial="'+_states[0].name+'">\n\n';
			for (var i:int = 0; i < states.length; i++) 
			{
				result += states[i].toXMLString();
			}
			result += "\n\t}\n}";
			return result;
			
		}



	}
}