package ludumdare27.systems 
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import ludumdare27.components.Display;
	import ludumdare27.components.Movement;
	import ludumdare27.components.Position;
	import ludumdare27.components.Spark;
	import ludumdare27.components.Sparkling;
	import ludumdare27.components.WallFragment;
	import ludumdare27.core.Constants;
	import ludumdare27.nodes.GameNode;
	import ludumdare27.nodes.MovementNode;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class MovementSystem extends System
	{
		private var m_gameNodes : NodeList;
		private var m_movementNodes : NodeList;
		
		public function MovementSystem () 
		{
			
		}
		
		override public function addToEngine (engine : Engine) : void
		{
			this.m_movementNodes = engine.getNodeList(MovementNode);
			this.m_gameNodes = engine.getNodeList(GameNode);
		}
		
		override public function update (time : Number) : void
		{
			var game : GameNode = this.m_gameNodes.head;
			
			var movementNode : MovementNode;
			var positionComponent : Position;
			var movementComponent : Movement;
			var displayComponent : Display;
			var displayObjectHeight : Number;
			
			for (movementNode = this.m_movementNodes.head; movementNode; movementNode = movementNode.next)
			{
				positionComponent = movementNode.position;
				movementComponent = movementNode.movement;
				displayComponent = movementNode.display;
				displayObjectHeight = displayComponent.displayObject.height;
				
				if (movementNode.entity.has(Spark) && game.state.elapsedTime < Constants.timeBeforeInteractions)
				{
					continue;
				}
				
				if (movementComponent.accelerateOverTime)
				{
					if (movementNode.entity.has(Sparkling))
					{
						movementComponent.velocity.x = Constants.sparklingScrollSpeed * (1 + game.state.elapsedTime / 100);
					}
					else if (movementNode.entity.has(WallFragment))
					{
						movementComponent.velocity.x = Constants.wallScrollSpeed * (1 + game.state.elapsedTime / 100);
					}
				}
				
				positionComponent.position.x += movementComponent.velocity.x * time;
				positionComponent.position.y += movementComponent.velocity.y * time;
				
				if (positionComponent.position.y < 0)
				{
					positionComponent.position.y = 0;
				}
				else if (positionComponent.position.y > Constants.gameHeight - displayObjectHeight)
				{
					positionComponent.position.y = Constants.gameHeight - displayObjectHeight;
				}
			}
		}
		
		override public function removeFromEngine (engine : Engine) : void
		{
			this.m_gameNodes = null;
			this.m_movementNodes = null;
		}
	}
}