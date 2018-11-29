package code {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	/**
	 * This is our Title Scene Object Class.
	 */
	public class SceneTitle extends GameScene {
		
		/** */
		private var switchToPlay:Boolean = false;
		/** */
		private var textTimer:Number = 5;
		/** */
		private var textFadeInOrOut:Boolean = true;
		
		/**
		 * This is our constructor code for this Object
		 */
		public function SceneTitle() {
			// constructor code
		}
		/**
		 * Adds our EventListeners to the stage when this scene is created.
		 */
		override public function onBegin(): void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			clickText.alpha = 0;
		} // end onBegin
		/**
		 * Removes our EventListeners to the stage when this scene is created.
		 */
		override public function onEnd(): void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		} // end onEnd
		/**
		 * This event-handler is called everytime the left mouse button is down.
		 * It causes the player to shoot bullets.
		 * @param e The MouseEvent that triggered this event-handler.
		 */
		private function handleClick(e: MouseEvent): void {

			switchToPlay = true;

		} // ends handleClick
		/**
		 * This checks every frame if we are ready to go to our next scene
		 * @param previousScene If passed in, it is a cache to whatever scene came before this.
		 * @return We return null if we don't need to swtich scenes yet. If a GameScene Object is returned, then we will switch to that scene.
		 */
		override public function update(previousScene:GameScene=null):GameScene {
			//trace("title tick");
			textTimer -= Time.dt;
			if (textTimer <= 0) {
				if (textFadeInOrOut) {
					clickText.alpha += Time.dt;
					if (clickText.alpha >= 1) {
						clickText.alpha = 1;
						textFadeInOrOut = false;
						textTimer = 2;
					}
				} else {
					clickText.alpha -= Time.dt;
					if (clickText.alpha <=0 ) {
						clickText.alpha = 0;
						textFadeInOrOut = true;
					}
				}
			}
			if (switchToPlay) {
				//trace("if is true");
				return new ScenePlay();
			}
			return null
		} 
	}
	
}
