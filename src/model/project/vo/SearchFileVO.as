package model.project.vo
{
	public class SearchFileVO
	{
		protected var _name:String;
		protected var _extension:String;
		protected var _path:String;

		
		
		
		public function SearchFileVO()
		{
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get extension():String
		{
			return _extension;
		}

		public function set extension(value:String):void
		{
			_extension = value;
		}

		public function get path():String
		{
			return _path;
		}

		public function set path(value:String):void
		{
			_path = value;
		}		
	}
}