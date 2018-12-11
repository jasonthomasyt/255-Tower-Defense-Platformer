package code {

	import flash.display.MovieClip;


	public class HUD extends MovieClip {

		/**
		 * sets all arows to fales when they are made
		 */
		var index: int = 1;
		public function HUD() {
			// constructor code
			arrowD.visible = false;
			arrowU.visible = false;
			arrowL.visible = false;
			arrowR.visible = false;
		}
		/**
		 *sets up all the visual indicators of health, waves, coins, and directional arrows based on enmeys location.
		 */
		public function update(scenePlay: ScenePlay): void {

			parent.setChildIndex(this, parent.numChildren - 1);

			waveboard.text = "Wave: " + scenePlay.waveCount;
			coinboard.text = "Coins: " + scenePlay.coinCount;
			bar.barColor.scaleX = scenePlay.player.health / scenePlay.player.maxHealth;
			castleHealth.barColor.scaleX = scenePlay.castle.health / scenePlay.castle.maxHealth;
			enemiesboard.text = "Enemies Remaining: " + scenePlay.enemiesRemainingCount;

		}
	}
}