package mvcs.model.definitions
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mvcs.services.FileSystemSearchService;

	public class DefinitionsModel
	{
		protected const DEFINITIONS_URL:String = File.applicationDirectory.nativePath +"/definitions/"
		protected const DEFINITIONS_URL_APP:String = "/definitions/"
		
		public var definitions:XMLList;
		
		public function DefinitionsModel()
		{
			definitions = new XMLList();
			definitionsLoad();
		}
		
		public function definitionsLoad():void
		{
			var search:FileSystemSearchService = new FileSystemSearchService();
				search.addEventListener("searchComplete", definitionsFound);
				search.search(DEFINITIONS_URL, ".xml");
		}

		protected function definitionsFound(event:Event):void
		{
			var search:FileSystemSearchService = event.target as FileSystemSearchService;
			for (var i:int = 0; i < search.resultData.length; i++) 
			{
				var path:String = DEFINITIONS_URL_APP + File(search.resultData[i]).name;
				var loader:URLLoader = new URLLoader(new URLRequest(path));
					loader.addEventListener(Event.COMPLETE, definitionLoaded);
			}
		}
		
		protected function definitionLoaded(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var	xml:XML = new XML(loader.data);
				definitions[definitions.length()] = xml;
		}
	}
}