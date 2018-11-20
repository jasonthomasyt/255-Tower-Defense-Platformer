package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * 
	 */
	public class Enemy extends MovieClip {
		
		/** Sets the gravity for the player. */
		private var gravity: Point = new Point(0, 1000);
		
		/** Sets the X max speed for the player. */
		private var maxSpeedX: Number = 200;
		
		/** Sets the velocity for the player. */
		private var velocity: Point = new Point(1, 5);

		/** Sets the horizontal acceleration constant for the player. */
		private const HORIZONTAL_ACCELERATION: Number = 800;
		
		/** Sets the horizontal deceleration constant for the player. */
		private const HORIZONTAL_DECELERATION: Number = 800;
		
		/** Detects the ground in the game. */
		var ground: Number = 2000;
		
		/** The angle that the gun is pointed. */
		public var angle: Number = 0;
		
		/** The collider for the player. */
		public var collider:AABB;
		
		/** Whether or not This object should be dead. */
		public var isDead:Boolean = false;
		
		/** How far in pixels the enemy can detect a valid target to shoot at. */
		private var shootingRange:Number = 1000;
		
		/** */
		private var validTargets:Array = new Array();
		
		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer:Number = 1;
		
		/**
		 * 
		 */
		public function Enemy() {
			// constructor code
		} // end constructor
		/**
		 * The update design pattern for the enemy.
		 * Handles walking, aiming, and calculating our collision box.
		 */
		public function update(): void {

			if (findValidTargets()) {
				handleAiming();
				aimingTimer += Time.dtScaled;
				if (aimingTimer <= 0) {
					shootTarget();
					aimingTimer = 1;
				}
			} else {
				handleWalking();
				aimingTimer -= Time.dtScaled;
				if (aimingTimer >= 1) aimingTimer = 1;
			}
			
			doPhysics();
			
			detectDeathGround();
			
			collider.calcEdges(x, y);
			
			//trace(y);
		} // ends update
		/**
		 * 
		 */
		private function findValidTargets(): Boolean {
			if(validTargets.length > 0) {
				return true
			} else return false
		}
		/**
		 * 
		 */
		private function shootTarget(): void {
			
		}
		/**
		 * This function looks at the keyboard input in order to accelerate the player
		 * left or right.  As a result, this function changes the player's velocity.
		 */
		private function handleWalking(): void {
			
			if (KeyboardInput.isKeyDown(Keyboard.A)) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (KeyboardInput.isKeyDown(Keyboard.D)) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (!KeyboardInput.isKeyDown(Keyboard.A) && !KeyboardInput.isKeyDown(Keyboard.D)) { // left and right not being pressed...
				if (velocity.x < 0) { // moving left
					velocity.x += HORIZONTAL_DECELERATION * Time.dt; // accelerate right
					if (velocity.x > 0) velocity.x = 0; // clamp at 0
				}

				if (velocity.x > 0) {
					velocity.x -= HORIZONTAL_DECELERATION * Time.dt; // accelerate left
					if (velocity.x < 0) velocity.x = 0; // clamp at 0
				}
			}
			
		} // ends handleWalking
		/**
		 * Detects when the player has hit the death plane.
		 */
		/**
		 * Handles physics for the player.
		 * Sets the velocity to the gravity and max speed.
		 */
		private function doPhysics(): void {
			
			var gravityMultiplier:Number = 2;
			
			//if (!isJumping) gravityMultiplier = 2;
			
			// apply gravity to velocity:
			//velocity.x += gravity.x * Time.dt * gravityMultiplier;
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			// constrain to maxSpeed:
			if (velocity.x > maxSpeedX) velocity.x = maxSpeedX; // clamp going right
			if (velocity.x < -maxSpeedX) velocity.x = -maxSpeedX; // clamp going left

			// apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		} // ends doPhysics
		private function detectDeathGround(): void {
			// look at y position
			if (y >= ground) {
				isDead = true;
			}
		} // ends detectGround
		/**
		 * Changes the gun's rotation based on where the mouse is pointing.
		 */
		private function handleAiming(): void {
			var tx: Number = parent.mouseX - x;
			var ty: Number = parent.mouseY - y;
			
			angle = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			gun.rotation = angle + 90;
			
			if (gun.rotation > -45 && gun.rotation < 0) gun.rotation = 45;
			if (gun.rotation < 45 && gun.rotation > 0) gun.rotation = -45;
			if (gun.rotation < -135 && gun.rotation > -170) gun.rotation = 135;
			if (gun.rotation > 135 && gun.rotation < 170) gun.rotation = -135;
		} // end handleAiming
	} // end class Enemy
} // end package code