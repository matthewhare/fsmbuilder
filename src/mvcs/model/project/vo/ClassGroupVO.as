package mvcs.model.project.vo
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mvcs.services.FileSystemSearchService;

	public class ClassGroupVO
	{
		protected var _fileNamePattern:String;
		protected var _contentPattern:String;
		
		protected var _searchDirectory:String;
		protected var _search:FileSystemSearchService = new FileSystemSearchService();
		
		protected var _name:String;
		protected var _children:Array = []
		
		public function ClassGroupVO()
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

		public function get children():Array
		{
			return _children;
		}

		public function set children(value:Array):void
		{
			_children = value;
		}

		public function set filenamePattern(value:String):void
		{
			_fileNamePattern = value;
			_search.addEventListener("searchComplete", childrenUpdate)
			_search.search(_searchDirectory, value);
		}
		
		public function get filenamePattern():String
		{
			return _fileNamePattern;
		}
		
		protected function fileContentValidate():void
		{
			// take each file one by one, load them, and check for regexp
			
			// if validated, add to children
		}
		
		protected function childrenUpdate(event:Event):void
		{
			// TODO Auto-generated method stub
			for (var i:int = 0; i < _search.resultData.length; i++) 
			{
				var classVO:ClassVO = new ClassVO();
					classVO.file = _search.resultData[i] as File;
//					classVO.validateFile()
				_children.push(classVO);
			}
			
		}

		public function get searchDirectory():String
		{
			return _searchDirectory;
		}

		public function set searchDirectory(value:String):void
		{
			_searchDirectory = value;
		}

		public function get contentPattern():String
		{
			return _contentPattern;
		}

		public function set contentPattern(value:String):void
		{
			_contentPattern = value;
		}

		
	}
}