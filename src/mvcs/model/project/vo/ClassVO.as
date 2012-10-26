package mvcs.model.project.vo
{
	import flash.filesystem.File;

	public class ClassVO
	{
		
		protected var _name:String;
		protected var _file:File;
		
		
		public function ClassVO()
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

		public function get file():File
		{
			return _file;
		}

		public function set file(value:File):void
		{
			_file = value;
			_name = _file.name;
		}


	}
}