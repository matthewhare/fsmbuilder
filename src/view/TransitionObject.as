package view
{
	import flash.events.Event;
	
	import model.diagram.vo.StateVO;
	import model.diagram.vo.TransitionVO;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.core.UIComponent;
	
	import spark.components.Label;

	public class TransitionObject extends UIComponent 
	{
		[Bindable]
		public var vo:TransitionVO;
		
		public var label:Label;
		
		private var _stateFromIsInvalidFlag:Boolean;
		private var _stateTargetIsInvalidFlag:Boolean;
		
		private var _changeWatcherFrom:ChangeWatcher
		private var _changeWatcherTarget:ChangeWatcher
		
		public function TransitionObject()
		{
			vo = new TransitionVO();
			vo.action = "Action";
		}
		
		override protected function createChildren():void
		{
			
			
			label = new Label();
			label.text = vo.action;
			this.addChild(label);
		}
		
		override protected function commitProperties():void
		{
			if (_stateFromIsInvalidFlag)
			{
				if (_changeWatcherFrom)
					_changeWatcherFrom.unwatch();
				
				_changeWatcherFrom = ChangeWatcher.watch(this.vo.stateFrom, "viewCoords", refresh);
				
				stateFrom.addTransition(vo);
				_stateFromIsInvalidFlag = false;
			}
			
			if (_stateTargetIsInvalidFlag)
			{
				if (_changeWatcherTarget)
					_changeWatcherTarget.unwatch();
				
				_changeWatcherTarget = ChangeWatcher.watch(this.vo.stateTarget, "viewCoords", refresh);
				
				stateTarget.addTransition(vo);	
				_stateTargetIsInvalidFlag = false;
			}
			
			if (stateTarget && stateFrom)
				invalidateDisplayList();
			
			label.text = vo.action;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			if (vo && stateFrom && stateTarget)
			{
				this.x = vo.stateFrom.viewCoords.x
				this.y = vo.stateFrom.viewCoords.y
				
				this.graphics.clear();
				this.graphics.lineStyle(2, 0x0, 1, false, "normal", null, null, 3)
				this.graphics.lineTo(	vo.stateTarget.viewCoords.x - this.x, 
										vo.stateTarget.viewCoords.y - this.y);
				
				
				label.x = this.x - (vo.stateTarget.viewCoords.x /2);
				label.y = this.y - (vo.stateTarget.viewCoords.y /2);
				label.visible = true;
			}
			else
			{
				label.visible = false;
			}
		}
		
		public function drawTo(targetX:Number, targetY:Number):void
		{
			this.x = stateFrom.viewCoords.x;
			this.y = stateFrom.viewCoords.y;
			this.graphics.clear();
			this.graphics.lineStyle(2, 0x0, 1, false, "normal", null, null, 3)
			this.graphics.lineTo(targetX - this.x, targetY - this.y - 5);
			
		}
		
		private function refresh(event:Event):void
		{
			invalidateDisplayList();	
		}
		
		public function set stateFrom(vo:StateVO):void
		{
			if (vo == stateFrom)
				return
				
			if (vo && this.stateFrom && vo != this.stateFrom)
				this.stateFrom.removeTranstion(this.vo)
			
			this.vo.stateFrom = vo;
			
			_stateFromIsInvalidFlag = true;
			invalidateProperties();
		}
		
		public function get stateFrom():StateVO
		{
			return (vo) ? vo.stateFrom : null;
		}
		
		public function set stateTarget(vo:StateVO):void
		{
			if (vo == stateTarget)
				return
			
			if (vo && this.stateTarget && vo != this.stateTarget)
				this.stateTarget.removeTranstion(this.vo)
				
			this.vo.stateTarget = vo;
		
			_stateTargetIsInvalidFlag = true
			invalidateProperties();
		}
		
		public function get stateTarget():StateVO
		{
			return (vo) ? vo.stateTarget : null;
		}
		
	}
}