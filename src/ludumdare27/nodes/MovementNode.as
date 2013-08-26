package ludumdare27.nodes 
{
	import ash.core.Node;
	import ludumdare27.components.Display;
	import ludumdare27.components.Movement;
	import ludumdare27.components.Position;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class MovementNode extends Node
	{
		public var position : Position;
		public var display : Display;
		public var movement : Movement;
		
		public function MovementNode () 
		{
			
		}
	}
}