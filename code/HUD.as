package code {
	
	import flash.display.MovieClip;
	
	
	public class HUD extends MovieClip {
		
		
		public function HUD() {
			// constructor code
		}
		public function update(game:Game):void {
			
			parent.setChildIndex(this, parent.numChildren - 1);
			
			scoreboard.text = "score: " + Sceneplay.score;
			coinboard.text = "coin: " + player.coin;
			bar.scaleX = player.health;
			
			
			
		}
	}
	
}
