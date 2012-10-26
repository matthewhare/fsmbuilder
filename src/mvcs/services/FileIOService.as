package mvcs.services
{
	/**
	 * Writes a class or object to file : 
	 * @see http://docs.huihoo.com/flex/4/flash/filesystem/File.html
	 * */
	public class FileIOService
	{
	
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
		
		public function FileIOService()
		{}
			
		public function writeObjectToFile(object:Object, fname:String, dir:String):void
		{
			var file:File = File(dir + File.separator + fname);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeObject(object);
			fileStream.close();
		}
		
		public function readObjectFromFile(fname:String, dir:String):Object
		{
			var file:File = new File(dir + File.separator + fname);
			
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