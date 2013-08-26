package ludumdare27.utils 
{
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class TouchController 
	{
		private var m_displayObject : DisplayObject;
		private var m_previousPosition : Point;
		private var m_touchPosition : Point;
		
		public function TouchController (displayObject : DisplayObject) 
		{
			this.m_displayObject = displayObject;
			this.m_touchPosition = new Point();
			this.m_previousPosition = new Point();
			this.m_displayObject.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch (event : TouchEvent) : void
		{
			var touch:Touch = event.getTouch(this.m_displayObject);
			if (touch != null)
			{
				this.m_previousPosition.x = this.m_touchPosition.x;
				this.m_previousPosition.y = this.m_touchPosition.y;
				
				this.m_touchPosition.x = touch.globalX;
				this.m_touchPosition.y = touch.globalY;
			}
		}
		
		public function getPreviousPosition () : Point
		{
			return this.m_previousPosition;
		}
		
		public function getPosition () : Point
		{
			return this.m_touchPosition;
		}
		
		public function dispose () : void
		{
			this.m_displayObject.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
	}
}