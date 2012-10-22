package mvcs.utils.writers
{
	import mvcs.model.diagram.FSMModel;

	public interface IWriter
	{
		function getFileContent(model:FSMModel):String;
	}
}