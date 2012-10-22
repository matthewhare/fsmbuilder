package mvcs.controller.application
{
	import mvcs.model.diagram.FSMModel;
	import mvcs.model.project.ProjectModel;
	
	import org.swizframework.utils.commands.ICommand;
	
	import mvcs.utils.system.FileIOService;

	public class FileLoadCommand implements ICommand
	{
		
		[Inject]
		public var fileIOService:FileIOService
		
		[Inject]
		public var fsmModel:FSMModel;
		
		[Inject]
		public var projectModel:ProjectModel;
		
		
		public function FileLoadCommand()
		{
		}
		
		public function execute():void
		{
			fsmModel = fileIOService.readObjectFromFile("FSMModel.fsm") as FSMModel;
		}
	}
}