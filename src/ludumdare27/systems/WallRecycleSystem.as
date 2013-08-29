package ludumdare27.systems 
{
	import ash.tools.ListIteratingSystem;
	import ludumdare27.components.Collision;
	import ludumdare27.components.Display;
	import ludumdare27.components.Position;
	import ludumdare27.components.WallFragment;
	import ludumdare27.core.Constants;
	import ludumdare27.nodes.WallFragmentRecycleNode;
	import ludumdare27.visuals.WallFragmentView;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class WallRecycleSystem extends ListIteratingSystem 
	{		
		public function WallRecycleSystem () 
		{
			super(WallFragmentRecycleNode, updateNode);
		}
		
		private function updateNode (wallFragmentRecycleNode : WallFragmentRecycleNode, time : Number) : void
		{
			var wallFragmentComponent : WallFragment = wallFragmentRecycleNode.wallFragment;
			var positionComponent : Position = wallFragmentRecycleNode.position;
			var displayComponent : Display = wallFragmentRecycleNode.display;
			var collisionComponent : Collision = wallFragmentRecycleNode.collision;
			
			if (positionComponent.position.x + collisionComponent.width <= 0)
			{
				var spawnHeight : Number = Constants.minimumWallFragmentHeight + Math.random() * (Constants.maximumWallFragmentHeight - Constants.minimumWallFragmentHeight);
				
				positionComponent.position.x += Constants.gameWidth;
				if (wallFragmentComponent.side == "top")
				{
					positionComponent.position.y = 0;					
				}
				else if (wallFragmentComponent.side == "bottom")
				{
					positionComponent.position.y = Constants.gameHeight - spawnHeight;
				}
				
				collisionComponent.height = spawnHeight;
				
				WallFragmentView(displayComponent.displayObject).redraw(collisionComponent.width, spawnHeight);
			}
		}
	}
}