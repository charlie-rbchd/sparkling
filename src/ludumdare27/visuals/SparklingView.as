package ludumdare27.visuals 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import ludumdare27.core.Constants;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class SparklingView extends Image
	{
		[Embed(source="../../../assets/graphics/sparkling.png")]
		private static const SparklingImage : Class;
		private static const SparklingTexture : Texture = Texture.fromBitmap(new SparklingImage());
		
		public function SparklingView (radius : Number) 
		{
			super(SparklingTexture);
			this.scaleX = this.scaleY = radius / Constants.maximumSparklingSize;
		}
	}
}