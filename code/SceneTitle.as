package code {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	/**
	 * This is our Title Scene Object Class.
	 */
	public class SceneTitle extends GameScene {
		
		/**
		 * This is our constructor code for this Object
		 */
		public function SceneTitle() {
			// constructor code
		}
		/**
		 * This checks every frame if we are ready to go to our next scene
		 * @param previousScene If passed in, it is a cache to whatever scene came before this.
		 * @return We return null if we don't need to swtich scenes yet. If a GameScene Object is returned, then we will switch to that scene.
		 */
		override public function update(previousScene:GameScene=null):GameScene {
			//trace("title tick");
			if (KeyboardInput.onKeyDown(Keyboard.ENTER)) {
				//trace("if is true");
				return new ScenePlay();
			}
			return null
		} 
	}
	
}
