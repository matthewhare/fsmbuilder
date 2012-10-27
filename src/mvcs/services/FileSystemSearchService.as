package mvcs.services
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	
	import framework.events.PayloadEvent;
	
	import mvcs.model.project.vo.SearchFileVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	/**
	 * Searches for files matching the pattern suuplied. Returns
	 * Files as an arrayCollection of SearchFileVO objects;
	 * */
	public class FileSystemSearchService extends EventDispatcher
	{
		public function FileSystemSearchService()
		{
		}
		
		public var data:Object;
		private var currentNodes:Array = []; // The nodes (files and directories) in the current directory
		private var directoryStack:Array = []; // An array of directories (File objects) to search.
		private var currentSubdirectories:Array; // An array of directories in the current directory.
		private var _nodeCount:uint = 0; // The number of files and directories searched.
		private var _resultData:ArrayCollection = new ArrayCollection(); 
		// A collection of object with data pertaining to matching files
		private var pattern:RegExp; // The pattern to search for in file (and directory) names
		private var searchString:String;
		
		/**
		 * Invoked when the user clicks the Search button. This method initiates the search
		 * by building a RegExp pattern based on the searchString text value, and then checking
		 * to see if the specified directory exists. If the directory does not exist, an error
		 * message is displayed; otherwise, the method calls the listDirectoryAsync() method of the
		 * dir object (that points to the directory). The directoryListing event handler processes
		 * the directory contents for this directory.
		 */
		public function search(folderPath:String, searchString:String):void 
		{
			resultData = new ArrayCollection();
			this.searchString = searchString;
			var patternString:String = searchString.replace(/\./g, "\\.");
				patternString = patternString.replace(/\*/g, ".*");
				patternString = patternString.replace(/\?/g, ".");
				pattern = new RegExp(patternString, "i");
			var dir:File = new File(folderPath);
			if (!dir.isDirectory)
			{
				dispatchEvent(new Event("searchError"))
			}
			else
			{
				dir.addEventListener(FileListEvent.DIRECTORY_LISTING, dirListed);
				dir.getDirectoryListingAsync();
			}
		}
		/**
		 * Processes the directory contents for this directory, iterating through each node (file or
		 * directory) to see if its name matches the Search pattern. Directories are added to the 
		 * currentSubdirectories array, which is later added to the directoryStack. After examining
		 * all of the nodes, the method then invokes the listDirectoryAsync() method of the next directory
		 * in the directoryStack stack.
		 */	
		private function dirListed(event:FileListEvent):void 
		{
			currentNodes = event.files;
			currentSubdirectories = [];
			nodeCount += currentNodes.length;
			
			var node:File;
			var fileExtension:String;
			for (var i:int = 0; i < currentNodes.length; i++) 
			{
				node = currentNodes[i];
				if (node.isDirectory) 
				{
					currentSubdirectories.push(currentNodes[i]);
				}
				
				//only return files
				else if (node.name.search(pattern) > -1) 
				{
					trace("found :" +node.name, node.extension);
					resultData.addItem(node);
					dispatchEvent(new PayloadEvent("searchFound", node));
				}
				else if (node.name.indexOf(searchString) > -1)
				{
					resultData.addItem(node);
					dispatchEvent(new PayloadEvent("searchFound", node));
					trace("found :" +node.name, node.extension);
				}
				else
				{
					trace("missed :" +node.name, " found["+node.name.indexOf(searchString)+"]", " fileName["+node.name+"]", " searchString["+searchString+"]");
				}
			}
			for (i = currentSubdirectories.length - 1; i > -1; i--) 
			{
				directoryStack.push(currentSubdirectories[i]);
			} 
			var dir:File = directoryStack.pop();
			if (dir == null) {
				// searched complete
				dispatchEvent(new Event("searchComplete"))
			} else {
				dir.addEventListener(FileListEvent.DIRECTORY_LISTING, dirListed);
				dir.getDirectoryListingAsync();
			}
		}

		[Bindable]
		public function get nodeCount():uint
		{
			return _nodeCount;
		}

		public function set nodeCount(value:uint):void
		{
			_nodeCount = value;
		}

		[Bindable]
		public function get resultData():ArrayCollection
		{
			return _resultData;
		}

		public function set resultData(value:ArrayCollection):void
		{
			_resultData = value;
		}
		
		public function validateClass():void
		{
			// get list of package paths
			
			// get Framework MVCS 'extends' class type
		}
	}
}