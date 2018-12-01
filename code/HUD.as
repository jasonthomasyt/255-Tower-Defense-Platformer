package code {
	
	import flash.display.MovieClip;
	
	
	public class HUD extends MovieClip {
		
		
		public function HUD() {
			// constructor code
		}
		public function update(scenePlay:ScenePlay):void {
			
			parent.setChildIndex(this, parent.numChildren - 1);
			
			waveboard.text = "Wave: " + scenePlay.score;
			coinboard.text = "Coins: " + scenePlay.coinCount;
			bar.barColor.scaleX = scenePlay.player.health / scenePlay.player.maxHealth;
			
			
			
		}
	}
	
}
