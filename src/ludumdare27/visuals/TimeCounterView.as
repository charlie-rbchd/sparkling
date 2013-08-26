package ludumdare27.visuals 
{
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class TimeCounterView extends TextField 
	{
		private var m_textField : TextField
		
		public function TimeCounterView () 
		{
			super(150, 30, "00:00:00", "Verdana", 24, 0xFFFFFF, true);
		}
		
		public function update (time : Number) : void
		{
			var minutes : int = (time % 3600) / 60;
			var seconds : int = time % 60;
			var miliseconds : String = time.toFixed(2).replace(/.*\.(.*)/, "$1");
			
			this.text = this.padWithTwoZeros(minutes) + ":" + this.padWithTwoZeros(seconds) + ":" + miliseconds;
		}
		
		private function padWithTwoZeros (n : int) : String
		{
			return (n < 10) ? ("0" + n) : n.toString();
		}
	}
}