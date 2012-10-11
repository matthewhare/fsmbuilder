package writers
{
	import model.FSMModel;

	public interface IWriter
	{
		function getFileContent(model:FSMModel):String;
	}
}