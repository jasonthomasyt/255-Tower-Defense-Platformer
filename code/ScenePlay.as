package code {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class ScenePlay extends GameScene {

		/** This is our array of Bullet Objects. */
		private var bullets: Array = new Array();
		private var level: MovieClip;
		private var shakeTimer: Number = 0;
		/**
		 *
		 */
		public function ScenePlay() {
			// constructor code
			loadLevel();
		}
		private function doCameraMove(): void {
			var targetX: Number = -player.x + stage.stageWidth / 2;
			var targetY: Number = -player.y + stage.stageHeight / 2;
			var offsetX: Number = 0 //Math.random() * 20 - 10;
			var offsetY: Number = 0 //Math.random() * 20 - 10;
			var camEaseMultipler: Number = 5;
			level.x += (targetX - level.x) * Time.dt * camEaseMultipler + offsetX;
			level.y += (targetY - level.y) * Time.dt * camEaseMultipler + offsetY;
			if (shakeTimer > 0) {
				shakeTimer -= Time.dt;
				var shakeIntensity: Number = shakeTimer;
				if (shakeIntensity > 1) shakeIntensity = 1;
				shakeIntensity = 1 - shakeIntensity;
				shakeIntensity *= shakeIntensity;
				shakeIntensity = 1 - shakeIntensity;
				var shakeAmount: Number = 20 * shakeIntensity;
				offsetX = Math.random() * shakeAmount - shakeAmount / 2;
				offsetY = Math.random() * shakeAmount - shakeAmount / 2;

			}
		}
		/**
		 *
		 * @param previousScene
		 * @return
		 */
		override public function update(previousScene: GameScene = null): GameScene {
			player.update();
			doCameraMove();
			updateBullets();
			
			if (KeyboardInput.onKeyDown(Keyboard.R)) {
				//trace("if is true");
				return new SceneLose();
			}
			
			return null
		}
		/**
		 *
		 */
		override public function onBegin(): void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		} // end onBegin
		/**
		 *
		 */
		override public function onEnd(): void {

		} // end onEnd
		/**
		 * This event-handler is called everytime the left mouse button is down.
		 * It causes the player to shoot bullets.
		 * @param e The MouseEvent that triggered this event-handler.
		 */
		private function handleClick(e: MouseEvent): void {

			spawnBullet();

		} // ends handleClick
		/** 
		 * Spawns a bullet from the player everytime the user clicks the left mouse button.
		 */
		private function spawnBullet(): void {

			var b: Bullet = new Bullet(player);
			addChild(b);
			bullets.push(b);

		} // ends spawnBullet
		/**
		 * this loads the level
		 */
		private function loadLevel(): void {
			level = new Level01();
			addChild(level);
			if (level.player) {
				player = level.player;
			}
		}
		/**
		 * Updates bullets for every frame.
		 */
		private function updateBullets(): void {

			// update everything:
			for (var i: int = bullets.length - 1; i >= 0; i--) {
				bullets[i].update(); // Update design pattern.

				/** If bullet is dead, remove it. */
				if (bullets[i].isDead) {
					// remove it!!

					// 1. remove the object from the scene-graph
					removeChild(bullets[i]);

					// 2. nullify any variables pointing to it
					// if the variable is an array,
					// remove the object from the array
					bullets.splice(i, 1);
				}
			} // ends for loop updating bullets
		} // ends updateBullets
	}

}