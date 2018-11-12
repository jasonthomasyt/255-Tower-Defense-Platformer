package code {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	public class SceneTitle extends GameScene {
		
		
		public function SceneTitle() {
			// constructor code
		}
		override public function update(previousScene:GameScene=null):GameScene {
			if (KeyboardInput.OnKeyDown(Keyboard.SPACE)) {
				return new ScenePlay();
			}
			return null
		}
	}
	
}
