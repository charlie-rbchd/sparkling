package ludumdare27.systems 
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	import ludumdare27.core.Constants;
	import ludumdare27.nodes.GameNode;
	import ludumdare27.nodes.SparkSpotlightNode;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class LightingSystem extends System 
	{
		private var m_sparkNodes : NodeList;
		private var m_gameNodes : NodeList;
		
		public function LightingSystem () 
		{
			
		}
		
		override public function addToEngine (engine : Engine) : void
		{
			this.m_sparkNodes = engine.getNodeList(SparkSpotlightNode);
			this.m_gameNodes = engine.getNodeList(GameNode);
		}
		
		override public function update (time : Number) : void
		{
			var game : GameNode = this.m_gameNodes.head;
			var spark : SparkSpotlightNode = this.m_sparkNodes.head;
			
			if (spark != null)
			{
				spark.spotlight.spotlightFilter.centerX = spark.position.position.x + spark.collision.width / 2;
				spark.spotlight.spotlightFilter.centerY = spark.position.position.y + spark.collision.height / 2;
				
				spark.spotlight.spotlightFilter.amount = (game.state.elapsedTime - game.state.lastSparklingCollectedTime) / Constants.tenSeconds;
				spark.display.displayObject.alpha = 1 - spark.spotlight.spotlightFilter.amount;
			}
		}
		
		override public function removeFromEngine (engine : Engine) : void
		{
			this.m_gameNodes = null;
			this.m_sparkNodes = null;
		}
	}
}