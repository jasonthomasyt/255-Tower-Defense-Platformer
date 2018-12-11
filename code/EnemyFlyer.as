package code {

	import flash.display.MovieClip;
	import flash.geom.Point;

	/**
	 * The class for the EnemyFlyer Object.
	 */
	public class EnemyFlyer extends MovieClip {

		/** Sets the X max speed for the player. */
		private var maxSpeedX: Number = 200;
		/** Sets the velocity for the player. */
		private var velocity: Point = new Point(1, 5);

		/** Sets the horizontal acceleration constant for the flying enemy. */
		private const HORIZONTAL_ACCELERATION: Number = 500;
		/** Sets the horizontal deceleration constant for the flying enemy. */
		private const HORIZONTAL_DECELERATION: Number = 800;

		/** How far can this Enemy "see" other Objects it can move towards */
		public var sightDistance: Number = 50000;

		/** Detects the ground in the game. */
		var ground: Number = 2000;

		/** The angle that the gun is pointed. */
		public var angle: Number = 0;

		/** Whether or not This object should be dead. */
		public var isDead: Boolean = false;

		/** An array of all possible targets this any could attack. */
		public var validTargets: Array = new Array();

		/** An array of how far away all of the Valid targets are. */
		public var targetsDistances: Array = new Array();

		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;

		/** The array index of which target is the closest and should focus on. */
		public var closestTarget: int = -1;
		/** Thie total distance of the closest target. */
		public var closestTargetDist: Number = 20000;
		/** Checks if the player is on the ground. */
		private var isGrounded: Boolean = false;
		
		/** Speed of the enemy. */
		public const SPEED: Number = 400;
		/** The radius of this object, sometimes used for collision detection. */
		public var radius: Number = 30;
		
		/** The collider for the flying enemy. */
		public var collider: AABB;

		/**
		 * The constructor code for our EnemyFlyer Object
		 */
		public function EnemyFlyer() {
			collider = new AABB(base.width / 2, base.height / 2);
			collider.calcEdges(x, y);
			closestTargetDist = sightDistance;
			x = 3690;
			y = 80;
		} // ends constructor
		/**
		 * The update design pattern for the enemy. Handles flying, aiming, and calculating our collision box.
		 */
		public function update(): void {
			//trace("enemy update");
			parent.setChildIndex(this, parent.numChildren - 2);
			/*
			DESIRED BEHAVIOR:
			LOOK FOR THE CASTLE, THE TOWERS, AND THE PLAYER.
			FLY TO THE CLOSEST TARGET.
			IF WITHIN CLOSE RANGE, BLOW YOURSELF UP AND DAMAGE EVERYTHING IN THAT RANGE.
			*/
			clearValidTargetsArrays();
			findValidTargets();
			findTargetsDistances();
			getClosestTarget();
			moveToClosestTarget();
			collider.calcEdges(x, y);
			
			detectDeathGround();
		
			//collider.calcEdges(x, y);
			//trace(y);
		} // ends update

		/**
		 * This handles our movement towrds our closest target.
		 */
		public function moveToClosestTarget(): void {
			handleAiming();
			
			velocity.x = SPEED * Math.cos(angle);
			velocity.y = SPEED * Math.sin(angle);
			
			// constrain to maxSpeed:
			if (velocity.x > maxSpeedX) velocity.x = maxSpeedX; // clamp going right
			if (velocity.x < -maxSpeedX) velocity.x = -maxSpeedX; // clamp going left
			
			// Moves enemy according to velocity.
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		}
		/**
		 * This gets called at the beginning of every update to clear out all values left over from last frame.
		 */
		public function clearValidTargetsArrays(): void {
			if (targetsDistances.length > 0) targetsDistances.length = 0;
			if (validTargets.length > 0) validTargets.length = 0;
			closestTargetDist = sightDistance;
		}
		/**
		 * This function fills the validTargets array with everything this Enemy can damage.
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
		 * This function takes every Object in the validTargets Array and finds their total distances between them and this Object.
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
		 * This function looks at every value in our targetDistances Array, picks the closest target, and sets it's closestTarget 
		 * to that array index. If no targets are within it's sight range, it sets closestTarget to -1.
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
		 * Detects when the enemy has hit the death plane.
		 */
		private function detectDeathGround(): void {
			// look at y position
			if (y >= ground) {
				isDead = true;
			}
		} // ends detectGround
		/**
		 * Changes the rotation of this Object based on where the closestTarget is on-screen.
		 */
		public function handleAiming(): void {
			//trace(closestTarget);
			if (closestTarget <= -1) return;
			var tx: Number = validTargets[closestTarget].x - x;
			var ty: Number = validTargets[closestTarget].y - y;

			angle = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			rotation = angle + 90;
		} // end handleAiming
	} // ends class Flyer
} // ends package code