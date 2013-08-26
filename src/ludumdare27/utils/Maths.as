package ludumdare27.utils 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class Maths 
	{
		public static function intersects (a : Rectangle, b : Rectangle) : Boolean
		{
			if (a.bottomRight.x < b.topLeft.x ||
				a.bottomRight.y < b.topLeft.y ||
				a.topLeft.x > b.bottomRight.x ||
				a.topLeft.y > b.bottomRight.y)
			{
				return false;
			}
			
			return true;
		}
		
		public function Maths () 
		{
			
		}
	}
}