package code {

	import flash.display.MovieClip;
	import flash.geom.Point;

	/**
	 *
	 */
	public class EnemyTough extends MovieClip {

		/** Whether or not This object should be dead. */
		public var isDead: Boolean = false;
		/** The collider for the player. */
		public var collider: AABB;

		public var radius: Number = 80;

		/** Sets the X max speed for the player. */
		private var maxSpeedX: Number = 50;
		/** Sets the velocity for the player. */
		private var velocity: Point = new Point(1, 5);

		/** Sets the horizontal acceleration constant for the player. */
		private const HORIZONTAL_ACCELERATION: Number = 400;
		/** Sets the horizontal deceleration constant for the player. */
		private const HORIZONTAL_DECELERATION: Number = 800;

		/** */
		public var sightDistance: Number = 50000;

		/** Detects the ground in the game. */
		var ground: Number = 2000;
		/** */
		public var validTargets: Array = new Array();

		/** */
		public var targetsDistances: Array = new Array();
		/** */
		public var closestTarget: int = -1;
		/** */
		public var closestTargetDist: Number = 20000;
		/** Checks if the player is on the ground. */
		private var isGrounded: Boolean = false;

		/** Speed of the bullet. */
		public const SPEED: Number = 420;
		/** Sets the gravity for the player. */
		private var gravity: Point = new Point(0, 1000);
		/** Whether or not the player is moving upward in a jump.  This affects gravity. */
		private var isJumping: Boolean = false;
		/** The player's jump velocity. */
		private var jumpVelocity: Number = 500;
		/** */
		public var health: int = 100;
		/** */
		private var maxHealth: int = 100;

		/**
		 *
		 */
		public function EnemyTough() {
			// constructor code
			collider = new AABB(base.width / 2, base.height / 2);
			collider.calcEdges(x, y);
			x = 3690;
			y = 80;
		} // ends constructor
		/**
		 *
		 */
		public function takeDamage(d: int): void {
			health -= d;
			bar.barColor.scaleX = health / maxHealth;
			if (health <= 0) isDead = true;
		}
		/**
		 *
		 */
		public function update(): void {

			parent.setChildIndex(this, parent.numChildren - 2);
			/*
			DESIRED BEHAVIOR:
			LOOK FOR THE CASTLE AND THE THE TOWERS.
			WALK SLOWLY TO THE CLOSEST TARGET.
			IF WITHIN CLOSE RANGE, STOP AND DEAL DAMAGE VIA OVERLAPPING.
			*/
			clearValidTargetsArrays();
			findValidTargets();
			findTargetsDistances();
			getClosestTarget();
			moveToClosestTarget();
			//if this object is touching a tower or castle, do not move. Otherwise, move left.
			//This object can tell if it is touching a tower or castle by doing it's own AABB collision detection function.
			isCollidingWithStructure();

			doPhysics();

			detectDeathGround();

			collider.calcEdges(x, y);
			isGrounded = false;
			trace("Cuurent Location: " + x);
			trace("Current Velocity: " + velocity.x);
		} // ends update
		/**
		 *
		 */
		private function isCollidingWithStructure(): void {
			//trace("Am I colliding with a structure?");
			if (ScenePlay.towers.length > 0) {
				//trace("Well there is at least one tower on the map.");
				for (var i: int = 0; i < ScenePlay.towers.length; i++) {
					//trace("Well there are " + i + " towers for me to collide with");
					if (this.collider.checkOverlap(ScenePlay.towers[i].colliderSpire)) {
						
						handleWalking(0);
						return
					}
					if (this.collider.checkOverlap(ScenePlay.towers[i].colliderBase)) {
						handleWalking(0);
						return
					}
				}
			}

			if (this.collider.checkOverlap(ScenePlay.main.castle.colliderCenter)) {
				handleWalking(0);
				return
			}
			if (this.collider.checkOverlap(ScenePlay.main.castle.colliderRight)) {
				handleWalking(0);
				return
			}
			if (this.collider.checkOverlap(ScenePlay.main.castle.colliderLeft)) {
				handleWalking(0);
				return
			}
			//if we make it this far, then this Toughie isn't colliding with any structures.
			handleWalking(-1);
		} // ends isCollidingWithStructure
		/**
		 * This function looks at the direction input in order to accelerate the enemy, changing the enemy's velocity.
		 * @param direction If a negative number is passed in, it accelerates left. If positive, it'll accelerate right.
		 */
		public function handleWalking(direction: int): void {
			if (this.x > 750) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
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
		 *
		 */
		public function moveToClosestTarget(): void {
			/*
			velocity.x = SPEED * Math.cos(angle);
			velocity.y = SPEED * Math.sin(angle);
			
			// Moves bullet according to velocity.
			x += velocity.x * Time.dtScaled;
			y += velocity.y * Time.dtScaled;
			*/
		}
		/**
		 *
		 */
		public function clearValidTargetsArrays(): void {
			if (targetsDistances.length > 0) targetsDistances.length = 0;
			if (validTargets.length > 0) validTargets.length = 0;
			closestTargetDist = sightDistance;
		}
		/**
		 *
		 */
		public function findValidTargets(): void {
			//trace("looking for castle");
			validTargets.push(ScenePlay.main.castle);
			//trace(validTargets[0]);
			for (var i: int = 0; i < ScenePlay.towers.length; i++) {
				//trace("looking for tower " + i);
				validTargets.push(ScenePlay.towers[i]);
			}
			//trace("looking for player");
			validTargets.push(ScenePlay.main.player);
		}
		/**
		 *
		 */
		public function findTargetsDistances(): void {
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
			}
		}
		/**
		 *
		 */
		public function getClosestTarget(): void {
			if (validTargets.length > 0) {
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
		}
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
		 * Handles physics for the player.
		 * Sets the velocity to the gravity and max speed.
		 */
		public function doPhysics(): void {

			if (velocity.y > 0) isJumping = false;

			var gravityMultiplier: Number = 2;
			if (!isJumping) gravityMultiplier = 2;

			// apply gravity to velocity:
			//velocity.x += gravity.x * Time.dt * gravityMultiplier;
			velocity.y += gravity.y * Time.dtScaled * gravityMultiplier;

			// constrain to maxSpeed:
			if (velocity.x > maxSpeedX) velocity.x = maxSpeedX; // clamp going right
			if (velocity.x < -maxSpeedX) velocity.x = -maxSpeedX; // clamp going left

			// apply velocity to position:
			x += velocity.x * Time.dtScaled;
			y += velocity.y * Time.dtScaled;
		} // ends doPhysics
		/**
		 * Applies the overlap fix detected by the collider.
		 * Adjusts the player position according to the fix.
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

			if (fix.y < 0) { // we moved the enemy up, so they are on the ground.
				isGrounded = true;
			}

			collider.calcEdges(base.x, base.y);
		} // ends applyFix

	} // ends class EnemyTough
} // ends package code