package code {
	
	import flash.display.MovieClip;
	
	
	public class HUD extends MovieClip {
		
		
		public function HUD() {
			// constructor code
		}
		public function update(scenePlay:ScenePlay):void {
			
			parent.setChildIndex(this, parent.numChildren - 1);
			
			scoreboard.text = "score: " + scenePlay.score;
			coinboard.text = "coin: " + scenePlay.coinCount;
			bar.scaleX = scenePlay.player.health / scenePlay.player.maxHealth;
			
			
			
		}
	}
	
}
