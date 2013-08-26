package ludumdare27.core 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class Constants 
	{
		public static const tenSeconds : int = 10;
		
		public static const gameWidth : int = 1024;
		public static const gameHeight : int = 768;
		public static const antiAliasing : int = 16;
		
		public static const sparkPosition : Point = new Point(150, 384);
		public static const timeBeforeInteractions : int = 1;
		
		public static const sparklingScrollSpeed : int = -150;
		public static const minimumSparklingCount : int = 15;
		public static const minimumSparklingSize : int = 1;
		public static const maximumSparklingSize : int = 4;
		public static const minimumSparklingLifespan : int = 2;
		public static const maximumSparklingLifespan : int = 6;
		
		public static const wallScrollSpeed : int = -100;
		public static const wallFragmentCount : int = 35;
		public static const maximumHeighGapBetweenFragments : int = 20;
		public static const minimumWallFragmentHeight : int = 100;
		public static const maximumWallFragmentHeight : int = 300;
		
		public function Constants() 
		{
			
		}
	}
}