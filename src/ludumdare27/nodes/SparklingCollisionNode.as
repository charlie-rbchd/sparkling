package ludumdare27.nodes 
{
	import ash.core.Node;
	import ludumdare27.components.Collision;
	import ludumdare27.components.Display;
	import ludumdare27.components.Position;
	import ludumdare27.components.Sparkling;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class SparklingCollisionNode extends Node 
	{
		public var sparkling : Sparkling;
		public var position : Position;
		public var collision : Collision;
		public var display : Display;
		
		public function SparklingCollisionNode () 
		{
			
		}
	}
}