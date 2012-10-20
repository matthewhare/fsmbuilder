package model.code
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class ProjectModel
	{
		
		private var _sourceURL:String;
		
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
			var modelSearch:PackageService = new PackageService();
				modelSearch.addEventListener("searchComplete", modelsUpdate)
				modelSearch.search(_sourceURL, "model");
			var viewSearch:PackageService = new PackageService();
				viewSearch.addEventListener("searchComplete", viewsUpdate)
				viewSearch.search(_sourceURL, "view");
			var controllerSearch:PackageService = new PackageService();
				controllerSearch.addEventListener("searchComplete", controllersUpdate)
				controllerSearch.search(_sourceURL, "command");
		}
		
		protected function modelsUpdate(event:Event):void
		{
			models = PackageService(event.currentTarget).resultData;
		}
		
		protected function viewsUpdate(event:Event):void
		{
			views = PackageService(event.currentTarget).resultData;
		}
		
		protected function controllersUpdate(event:Event):void
		{
			controllers = PackageService(event.currentTarget).resultData;
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


	}
}