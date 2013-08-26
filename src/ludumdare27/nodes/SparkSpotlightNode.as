package ludumdare27.nodes 
{
	import ash.core.Node;
	import ludumdare27.components.Collision;
	import ludumdare27.components.Display;
	import ludumdare27.components.Position;
	import ludumdare27.components.Spark;
	import ludumdare27.components.Spotlight;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class SparkSpotlightNode extends Node 
	{
		public var spark : Spark;
		public var position : Position;
		public var collision : Collision;
		public var spotlight : Spotlight;
		public var display : Display;
		
		public function SparkSpotlightNode () 
		{
			
		}
	}
}