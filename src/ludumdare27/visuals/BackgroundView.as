package ludumdare27.visuals 
{
	import starling.display.Quad;
	import ludumdare27.core.Constants;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class BackgroundView extends Quad 
	{
		public function BackgroundView () 
		{
			super(Constants.gameWidth, Constants.gameHeight, 0x00021A);
		}
	}
}