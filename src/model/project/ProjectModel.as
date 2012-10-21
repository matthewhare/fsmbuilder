package model.project
{
	import flash.events.Event;
	
	import model.project.vo.SearchFileVO;
	
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
		
		protected function searchForFramework():void
		{
			framework = "Not Known";
			var frameworkSearch:FileSystemSearchService = new FileSystemSearchService();
				frameworkSearch.addEventListener("searchComplete", frameworkUpdate)
				frameworkSearch.search(_sourceURL + "/lib", "swiz-framework-v");
				frameworkSearch.search(_sourceURL + "/lib", "robotlegs");
				frameworkSearch.search(_sourceURL + "/lib", "puremvc");
				frameworkSearch.search(_sourceURL + "/libs", "swiz-framework-v");
				frameworkSearch.search(_sourceURL + "/libs", "robotlegs");
				frameworkSearch.search(_sourceURL + "/libs", "puremvc");
		}
		
		protected function frameworkUpdate(event:Event):void
		{
			var s:FileSystemSearchService = FileSystemSearchService(event.currentTarget);

			if (s.resultData.length == 0)
				return;
			
			var f:SearchFileVO = SearchFileVO(s.resultData[0]);
			
			switch (true)
			{
				case f.name.indexOf("swiz-framework-v"):
					framework = "Swiz";
					break;
				case f.name.indexOf("robotlegs"):
					framework = "RobotLegs";
					break;
				case f.name.indexOf("puremvc"):
					framework = "PureMVC"
					break;	
			}
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