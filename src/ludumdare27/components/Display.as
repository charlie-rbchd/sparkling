package ludumdare27.components 
{
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class Display 
	{
		public var displayObject : DisplayObject;
		public var layer : int;
		
		public function Display (displayObject : DisplayObject, layer : int = 0) 
		{
			this.displayObject = displayObject;
			this.layer = layer;
		}
	}
}