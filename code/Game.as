package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Game extends MovieClip {
		
		private var bullets: Array = new Array();
		
		
		public function Game() {
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);
		} // ends Game
		
		/**
		 * The gameLoop design pattern.
		 * Updates time, the player, and keyboard input.
		 */
		private function gameLoop(e: Event): void {
			
			Time.update();
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			
			player.update();
			
			updateBullets();
			
		} // ends gameLoop
		
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
	} // ends class
} // ends package
