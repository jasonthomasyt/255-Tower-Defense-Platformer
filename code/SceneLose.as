package code {

	import flash.display.MovieClip;
	import flash.ui.Keyboard;

	public class SceneLose extends GameScene {

		/** */
		private var textTimer:Number = 5;
		/** */
		private var textFadeInOrOut:Boolean = true;
		
		public function SceneLose() {
			// constructor code
		}
		/**
		 * Adds our EventListeners to the stage when this scene is created.
		 */
		override public function onBegin(): void {
			clickText.alpha = 0;
		} // end onBegin
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