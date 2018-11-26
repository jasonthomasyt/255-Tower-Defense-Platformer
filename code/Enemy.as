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

		/** Checks if the player is on the ground. */
		private var isGrounded: Boolean = false;
		/** Whether or not the player is moving upward in a jump.  This affects gravity. */
		private var isJumping: Boolean = false;
		/** The player's jump velocity. */
		private var jumpVelocity: Number = 500;

		/** The collider for the player. */
		public var collider: AABB;
		
		/** */
		private var state:EnemyState;
		
		/** */
		public var sightDistance:Number = 100;

		/** Detects the ground in the game. */
		var ground: Number = 2000;

		/** The angle that the gun is pointed. */
		public var angle: Number = 0;

		/** Whether or not This object should be dead. */
		public var isDead: Boolean = false;

		/** How far in pixels the enemy can detect a valid target to shoot at. */
		private var shootingRange: Number = 1000;

		/** */
		private var validTargets: Array = new Array();

		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;

		/**
		 *
		 */
		public function Enemy() {
			// constructor code
			ScenePlay.enemies.push(this);
			collider = new AABB(width / 2, height / 2);
			changeState(new EnemyStateIdle());
		} // end constructor
		/**
		 * The update design pattern for the enemy.
		 * Handles walking, aiming, and calculating our collision box.
		 */
		public function update(): void {

			//trace("enemy update");
			
			if(state) {
				var nextState:EnemyState = state.update(this)
				changeState(nextState);
			}
			/*
			if (findValidTargets()) {
				handleAiming();
				aimingTimer += Time.dtScaled;
				if (aimingTimer <= 0) {
					shootTarget();
					aimingTimer = 1;
				}
			} else {
				handleWalking(0);
				aimingTimer -= Time.dtScaled;
				if (aimingTimer >= 1) aimingTimer = 1;
			}

			*/
			//doPhysics();

			detectDeathGround();

			collider.calcEdges(x, y);
			isGrounded = false;
			//trace(y);
		} // ends update
		/**
		 * 
		 * 
		 */
		private function changeState(nextState:EnemyState):void {
			if(nextState == null) return;
			if(state) state.onEnd();
			state = nextState;
			state.onBegin();
		}
		/**
		 *
		 */
		private function findValidTargets(): Boolean {
			if (validTargets.length > 0) {
				return true
			} else return false
		}
		/**
		 *
		 */
		private function shootTarget(): void {

		}
		/**
		 * This function looks at the direction input in order to accelerate the enemy, changing the enemy's velocity.
		 * @param direction If a negative number is passed in, it accelerates left. If positive, it'll accelerate right.
		 */
		public function handleWalking(direction: int): void {
			if (direction < 0) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (direction > 0) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (direction == 0) { // left and right not being pressed...
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
		 * Handles the jumping action for the player.
		 */
		private function jump(): void {

			if (isGrounded) { // we are on the ground...
				isGrounded = false; // not on ground
				velocity.y = -jumpVelocity; // apply an impulse up
				isJumping = true;
			}
		} // ends handleJumping
		/**
		 * Handles physics for the player.
		 * Sets the velocity to the gravity and max speed.
		 */
		public function doPhysics(): void {

			if (velocity.y > 0) isJumping = false;
			
			var gravityMultiplier: Number = 2;
			if (!isJumping) gravityMultiplier = 2;

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
		/**
		 * Applies the overlap fix detected by the collider.
		 * Adjusts the player position according to the fix.
		 */
		public function applyFix(fix: Point):void {
			if (fix.x != 0){
				x += fix.x;
				velocity.x = 0;
			}
			
			if (fix.y != 0) {
				y += fix.y;
				velocity.y = 0;
			}
			
			if (fix.y < 0) { // we moved the player up, so they are on the ground.
				isGrounded = true;
			}
			
			collider.calcEdges(base.x, base.y);
		} // ends applyFix
		/**
		 * Detects when the player has hit the death plane.
		 */
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
		
		/**
		 * 
		 */
		public function getDistToPlayer():Number {
			var distX:Number = ScenePlay.main.player.x - x;
			var distY:Number = ScenePlay.main.player.y - y;
			
			return Math.sqrt(distX * distX + distY * distY);
		}
		
	} // end class Enemy
} // end package code