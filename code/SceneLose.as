package code {

	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	/**
	 *  This is our Lose Scene Object Class.
	 */
	public class SceneLose extends GameScene {

		/** How long it takes the aditional Click To Play text to appear on-screen. */
		private var textTimer:Number = 5;
		/** A true or false statement to keep track of if we want to fade in or fade out the Click text. */
		private var textFadeInOrOut:Boolean = true;
		
		/**
		 * This is our constructor code for this Object
		 */
		public function SceneLose() {
			// constructor code
		}
		/**
		 * Adds our EventListeners to the stage when this scene is created.
		 */
		override public function onBegin(): void {
			clickText.alpha = 0;
		} // end onBegin
		/**
		 * This checks every frame if we are ready to go to our next scene
		 * @param previousScene The a reference previous GameScene, left over from a previous pause screen functionality.
		 * @return The next GameScene we want to switch to. We can return null instead if we don't want to switch quite yet.
		 */
		override public function update(previousScene: GameScene = null): GameScene {
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
					if (clickText.alpha <= 0) {
						clickText.alpha = 0;
						textFadeInOrOut = true;
					}
				}
			}
			if (KeyboardInput.onKeyDown(Keyboard.ENTER)) {
				//trace("if is true");
				return new SceneTitle();
			}
			return null
		}
	}

}