package ludumdare27.nodes 
{
	import ash.core.Node;
	import ludumdare27.components.Collision;
	import ludumdare27.components.Position;
	import ludumdare27.components.WallFragment;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class WallFragmentCollisionNode extends Node 
	{
		public var wallFragment : WallFragment;
		public var position : Position;
		public var collision : Collision;
		
		public function WallFragmentCollisionNode () 
		{
			
		}
	}
}