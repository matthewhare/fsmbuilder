package utils.system
{
	/**
	 * Writes a class or object to file : 
	 * @see http://docs.huihoo.com/flex/4/flash/filesystem/File.html
	 * */
	public class FileSystemService
	{
	
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
		
		public function FileSystemService()
		{}
			
		public static function writeObjectToFile(object:Object, fname:String):void
		{
			var file:File = File.desktopDirectory.resolvePath(fname);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeObject(object);
			fileStream.close();
		}
		
		public static function readObjectFromFile(fname:String):Object
		{
			var file:File = File.desktopDirectory.resolvePath(fname);
			
			if(file.exists) {
				var obj:Object;
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				obj = fileStream.readObject();
				fileStream.close();
				return obj;
			}
		return null;
		}
	}
}