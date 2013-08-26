package ludumdare27.visuals 
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class SparkView extends Image
	{
		[Embed(source="../../../assets/graphics/spark.png")]
		private static const SparkImage : Class;
		private static const SparkTexture : Texture = Texture.fromBitmap(new SparkImage());
		
		public function SparkView() 
		{
			super(SparkTexture);
		}
	}
}