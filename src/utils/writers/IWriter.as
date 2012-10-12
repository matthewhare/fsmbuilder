package utils.writers
{
	import model.diagram.FSMModel;

	public interface IWriter
	{
		function getFileContent(model:FSMModel):String;
	}
}