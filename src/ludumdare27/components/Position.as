package ludumdare27.components 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class Position 
	{
		public var position : Point;
		
		public function Position (x : Number, y : Number) 
		{
			this.position = new Point(x, y);
		}
	}
}