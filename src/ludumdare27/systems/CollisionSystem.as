package ludumdare27.systems 
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import ludumdare27.core.Constants;
	import ludumdare27.core.EntityFactory;
	import ludumdare27.nodes.GameNode;
	import ludumdare27.nodes.SparkCollisionNode;
	import ludumdare27.nodes.SparklingCollisionNode;
	import ludumdare27.nodes.WallFragmentCollisionNode;
	import ludumdare27.utils.Maths;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class CollisionSystem extends System 
	{
		[Embed(source="../../../assets/sounds/ignition.mp3")]
		private static const CollisionSoundClass : Class;
		private static const collisionSound : Sound = Sound(new CollisionSoundClass());
		
		private var m_wallFragmentNodes : NodeList;
		private var m_sparkNodes : NodeList;
		private var m_sparklingNodes : NodeList;
		private var m_entityFactory : EntityFactory;
		private var m_gameNodes : NodeList;
		
		public function CollisionSystem (entityFactory : EntityFactory) 
		{
			this.m_entityFactory = entityFactory;
		}
		
		override public function addToEngine (engine : Engine) : void
		{
			this.m_wallFragmentNodes = engine.getNodeList(WallFragmentCollisionNode);
			this.m_sparkNodes = engine.getNodeList(SparkCollisionNode);
			this.m_sparklingNodes = engine.getNodeList(SparklingCollisionNode);
			this.m_gameNodes = engine.getNodeList(GameNode);
		}
		
		override public function update (time : Number) : void
		{
			var game : GameNode = this.m_gameNodes.head;
			var wallFragment : WallFragmentCollisionNode;
			var spark : SparkCollisionNode;
			var sparkling : SparklingCollisionNode;
			
			var boxA : Rectangle = new Rectangle();
			var boxB : Rectangle = new Rectangle();
			
			for (spark = this.m_sparkNodes.head; spark; spark = spark.next)
			{
				boxA.setTo(spark.position.position.x, spark.position.position.y, spark.collision.width, spark.collision.height);
				
				for (sparkling = this.m_sparklingNodes.head; sparkling; sparkling = sparkling.next)
				{
					boxB.setTo(sparkling.position.position.x, sparkling.position.position.y, sparkling.collision.width, sparkling.collision.height);
					
					if (Maths.intersects(boxA, boxB))
					{
						game.state.lastSparklingCollectedTime +=
							(game.state.elapsedTime - game.state.lastSparklingCollectedTime) * (sparkling.sparkling.size / Constants.maximumSparklingSize) * sparkling.display.displayObject.alpha;
						this.m_entityFactory.destroyEntity(sparkling.entity);
						--game.state.sparklingCount;
						collisionSound.play();
					}
				}
				
				for (wallFragment = this.m_wallFragmentNodes.head; wallFragment; wallFragment = wallFragment.next)
				{
					boxB.setTo(wallFragment.position.position.x, wallFragment.position.position.y, wallFragment.collision.width, wallFragment.collision.height);
					
					if (Maths.intersects(boxA, boxB))
					{
						game.state.gameOver = true;
					}
				}
			}
		}
		
		override public function removeFromEngine (engine : Engine) : void
		{
			this.m_wallFragmentNodes = null;
			this.m_sparkNodes = null;
			this.m_sparklingNodes = null;
			this.m_gameNodes = null;
		}
	}
}