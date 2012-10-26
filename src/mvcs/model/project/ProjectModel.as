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
		private var _frameworkDefinitions:XML;
		private var _frameworkMatched:XML;
		private var _projectRoot:String;
		private var _projectSource:String;
		private var _framework:String;
		private var _classes:ArrayCollection;
		
		private var _controllers:ArrayCollection
		private var _models:ArrayCollection
		private var _views:ArrayCollection
		
		public function ProjectModel()
		{
		}
		
		
		// detect project type
			// find supported libs
		
		// search source
		protected function searchSource():void
		{
			var classes:ArrayCollection = new ArrayCollection([]);
			
			// find groups / root nodes for files
			var groupNames:XMLList = _frameworkDefinitions.framework.(@name=="robotlegs").classes.group.@name
			
			for (var i:int = 0; i < groupNames.length(); i++) 
			{
				var classGroup:ClassGroupVO = new ClassGroupVO();
					classGroup.name = groupNames[i];
					classGroup.searchDirectory = this.projectRoot;
					classGroup.filenamePattern = _frameworkDefinitions.framework.(@name=="robotlegs").classes.group.(@name==groupNames[i]).match.(@type=="filename").text()	
					
				classes.source.push(classGroup);
			}
			
				
			this.classes = classes;
//			
//			var modelSearch:FileSystemSearchService = new FileSystemSearchService();
//				modelSearch.addEventListener("searchComplete", modelsUpdate)
//				modelSearch.search(_projectSource, "model");
//			var viewSearch:FileSystemSearchService = new FileSystemSearchService();
//				viewSearch.addEventListener("searchComplete", viewsUpdate)
//				viewSearch.search(_projectSource, "view");
//			var controllerSearch:FileSystemSearchService = new FileSystemSearchService();
//				controllerSearch.addEventListener("searchComplete", controllersUpdate)
//				controllerSearch.search(_projectSource, "command");
		}
		
		protected function modelsUpdate(event:Event):void
		{
			
			models = FileSystemSearchService(event.currentTarget).resultData;
		}
		
		protected function viewsUpdate(event:Event):void
		{
			views = FileSystemSearchService(event.currentTarget).resultData;
		}
		
		protected function controllersUpdate(event:Event):void
		{
			controllers = FileSystemSearchService(event.currentTarget).resultData;
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
						frameworkSearch.search(_projectRoot + "/" + folders[i], frameworks[j]);
				}
				
			}
		}
		
		protected function frameworkUpdate(event:PayloadEvent):void
		{
			framework = "("+File(event.payload).name.replace(/(-framework-)|(-)|(.swc)/g," ").substr(0,-1)+")";
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
			searchSource();
		}
	
		
		[Bindable]
		public function get controllers():ArrayCollection
		{
			return _controllers;
		}

		public function set controllers(value:ArrayCollection):void
		{
			_controllers = value;
		}

		[Bindable]
		public function get models():ArrayCollection
		{
			return _models;
		}

		public function set models(value:ArrayCollection):void
		{
			_models = value;
		}

		[Bindable]
		public function get views():ArrayCollection
		{
			return _views;
		}

		public function set views(value:ArrayCollection):void
		{
			_views = value;
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

		[Bindable]
		public function get classes():ArrayCollection
		{
			return _classes;
		}

		public function set classes(value:ArrayCollection):void
		{
			_classes = value;
		}

		public function get frameworkDefinitions():XML
		{
			return _frameworkDefinitions;
		}

		public function set frameworkDefinitions(value:XML):void
		{
			_frameworkDefinitions = value;
		}


	}
}