package ludumdare27.components 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class Movement
	{
		public var velocity : Point;
		public var accelerateOverTime : Boolean;
		
		public function Movement (vx : Number, vy : Number, accelerateOverTime : Boolean = false) 
		{
			this.velocity = new Point(vx, vy);
			this.accelerateOverTime = accelerateOverTime;
		}
	}
}