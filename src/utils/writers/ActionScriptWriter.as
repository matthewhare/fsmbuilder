package utils.writers
{
	import model.diagram.FSMModel;
	import model.diagram.StateVO;
	import model.diagram.TransitionVO;

	public class ActionScriptWriter
	{
		public function ActionScriptWriter()
		{
		}
		
		public function getFileContent(fsm:FSMModel):String
		{
			var result:String = "";

			// create package
			result += packageOpen(fsm.packageName);
			
			// create class
			result += classOpen();
			
			// create consts
			for (var i:int = 0; i < fsm.states.length; i++) 
			{
				result += constLine(fsm.states[i].name); 
			}
			
			if (fsm.states.length>0)
			result += tabIndent(3) + 'public var FSM:XML = <fsm initial="'+fsm.states[0].name+'">' + lineBreak(1);
			
			// loop through states
			for (var j:int = 0; j < fsm.states.length; j++) 
			{
				var state:StateVO = fsm.states[j];
				
				result += stateOpen(state.name)
			
//				if (state.enteringGuard)
					
					
				// do transitions exists?
				if (state.transitions.length > 0)
					
					// loop through them
					for (var k:int = 0; k < state.transitions.length; k++) 
					{
						var transition:TransitionVO = state.transitions[k];
				
						result += transitionLine(transition.action, transition.stateTarget.name)
					}
				
				result += stateClose();
				
			}
			
			result += classClose();
			
			result += packageClose();
			
				
			
			return result;
		}
		
		
		private function tabIndent(value:int):String
		{
			var result:String = "";
			for (var i:int = 0; i < value; i++) 
			{
				result += "\t"		
			}
			
			return result;	
		}
		
		private function lineBreak(value:int):String
		{
			var result:String = "";
			for (var i:int = 0; i < value; i++) 
			{
				result += "\n"		
			}
			
			return result;
		}
		
		private function packageOpen(packageName:String):String
		{
			return "package " + packageName + lineBreak(1) + "{" + lineBreak(2);
		}
		
		private function packageClose():String
		{
			return "}";
		}
		
		private function classOpen():String
		{
			return tabIndent(1) + "class FSMContants" + lineBreak(1) + tabIndent(1) + "{" + lineBreak(1);
		}
		
		private function classClose():String
		{
			return tabIndent(1) + "}" + lineBreak(1);
		}
		
		private function constLine(name:String):String
		{
			return tabIndent(3) + 'public const ' + name.toUpperCase().split(" ").join("_") + ':String = "state/' + name.split(" ").join("") + '";' + lineBreak(2);
		}
		
		private function stateOpen(name:String):String
		{
			return tabIndent(4) + '<state name="{'+name.toUpperCase().split(" ").join("_")+'}">' + lineBreak(1);
		}
		
		private function stateClose():String
		{
			return tabIndent(4) + "</state>" + lineBreak(1);	
		}
		
		private function transitionLine(action:String, target:String):String
		{
			return tabIndent(5) + '<transition action="'+action+'" target="{'+target.toUpperCase().split(" ").join("_")+'"}/>' + lineBreak(1);
		}
		
	}
}