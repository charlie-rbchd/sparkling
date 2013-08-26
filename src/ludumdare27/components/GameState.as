package ludumdare27.components 
{
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class GameState 
	{
		public var started : Boolean;
		public var gameOver : Boolean;
		public var sparklingCount : Number;
		public var elapsedTime : Number;
		public var lastSparklingCollectedTime : Number;
		
		public function GameState () 
		{
			this.started = false;
			this.gameOver = false;
			this.sparklingCount = 0;
			this.elapsedTime = 0;
			this.lastSparklingCollectedTime = 0;
		}
	}
}