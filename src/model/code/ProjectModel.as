package model.code
{
	import com.bealearts.collection.VectorCollection;
	
	import mx.collections.ArrayCollection;

	public class ProjectModel
	{
		
		private var _sourceURL:String;
		
		private var _controllers:VectorCollection
		private var _models:VectorCollection
		private var _views:VectorCollection
		
		public function ProjectModel()
		{
			var m:Vector.<String> = new Vector.<String>();
				m.push("ModelUsers");
				m.push("ModelGoals");
			
			var v:Vector.<String> = new Vector.<String>();
				v.push("ViewTrophyWall");
				v.push("ViewGoalContribution");
				v.push("ViewGoals");
				v.push("ViewGoalEdit");
				v.push("ViewProfileEdit");
				
				
			var c:Vector.<String> = new Vector.<String>();
				c.push("CommandStartUp");
				c.push("CommandLogin");
				c.push("CommandLoginVerify");
				c.push("CommandLoginSuccess");
				c.push("CommandLoginFail");
				
			models = new VectorCollection(m);
			views = new VectorCollection(v);
			controllers = new VectorCollection(c);
		}
		
		
		// detect project type
			// find supported libs
		
		// search source
		protected function searchSource():void
		{
			
		}
		
		// set source URL
		public function set sourceURL(value:String):void
		{
			
		}
		
		
		[Bindable]
		public function get controllers():VectorCollection
		{
			return _controllers;
		}

		public function set controllers(value:VectorCollection):void
		{
			_controllers = value;
		}

		[Bindable]
		public function get models():VectorCollection
		{
			return _models;
		}

		public function set models(value:VectorCollection):void
		{
			_models = value;
		}

		[Bindable]
		public function get views():VectorCollection
		{
			return _views;
		}

		public function set views(value:VectorCollection):void
		{
			_views = value;
		}


	}
}