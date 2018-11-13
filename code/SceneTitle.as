package code {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	public class SceneTitle extends GameScene {
		
		
		public function SceneTitle() {
			// constructor code
		}
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
