package mvcs.model.definitions
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mvcs.services.FileSystemSearchService;

	public class DefinitionsModel
	{
		private const DEFINITIONS_URL:String = File.applicationDirectory.nativePath +"/definitions/"
		
		public function DefinitionsModel()
		{
			definitionsLoad();
		}
		
		public function definitionsLoad():void
		{
			var fileSearch:FileSystemSearchService = new FileSystemSearchService();
				fileSearch.addEventListener("seachComplete", definitionsFound);
				fileSearch.search(DEFINITIONS_URL, ".xml");
		}

		private function definitionsFound(event:Event):void
		{
			var e:Event = event;	
		}
	}
}