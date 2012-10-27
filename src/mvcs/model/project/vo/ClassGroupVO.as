package mvcs.model.project.vo
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import framework.events.PayloadEvent;
	
	import mvcs.services.FileSystemSearchService;

	public class ClassGroupVO
	{
		protected var _fileNamePattern:String;
		protected var _fileContentPattern:String;
		
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

		[Bindable]
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
		}

		public function get filenamePattern():String
		{
			return _fileNamePattern;
		}
		
		public function get fileContentPattern():String
		{
			return _fileContentPattern;
		}
		
		public function set fileContentPattern(value:String):void
		{
			_fileContentPattern = value;
		}
		
		public function validate():void
		{
			trace("ClassGroupVO ["+name+"]::validate: filenamePattern["+_fileNamePattern+"] fileContentPattern["+_fileContentPattern+"]");
			filenameValidate();
		}
		
		protected function filenameValidate():void
		{
			_search.addEventListener("searchFound", fileContentValidate)
			_search.search(_searchDirectory, _fileNamePattern);
		}
		
		
		protected function fileContentValidate(event:PayloadEvent):void
		{
			var classVO:ClassVO;
			var file:File = event.payload as File;
			
			if (_fileContentPattern)
			{
				
				var stream:FileStream = new FileStream();
					stream.open(file, FileMode.READ);
				var fileStream:String = stream.readUTFBytes( stream.bytesAvailable );
				var matches:Array = fileStream.match(_fileContentPattern);
					stream.close();
					
				if (matches && matches.length > -1)
				{
					classVO = new ClassVO();
					classVO.file = file;
					_children.push(classVO);
				}
			}
			else
			{
				classVO = new ClassVO();
				classVO.file = file;
				children.push(classVO);
			}
			// take each file one by one, load them, and check for regexp
			
			// if validated, add to children
		}
		
		protected function childrenUpdate(event:Event):void
		{
			// TODO Auto-generated method stub
			for (var i:int = 0; i < _search.resultData.length; i++) 
			{
				
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
		
	}
}