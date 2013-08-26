package ludumdare27.systems 
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import ludumdare27.core.EntityFactory;
	import ludumdare27.nodes.GameNode;
	import ludumdare27.nodes.SparklingAgeNode;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class SparklingAgeSystem extends System 
	{
		private var m_gameNodes : NodeList;
		private var m_sparklingNodes : NodeList;
		private var m_entityFactory : EntityFactory;
		
		public function SparklingAgeSystem (entityFactory : EntityFactory)
		{
			this.m_entityFactory = entityFactory;
		}
		
		override public function addToEngine (engine : Engine) : void
		{
			this.m_gameNodes = engine.getNodeList(GameNode);
			this.m_sparklingNodes = engine.getNodeList(SparklingAgeNode);
		}
		
		override public function update (time : Number) : void
		{
			var game : GameNode = this.m_gameNodes.head;
			var sparkling : SparklingAgeNode;
			
			for (sparkling = this.m_sparklingNodes.head; sparkling; sparkling = sparkling.next)
			{
				sparkling.lifespan.elapsedTime += time;
				
				if (sparkling.lifespan.elapsedTime >= sparkling.lifespan.lifetime)
				{
					this.m_entityFactory.destroyEntity(sparkling.entity);
					--game.state.sparklingCount;
				}
				else
				{
					sparkling.display.displayObject.alpha = 1 - (sparkling.lifespan.elapsedTime / sparkling.lifespan.lifetime);
				}
			}
		}
		
		override public function removeFromEngine (engine : Engine) : void
		{
			this.m_gameNodes = null;
			this.m_sparklingNodes = null;
			this.m_entityFactory = null;
		}
	}
}