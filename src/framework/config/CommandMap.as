package framework.config
{
	import framework.events.CommandEvent;
	
	import mvcs.controller.application.FileLoadCommand;
	import mvcs.controller.application.FileSaveCommand;
	
	import org.swizframework.utils.commands.CommandMap;
	
	public class CommandMap extends org.swizframework.utils.commands.CommandMap
	{
		public function CommandMap()
		{
			super();
		}
		
		override protected function mapCommands() : void
		{
			mapCommand( CommandEvent.COMMAND_FILE_LOAD, FileLoadCommand );
			mapCommand( CommandEvent.COMMAND_FILE_SAVE, FileSaveCommand );
		}
	}
}