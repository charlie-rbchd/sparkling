package ludumdare27.core 
{
	import ash.core.Engine;
	import ash.core.Entity;
	import ludumdare27.components.Collision;
	import ludumdare27.components.Display;
	import ludumdare27.components.GameState;
	import ludumdare27.components.Lifespan;
	import ludumdare27.components.Movement;
	import ludumdare27.components.MovementControls;
	import ludumdare27.components.Position;
	import ludumdare27.components.Spark;
	import ludumdare27.components.Sparkling;
	import ludumdare27.components.Spotlight;
	import ludumdare27.components.WallFragment;
	import ludumdare27.visuals.BackgroundView;
	import ludumdare27.visuals.GameOverScreenView;
	import ludumdare27.visuals.LayerIndexes;
	import ludumdare27.visuals.SparklingView;
	import ludumdare27.visuals.SparkView;
	import ludumdare27.visuals.StartScreenView;
	import ludumdare27.visuals.TimeCounterView;
	import ludumdare27.visuals.WallFragmentView;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class EntityFactory
	{
		private var m_gameEngine : Engine;
		
		public function EntityFactory (gameEngine : Engine)
		{
			this.m_gameEngine = gameEngine;
		}
		
		public function destroyEntity (entity : Entity) : void
		{
			this.m_gameEngine.removeEntity(entity);
		}
		
		public function createGame () : Entity
		{
			var game : Entity = new Entity();
			game.add(new GameState());
			
			this.m_gameEngine.addEntity(game);
			
			return game;
		}
		
		public function createBackground () : Entity
		{
			var background : Entity = new Entity();
			background.add(new Position(0, 0));
			background.add(new Display(new BackgroundView(), LayerIndexes.background));
			
			this.m_gameEngine.addEntity(background);
			
			return background;
		}
		
		public function createSpark (x : Number, y : Number) : Entity
		{
			var spark : Entity = new Entity();
			spark.add(new Spark());
			spark.add(new Position(x, y));
			spark.add(new Collision(20, 27));
			spark.add(new Movement(0, 0));
			spark.add(new MovementControls(150));
			spark.add(new Display(new SparkView(), LayerIndexes.background));
			spark.add(new Spotlight());
			
			this.m_gameEngine.addEntity(spark);
			
			return spark;
		}
		
		public function createSparkling (x : Number, y : Number, radius : Number, lifespan : Number) : Entity
		{
			var sparkling : Entity = new Entity();
			sparkling.add(new Sparkling(radius));
			sparkling.add(new Position(x, y));
			sparkling.add(new Collision(radius * 2, radius * 2));
			sparkling.add(new Lifespan(lifespan));
			sparkling.add(new Movement(Constants.sparklingScrollSpeed, 0, true));
			sparkling.add(new Display(new SparklingView(radius), LayerIndexes.foreground));
			
			this.m_gameEngine.addEntity(sparkling);
			
			return sparkling;
		}
		
		public function createWallFragment (x : Number, y : Number, height : Number, side : String) : Entity
		{
			var width : Number = Constants.gameWidth / Constants.wallFragmentCount;
			
			var wallFragment : Entity = new Entity();
			wallFragment.add(new WallFragment(side));
			wallFragment.add(new Position(x, y));
			wallFragment.add(new Collision(width, height));
			wallFragment.add(new Movement(Constants.wallScrollSpeed, 0, true));
			wallFragment.add(new Display(new WallFragmentView(width, height), LayerIndexes.background));
			
			this.m_gameEngine.addEntity(wallFragment);
			
			return wallFragment;
		}
		
		public function createTimeCounter (x : Number, y : Number) : Entity
		{
			var timeCounter : Entity = new Entity();
			timeCounter.add(new Position(x, y));
			timeCounter.add(new Display(new TimeCounterView(), LayerIndexes.ui));
			
			this.m_gameEngine.addEntity(timeCounter);
			
			return timeCounter;
		}
		
		public function createStartScreen () : Entity
		{
			var startScreen : Entity = new Entity();
			startScreen.add(new Position(0, 0));
			startScreen.add(new Display(new StartScreenView(), LayerIndexes.ui));
			
			this.m_gameEngine.addEntity(startScreen);
			
			return startScreen;
		}
		
		public function createGameOverScreen () : Entity
		{
			var gameOverScreen : Entity = new Entity();
			gameOverScreen.add(new Position(0, 0));
			gameOverScreen.add(new Display(new GameOverScreenView(), LayerIndexes.ui));
			
			this.m_gameEngine.addEntity(gameOverScreen);
			
			return gameOverScreen;
		}
	}
}