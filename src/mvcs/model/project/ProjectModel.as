package mvcs.model.project
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import framework.events.PayloadEvent;
	
	import mvcs.model.project.vo.ClassGroupVO;
	import mvcs.model.project.vo.SearchFileVO;
	import mvcs.services.FileSystemSearchService;
	
	import mx.collections.ArrayCollection;


	public class ProjectModel
	{
		private var _framework:String;
		private var _frameworkDefinitions:XML;
		private var _frameworkDefinitionDetected:XML;

		private var _projectRoot:String;
		private var _projectSource:String;
		
		private var _classes:ArrayCollection;
		
		
		public function ProjectModel()
		{
		}
		
		// search source
		protected function searchSource():void
		{
			var classes:ArrayCollection = new ArrayCollection([]);
			var frameworkName:String = _frameworkDefinitionDetected.@name;
			// find groups / root nodes for files
			var groupNames:XMLList = _frameworkDefinitions.framework.(@name==frameworkName).classes.group.@name
			
			for (var i:int = 0; i < groupNames.length(); i++) 
			{
				var classGroup:ClassGroupVO = new ClassGroupVO();
					classGroup.name = groupNames[i];
					classGroup.searchDirectory = _projectSource;
					classGroup.fileContentPattern = _frameworkDefinitions.framework.(@name==frameworkName).classes.group.(@name==groupNames[i]).match.(@type=="content").text()
					classGroup.filenamePattern = _frameworkDefinitions.framework.(@name==frameworkName).classes.group.(@name==groupNames[i]).match.(@type=="filename").text()	
					classGroup.validate();
				classes.source.push(classGroup);
			}

				
			this.classes = classes;
		}
		
		protected function frameworkDetect():void
		{
			framework = "Not Known";
			
			var folders:Array = ["lib", "libs"];
			var frameworks:XMLList = frameworkDefinitions..framework.library.group.match.(@type == "filename").text();	// swc package names
			
			for (var i:int = 0; i < folders.length; i++) 
			{
				for (var j:int = 0; j < frameworks.length(); j++) 
				{
					var frameworkSearch:FileSystemSearchService = new FileSystemSearchService();
						frameworkSearch.addEventListener("searchFound", frameworkUpdate)
						frameworkSearch.data = frameworkDefinitions..framework[j];
						frameworkSearch.search(_projectRoot + "/" + folders[i], frameworks[j]);
				}
				
			}
		}
		
		protected function frameworkUpdate(event:PayloadEvent):void
		{
			var search:FileSystemSearchService = FileSystemSearchService(event.target)
			_frameworkDefinitionDetected = search.data as XML;
			framework = "("+File(event.payload).name.replace(/(-framework-)|(-)|(.swc)/g," ").substr(0,-1)+")";
			searchSource();
		}

		
		// set source URL
		[Bindable]
		public function get projectRoot():String
		{
			return _projectRoot;
		}
		
		public function set projectRoot(value:String):void
		{
			_projectRoot = value;
			_projectSource = value + "/src"
			frameworkDetect();
		}
	
		[Bindable]
		public function get framework():String
		{
			return _framework;
		}

		public function set framework(value:String):void
		{
			_framework = value;
		}

		public function get frameworkDefinitions():XML
		{
			return _frameworkDefinitions;
		}

		public function set frameworkDefinitions(value:XML):void
		{
			_frameworkDefinitions = value;
		}

		[Bindable]
		public function get classes():ArrayCollection
		{
			return _classes;
		}

		public function set classes(value:ArrayCollection):void
		{
			_classes = value;
		}

	}
}