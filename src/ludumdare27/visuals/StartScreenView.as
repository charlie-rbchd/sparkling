package ludumdare27.visuals 
{
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import ludumdare27.core.Constants;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Joel Robichaud
	 */
	public class StartScreenView extends Sprite 
	{
		private var m_intro : TextField;
		private var m_instructions : TextField;
		private var m_startGame : TextField;
		
		public function StartScreenView () 
		{
			this.m_intro = new TextField(800, 70, "Feed light to the fairy every 10 seconds,\nor else...", "Verdana", 24, 0xFFFFFF, true);
			this.m_intro.x = (Constants.gameWidth / 2) - (this.m_intro.width / 2);
			this.m_intro.y = (Constants.gameHeight * 0.25) - (this.m_intro.height / 2);
			this.addChild(this.m_intro);
			
			this.m_instructions = new TextField(650, 50, "Move your mouse (or finger) on the screen to guide the fairy.\nWatch out not to hit the cave walls!", "Verdana", 18, 0xFFFFFF, true);
			this.m_instructions.x = (Constants.gameWidth / 2) - (this.m_instructions.width / 2);
			this.m_instructions.y = (Constants.gameHeight / 2) - (this.m_instructions.height / 2);
			this.addChild(this.m_instructions);
			
			this.m_startGame = new TextField(250, 45, "Click to start", "Verdana", 32, 0xFFFFFF, true);
			this.m_startGame.x = (Constants.gameWidth / 2) - (this.m_startGame.width / 2);
			this.m_startGame.y = (Constants.gameHeight * 0.75) - (this.m_startGame.height / 2);
			this.m_startGame.useHandCursor = true;
			this.m_startGame.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addChild(this.m_startGame);
		}
		
		private function onTouch (event : TouchEvent) : void
		{
			var touch : Touch = event.getTouch(this.m_startGame, TouchPhase.BEGAN);
			if (touch != null)
			{
				this.m_startGame.removeEventListener(TouchEvent.TOUCH, onTouch);
				this.dispatchEventWith("startGame");
			}
		}
		
		override public function dispose () : void
		{
			m_intro = null;
			m_instructions = null;
			m_startGame = null;
			
			super.dispose();
		}
	}
}