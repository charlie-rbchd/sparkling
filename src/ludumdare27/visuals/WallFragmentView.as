package ludumdare27.visuals 
{
	import starling.display.Shape;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class WallFragmentView extends Shape
	{		
		public function WallFragmentView (width : Number, height : Number) 
		{
			this.redraw(width, height);
		}
		
		public function redraw (width : Number, height : Number) : void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x00010D);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
		}
	}
}