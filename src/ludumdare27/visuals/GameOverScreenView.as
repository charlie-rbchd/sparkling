package ludumdare27.visuals 
{
	import starling.text.TextField;
	import starling.display.Sprite;
	import ludumdare27.core.Constants;
	import starling.events.Touch
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class GameOverScreenView extends Sprite 
	{
		private var m_outro : TextField;
		private var m_replay : TextField;
		
		public function GameOverScreenView ()
		{
			this.m_outro = new TextField(500, 70, "You died...\nThe cave grows darker once again.", "Verdana", 24, 0xFFFFFF, true);
			this.m_outro.x = (Constants.gameWidth / 2) - (this.m_outro.width / 2);
			this.m_outro.y = (Constants.gameHeight * 0.33) - (this.m_outro.height / 2);
			this.addChild(this.m_outro);
			
			this.m_replay = new TextField(350, 45, "Click to play again", "Verdana", 32, 0xFFFFFF, true);
			this.m_replay.x = (Constants.gameWidth / 2) - (this.m_replay.width / 2);
			this.m_replay.y = (Constants.gameHeight * 0.66) - (this.m_replay.height / 2);
			this.m_replay.useHandCursor = true;
			this.m_replay.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addChild(this.m_replay);
		}
		
		private function onTouch (event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(this.m_replay, TouchPhase.BEGAN);
			if (touch != null)
			{
				this.m_replay.removeEventListener(TouchEvent.TOUCH, onTouch);
				this.dispatchEventWith("restartGame");
			}
		}
		
		override public function dispose () : void
		{
			m_outro = null;
			m_replay = null;
			
			super.dispose();
		}
	}
}