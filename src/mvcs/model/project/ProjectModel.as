package mvcs.model.project
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import framework.events.PayloadEvent;
	
	import mvcs.model.project.vo.SearchFileVO;
	import mvcs.services.FileSystemSearchService;
	
	import mx.collections.ArrayCollection;

	public class ProjectModel
	{
		
		private var _sourceURL:String;
		private var _framework:String;
		
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
			var modelSearch:FileSystemSearchService = new FileSystemSearchService();
				modelSearch.addEventListener("searchComplete", modelsUpdate)
				modelSearch.search(_sourceURL + "/src", "model");
			var viewSearch:FileSystemSearchService = new FileSystemSearchService();
				viewSearch.addEventListener("searchComplete", viewsUpdate)
				viewSearch.search(_sourceURL + "/src", "view");
			var controllerSearch:FileSystemSearchService = new FileSystemSearchService();
				controllerSearch.addEventListener("searchComplete", controllersUpdate)
				controllerSearch.search(_sourceURL + "/src", "command");
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
		
		protected function searchForFramework():void
		{
			framework = "Not Known";
			
			var folders:Array = ["lib", "libs"];
			var frameworks:Array = ["swiz", "robotlegs", "puremvc"];
			
			for (var i:int = 0; i < folders.length; i++) 
			{
				for (var j:int = 0; j < frameworks.length; j++) 
				{
					var frameworkSearch:FileSystemSearchService = new FileSystemSearchService();
						frameworkSearch.addEventListener("searchFound", frameworkUpdate)
						frameworkSearch.search(_sourceURL + "/" + folders[i], frameworks[j]);
				}
				
			}
		}
		
		protected function frameworkUpdate(event:PayloadEvent):void
		{
		
			
			var fileName:String = File(event.payload).name;
			
			switch (true)
			{
				case (fileName.indexOf("swiz-framework-v") > -1):
					framework = "Swiz (v" + fileName.split("swiz-framework-v").join("").split(".swc").join("") + ")";
					break;
				case (fileName.indexOf("robotlegs") > -1):
					framework = "Robotlegs (v" + fileName.split("robotlegs-framework-v").join("").split(".swc").join("") + ")";
					break;
				case (fileName.indexOf("puremvc") > -1):
					framework = "PureMVC"
					break;	
			}
		}

		
		// set source URL
		[Bindable]
		public function get sourceURL():String
		{
			return _sourceURL;
		}
		
		public function set sourceURL(value:String):void
		{
			_sourceURL = value;
			searchSource();
			searchForFramework();
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


	}
}