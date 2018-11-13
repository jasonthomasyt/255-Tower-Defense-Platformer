package code {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	
	public class SceneLose extends GameScene {
		
		
		public function SceneLose() {
			// constructor code
		}
		override public function update(previousScene:GameScene=null):GameScene {
			if (KeyboardInput.onKeyDown(Keyboard.ESCAPE)) {
				//trace("if is true");
				return new SceneTitle();
			}
			return null
		}
	}
	
}
