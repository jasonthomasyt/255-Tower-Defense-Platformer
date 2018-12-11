package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;

	/**
	 * The class for the Enemy Object.
	 */
	public class Enemy extends MovieClip {

		/** Sets the gravity for the player. */
		private var gravity: Point = new Point(0, 1000);
		/** Sets the X max speed for the player. */
		private var maxSpeedX: Number = 100;
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

		/** The collider for the enemy. */
		public var collider: AABB;

		/** The current state of this Enemy Object */
		private var state: EnemyState;

		/** How far can this Enemy "see" other Objects it can shoot */
		public var sightDistance: Number = 500;

		/** Detects the ground in the game. */
		var ground: Number = 2000;

		/** The angle that the gun is pointed. */
		public var angle: Number = 0;

		/** Whether or not This object should be dead. */
		public var isDead: Boolean = false;

		/** How far in pixels the enemy can detect a valid target to shoot at. */
		private var shootingRange: Number = 1000;

		/** An array of all possible targets this any could attack. */
		public var validTargets: Array = new Array();

		/** An array of how far away all of the Valid targets are. */
		public var targetsDistances: Array = new Array();

		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;

		/** The array index of which target is the closest and should focus on. If it is -1 or less, it won't focus on anything. */
		public var closestTarget: int = -1;
		/** Thie total distance of the closest target. */
		public var closestTargetDist: Number = 20000;

		/**
		 * The constructor code for our Enemy Object
		 */
		public function Enemy() {
			// constructor code
			collider = new AABB(base.width / 2, base.height / 2);
			changeState(new EnemyStateIdle());
			closestTargetDist = sightDistance;
			x = 3690;
			y = 80;
		} // end constructor
		/**
		 * The update design pattern for the enemy. Handles walking, aiming, and calculating our collision box.
		 */
		public function update(): void {

			//trace("enemy update");

			parent.setChildIndex(this, parent.numChildren - 2);

			if (state) {
				var nextState: EnemyState = state.update(this)
				changeState(nextState);
			}
			/*
			DESIRED BEHAVIOR:
			LOOK FOR THE CASTLE, THE TOWERS, AND THE PLAYER.
			IF ANY OF THOSE TARGETS ARE WITHIN RANGE, SHOOT THAT TARGET.
			IF NONE ARE IN RANGE, ADVANCE TO THE LEFT.
			*/
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
			doPhysics();

			detectDeathGround();

			collider.calcEdges(x, y);
			isGrounded = false;

			//empty validTargets Array();
			//trace(validTargets.length);


			//trace(y);
		} // ends update
		/**
		 * This changes the state of our Enemy Object
		 * @param nextState The next state we want to switch to.
		 */
		private function changeState(nextState: EnemyState): void {
			if (nextState == null) return;
			if (state) state.onEnd();
			state = nextState;
			state.onBegin();
		}
		/**
		 * This is the main function of our Enemy. It basically runs most of our behavior logic.
		 */
		public function findValidTargets(): void {
			if (targetsDistances.length > 0) targetsDistances.length = 0;
			if (validTargets.length > 0) validTargets.length = 0;
			closestTargetDist = sightDistance;
			//trace("looking for castle");
			validTargets.push(ScenePlay.main.castle);
			//trace(validTargets[0]);
			for (var i: int = 0; i < ScenePlay.towers.length; i++) {
				//trace("looking for tower " + i);
				validTargets.push(ScenePlay.towers[i]);
			}
			//trace("looking for player");
			validTargets.push(ScenePlay.main.player);
			if (validTargets.length > 0) {
				//find the distances between the enemy and the targets.
				for (var j: int = 0; j < validTargets.length; j++) {
					//trace("finding distance between me and " + validTargets[j]);
					var distX: Number = validTargets[j].x - x;
					var distY: Number = validTargets[j].y - y;
					//trace("pushing Distance");
					var dist: Number = Math.sqrt(distX * distX + distY * distY)
					//trace("Distance found: " + dist);
					targetsDistances.push(dist);

				}
				//get the clostest target
				for (var k: int = 0; k < targetsDistances.length; k++) {
					//trace(targetsDistances[k] + " ? " + closestTargetDist);
					if (targetsDistances[k] < closestTargetDist) {
						//trace("if ClosestTarget");
						closestTargetDist = targetsDistances[k];
						closestTarget = k;
						//trace("Closest Target: #" + k + validTargets[k] + " Distance: " + targetsDistances[k]);
					} else if (closestTarget <= -1) {
						closestTarget = -1;
						//trace("No closest Target");
					}
				}
			}
			//trace("closestTarget: " + closestTarget);

		}
		/**
		 * This function calls our spawnBulletBad function in ScenePlay after incrimenting a timer.
		 */
		public function shootTarget(): void {
			//trace(aimingTimer + "Before");
			aimingTimer -= Time.dtScaled;
			//trace(aimingTimer + "After");
			if (aimingTimer <= 0) {
				aimingTimer = 1;
				ScenePlay.main.spawnBulletBad(this);
			}
		}
		/**
		 * This function looks at the direction input in order to accelerate the enemy, changing the enemy's velocity.
		 * @param direction If a negative number is passed in, it accelerates left. If positive, it'll accelerate right.
		 */
		public function handleWalking(direction: int): void {
			if (this.x > 750 ) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
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
			/*
			if (this.x > 2000) {
				//trace(this.x);
				velocity.x -= HORIZONTAL_DECELERATION * Time.dt;
			}
			if (this.x < 800) {
				velocity.x = 0;

			} 
			*/
		}// ends handleWalking

		/**
		 * Handles the jumping action for the enemy.
		 */
		private function jump(): void {

			if (isGrounded) { // we are on the ground...
				isGrounded = false; // not on ground
				velocity.y = -jumpVelocity; // apply an impulse up
				isJumping = true;
			}
		} // ends handleJumping
		/**
		 * Handles physics for the player. Sets the velocity to the gravity and max speed.
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
		 * Applies the overlap fix detected by the collider. Adjusts the enemy position according to the fix.
		 * @param fix The position the enemy needs to move to in order to fix it's overlap.
		 */
		public function applyFix(fix: Point): void {
			if (fix.x != 0) {
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
		public function handleAiming(): void {
			if (closestTarget <= -1) return;
			var tx: Number = validTargets[closestTarget].x - x;
			var ty: Number = validTargets[closestTarget].y - y;

			angle = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			gun.rotation = angle + 90;

			if (gun.rotation > -45 && gun.rotation < 0) gun.rotation = -45;
			if (gun.rotation < 45 && gun.rotation > 0) gun.rotation = 45;
			if (gun.rotation < -135 && gun.rotation > -170) gun.rotation = -135;
			if (gun.rotation > 135 && gun.rotation < 170) gun.rotation = 135;
		} // end handleAiming
	} // end class Enemy
} // end package code