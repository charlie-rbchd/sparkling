package ludumdare27.nodes 
{
	import ash.core.Node;
	import ludumdare27.components.Collision;
	import ludumdare27.components.Position;
	import ludumdare27.components.Spark;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class SparkCollisionNode extends Node
	{
		public var spark : Spark;
		public var position : Position;
		public var collision : Collision;
		
		public function SparkCollisionNode () 
		{
			
		}
	}
}