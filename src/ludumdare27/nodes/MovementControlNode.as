package ludumdare27.nodes 
{
	import ash.core.Node;
	import ludumdare27.components.Movement;
	import ludumdare27.components.MovementControls;
	import ludumdare27.components.Position;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class MovementControlNode extends Node 
	{
		public var controls : MovementControls;
		public var position : Position;
		public var movement : Movement;
		
		public function MovementControlNode () 
		{
			
		}
	}
}