package ludumdare27.systems 
{
	import ash.tools.ListIteratingSystem;
	import flash.geom.Point;
	import ludumdare27.components.Movement;
	import ludumdare27.components.MovementControls;
	import ludumdare27.components.Position;
	import ludumdare27.nodes.MovementControlNode;
	import ludumdare27.utils.TouchController;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class MovementControlSystem extends ListIteratingSystem
	{
		private var m_touchController : TouchController;
		
		public function MovementControlSystem (touchController : TouchController) 
		{
			super(MovementControlNode, updateNode);
			this.m_touchController = touchController;
		}
		
		private function updateNode (movementControlNode : MovementControlNode, time : Number) : void
		{
			var movementControlComponent : MovementControls = movementControlNode.controls;
			var movementComponent : Movement = movementControlNode.movement;
			var positionComponent : Position = movementControlNode.position;
			var movementVector : Point = m_touchController.getPosition().subtract(positionComponent.position);
			
			movementComponent.velocity.y = movementVector.y * movementControlComponent.accelerationRate * time;
		}
	}
}