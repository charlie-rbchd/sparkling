package ludumdare27.systems 
{
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	import flash.geom.Point;
	import flash.media.Sound;
	import ludumdare27.components.Display;
	import ludumdare27.core.Constants;
	import ludumdare27.core.EntityFactory;
	import ludumdare27.core.SparklingGame;
	import ludumdare27.nodes.GameNode;
	import ludumdare27.nodes.SparkCollisionNode;
	import ludumdare27.nodes.SparklingCollisionNode;
	import ludumdare27.nodes.WallFragmentCollisionNode;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class GameSystem extends System
	{
		[Embed(source="../../../assets/sounds/death.mp3")]
		private static const DeathSoundClass : Class;
		private static const deathSound : Sound = Sound(new DeathSoundClass());
		
		private var m_entityFactory : EntityFactory;
		private var m_wallFragmentNodes : NodeList;
		private var m_sparkNodes : NodeList;
		private var m_sparklingNodes : NodeList;
		private var m_gameNodes : NodeList;
		private var m_timeCounter : Entity;
		private var m_startScreen : Entity;
		private var m_gameOverScreen : Entity;
		private var m_gameEngine : Engine;
		private var m_sparklingGame : SparklingGame;
		
		public function GameSystem (entityFactory : EntityFactory, sparklingGame : SparklingGame) 
		{
			this.m_entityFactory = entityFactory;
			this.m_sparklingGame = sparklingGame;
		}
		
		override public function addToEngine (engine : Engine) : void
		{
			this.m_wallFragmentNodes = engine.getNodeList(WallFragmentCollisionNode);
			this.m_sparkNodes = engine.getNodeList(SparkCollisionNode);
			this.m_sparklingNodes = engine.getNodeList(SparklingCollisionNode);
			this.m_gameNodes = engine.getNodeList(GameNode);
			this.m_gameEngine = engine;
		}
		
		override public function update (time : Number) : void
		{
			var game : GameNode = this.m_gameNodes.head;
			
			if (game.state.started)
			{
				game.state.elapsedTime += time;
			}
			
			// Game states
			if (!game.state.started || game.state.gameOver)
			{
				if (!game.state.started && this.m_startScreen == null)
				{
					this.m_startScreen = this.m_entityFactory.createStartScreen();
					this.m_startScreen.get(Display).displayObject.addEventListener("startGame", onGameStart);
				}
				
				if (game.state.gameOver && this.m_gameOverScreen == null)
				{
					deathSound.play();
					
					this.m_gameEngine.removeSystem(this.m_gameEngine.getSystem(MovementSystem));
					this.m_gameOverScreen = this.m_entityFactory.createGameOverScreen();
					this.m_gameOverScreen.get(Display).displayObject.addEventListener("restartGame", onGameRestart);
				}
				
				return;
			}
			
			// Time counter
			if (this.m_timeCounter == null)
			{
				this.m_timeCounter = this.m_entityFactory.createTimeCounter(Constants.gameWidth / 2 - 75, 0);
			}
			this.m_timeCounter.get(Display).displayObject.update(game.state.elapsedTime);
			
			// Losing conditions
			if (game.state.elapsedTime - game.state.lastSparklingCollectedTime > Constants.tenSeconds)
			{
				game.state.gameOver = true;
			}
			
			// Create the spark
			if (this.m_sparkNodes.empty)
			{
				this.m_entityFactory.createBackground();
				this.m_entityFactory.createSpark(Constants.sparkPosition.x, Constants.sparkPosition.y);
			}
			
			// Create wall fragments
			if (this.m_wallFragmentNodes.empty)
			{
				var i : int;
				var spawnHeight : Number;
				
				// Top wall
				for (i = 0; i <= Constants.wallFragmentCount; ++i)
				{
					spawnHeight = Constants.minimumWallFragmentHeight + Math.random() * (Constants.maximumWallFragmentHeight - Constants.minimumWallFragmentHeight);
					this.m_entityFactory.createWallFragment(i * Constants.gameWidth / Constants.wallFragmentCount, 0, spawnHeight, "top");
				}
				
				// Bottom wall
				for (i = 0; i <= Constants.wallFragmentCount; ++i)
				{
					spawnHeight = Constants.minimumWallFragmentHeight + Math.random() * (Constants.maximumWallFragmentHeight - Constants.minimumWallFragmentHeight);
					this.m_entityFactory.createWallFragment(i * Constants.gameWidth / Constants.wallFragmentCount, Constants.gameHeight - spawnHeight, spawnHeight, "bottom");
				}
			}
			
			// Randomly spawn sparklings
			if (game.state.sparklingCount < Constants.minimumSparklingCount || Math.random() < 0.01)
			{
				// Spawn a sparkling somewhere in front of the player
				var spark : SparkCollisionNode = this.m_sparkNodes.head;
				var spawnSize : Number = Constants.minimumSparklingSize + Math.random() * (Constants.maximumSparklingSize - Constants.minimumSparklingSize);
				var spawnLifespan : Number = Constants.minimumSparklingLifespan + Math.random() * (Constants.maximumSparklingLifespan - Constants.minimumSparklingLifespan);
				var spawnPosition : Point = new Point(
					Constants.sparkPosition.x + Math.random() * (Constants.gameWidth - Constants.sparkPosition.x),
					Math.random() * Constants.gameHeight
				);
				
				this.m_entityFactory.createSparkling(spawnPosition.x, spawnPosition.y, spawnSize, spawnLifespan);
				++game.state.sparklingCount;
			}
		}
		
		private function onGameStart (event : Event) : void
		{
			var game : GameNode = this.m_gameNodes.head;
			
			this.m_startScreen.get(Display).displayObject.removeEventListener("startGame", onGameStart);
			game.state.started = true;
			this.m_entityFactory.destroyEntity(this.m_startScreen);
			this.m_startScreen = null;
		}
		
		private function onGameRestart (event : Event) : void
		{
			this.m_gameOverScreen.get(Display).displayObject.removeEventListener("restartGame", onGameRestart);
			this.m_sparklingGame.restartGame();
		}
		
		override public function removeFromEngine (engine : Engine) : void
		{
			this.m_wallFragmentNodes = null;
			this.m_sparkNodes = null;
			this.m_sparklingNodes = null;
			this.m_gameNodes = null;
			this.m_gameEngine = null;
		}
	}
}