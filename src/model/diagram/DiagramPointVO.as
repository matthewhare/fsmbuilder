package model.diagram
{
	[RemoteClass]
	public class DiagramPointVO
	{
		private var _x:Number;
		private var _y:Number;
		
		public function DiagramPointVO(x:Number = 0, y:Number = 0)
		{
			_x = x;
			_y = y;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}


	}
}