package mvcs.controller.application
{
	import mvcs.model.diagram.FSMModel;
	import mvcs.model.project.ProjectModel;
	
	import org.swizframework.utils.commands.ICommand;
	
	import mvcs.utils.system.FileIOService;

	public class FileSaveCommand implements ICommand
	{
		public function FileSaveCommand()
		{
		}
		
		[Inject]
		public var fileIOService:FileIOService
		
		[Inject]
		public var fsmModel:FSMModel;
		
		[Inject]
		public var projectModel:ProjectModel;
		
		public function execute():void
		{
			fileIOService.writeObjectToFile(fsmModel, "FSMModel.fsm", projectModel.sourceURL);
		}
	}
}