package ludumdare27.components 
{
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class Lifespan 
	{
		public var lifetime : Number;
		public var elapsedTime : Number;
		
		public function Lifespan (lifetime : Number) 
		{
			this.lifetime = lifetime;
			this.elapsedTime = 0;
		}
	}
}