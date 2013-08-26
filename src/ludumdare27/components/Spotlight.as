package ludumdare27.components 
{
	import starling.filters.SpotlightFilter;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class Spotlight 
	{
		public var spotlightFilter : SpotlightFilter;
		
		public function Spotlight () 
		{
			this.spotlightFilter = new SpotlightFilter(200, 200, 0.75, 0.5, 0.5);
		}
	}
}