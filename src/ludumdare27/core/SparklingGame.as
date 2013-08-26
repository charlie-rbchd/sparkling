package ludumdare27.core 
{
	import ash.core.Engine;
	import ash.integration.starling.StarlingFrameTickProvider;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import ludumdare27.systems.CollisionSystem;
	import ludumdare27.systems.GameSystem;
	import ludumdare27.systems.LightingSystem;
	import ludumdare27.systems.MovementControlSystem;
	import ludumdare27.systems.MovementSystem;
	import ludumdare27.systems.RenderSystem;
	import ludumdare27.systems.SparklingAgeSystem;
	import ludumdare27.systems.SystemPriorities;
	import ludumdare27.systems.WallRecycleSystem;
	import ludumdare27.utils.TouchController;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class SparklingGame extends Sprite 
	{
		[Embed(source="../../../assets/sounds/ambient.mp3")]
		private static const BackgroundMusic : Class;
		
		private var m_gameEngine : Engine;
		private var m_tickProvider : StarlingFrameTickProvider;
		
		public function SparklingGame () 
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage (event : Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.adaptViewportToResolution();
			this.startBackgroundMusic();
			this.initializeGame();
			this.startGame();
		}
		
		private function adaptViewportToResolution () : void
		{
			// The viewport is letterboxed & scaled on the largest fitting axis when the resolution of
            // the device is not the same of that of the game.
			var nativeStage : Stage = Starling.current.nativeStage;
			var adaptedViewport : Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, Constants.gameWidth, Constants.gameHeight),
				new Rectangle(0, 0, nativeStage.fullScreenWidth, nativeStage.fullScreenHeight),
				ScaleMode.SHOW_ALL
			);
			
            Starling.current.viewPort = adaptedViewport;
		}
		
		private function startBackgroundMusic () : void
		{
			var bgm : Sound = Sound(new BackgroundMusic());
			bgm.play(0, int.MAX_VALUE);
		}
		
		private function initializeGame () : void
		{
			this.m_gameEngine = new Engine();
			
			var entityFactory : EntityFactory = new EntityFactory(m_gameEngine);
			var touchController : TouchController = new TouchController(Starling.current.stage);
			
			this.m_gameEngine.addSystem(new GameSystem(entityFactory, this), SystemPriorities.preUpdate);
			this.m_gameEngine.addSystem(new WallRecycleSystem(), SystemPriorities.preUpdate);
			this.m_gameEngine.addSystem(new MovementControlSystem(touchController), SystemPriorities.update);
			this.m_gameEngine.addSystem(new SparklingAgeSystem(entityFactory), SystemPriorities.update);
			this.m_gameEngine.addSystem(new MovementSystem(), SystemPriorities.move);
			this.m_gameEngine.addSystem(new CollisionSystem(entityFactory), SystemPriorities.resolveCollisions);
			this.m_gameEngine.addSystem(new LightingSystem(), SystemPriorities.render);
			this.m_gameEngine.addSystem(new RenderSystem(Starling.current.stage), SystemPriorities.render);
			
			entityFactory.createGame();
		}
		
		private function startGame () : void
		{
			this.m_tickProvider = new StarlingFrameTickProvider(Starling.current.juggler);
			this.m_tickProvider.add(this.m_gameEngine.update);
			this.m_tickProvider.start();
		}
		
		private function stopGame () : void
		{
			this.m_tickProvider.stop();
			this.m_tickProvider.removeAll();
			this.m_tickProvider = null;
			
			this.m_gameEngine.removeAllSystems();
			this.m_gameEngine.removeAllEntities();
			this.m_gameEngine = null;
		}
		
		public function restartGame () : void
		{
			this.stopGame();
			this.initializeGame();
			this.startGame();
		}
	}
}