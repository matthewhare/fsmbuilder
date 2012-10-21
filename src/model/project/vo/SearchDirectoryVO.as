package model.project.vo
{
	public class SearchDirectoryVO
	{
		protected var _name:String;
		protected var _path:String;
		
		public function SearchDirectoryVO()
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