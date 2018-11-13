package code {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	
	public class ScenePlay extends GameScene {
		
		/** This is our array of Bullet Objects. */
		private var bullets: Array = new Array();
		/** This is our array of Platform Objects. */
		static public var platforms: Array = new Array();
		
		/**
		 * 
		 */
		public function ScenePlay() {
			// constructor code
		}
		/**
		 * 
		 * @param previousScene 
		 * @return 
		 */
		override public function update(previousScene:GameScene=null):GameScene {
			player.update();
			
			updateBullets();
			
			doCollisionDetection();
			
			if (KeyboardInput.onKeyDown(Keyboard.R)) {
				//trace("if is true");
				return new SceneLose();
			}
			
			return null
		}
		/**
		 * 
		 */
		override public function onBegin():void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		} // end onBegin
		/**
		 * 
		 */
		override public function onEnd():void {
			
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
		/**
		 * This is where we do all of our AABB collision decetction. It loops through all of our walls and checks if
		 * the player is colliding with any of them.
		 */
		private function doCollisionDetection(): void {

			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) { // if we are overlapping
					// find the fix:
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);

					// apply the fix:
					player.applyFix(fix);

				}
			} // ends for



		} // ends doCollisionDetection()
	}
	
}
