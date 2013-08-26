package 
{
	import flash.display.Sprite;
	import ludumdare27.core.Constants;
	import ludumdare27.core.SparklingGame;
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	[SWF(backgroundColor="0x00021A", frameRate="60", width="1024", height="768")]
	public class Main extends Sprite 
	{
		private var m_starling : Starling;
		
		public function Main () : void 
		{
			super();
			
			Starling.handleLostContext = true;
			
			this.m_starling = new Starling(SparklingGame, stage);
			this.m_starling.antiAliasing = Constants.antiAliasing;
			this.m_starling.start();
			this.m_starling.showStatsAt(HAlign.RIGHT, VAlign.TOP);
		}
	}
}