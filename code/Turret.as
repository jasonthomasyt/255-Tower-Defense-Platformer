package code {
	import flash.display.MovieClip;
	
	/**
	 * This is the parent class for turrets.
	 */
	public class Turret extends MovieClip {
		/* Variable identifying the closest target */
		public var closestTarget: int = -1;
		/* Variable holding the tower's valid targets */
		public var validTargets: Array = new Array();
		/* Only the target that the turret is within the turret's sight distance should be held in this array. */
		public var currentTarget: Array = new Array();
		/* The angle that the gun is pointed. */
		public var angle: Number = 0;
		/* Array holding targets' distances */
		public var targetsDistances: Array = new Array();
		/* Variable holding the distance of the closest target */
		public var closestTargetDist: Number;
		/* Variable for the tower's aggro range */
		public var sightDistance: Number = 750;
		/* How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;
		
		/**
		 * Constructor code for the turret class
		 */
		public function Turret() {
			
		}// ends Turret
		
		/**
		 * Update function for the turret
		 */
		public function update(): void {
			// Finds targets within tower's sight range
			findValidTargets();
			// Aims the turret
			handleAiming();
			// If closest target is in range, shoot that target
			if (closestTarget >= 0) {
				shootTarget();
			}// ends if
		}// ends update
		
		/**
		 * Changes the gun's rotation based on where the mouse is pointing.
		 */
		public function handleAiming(): void {
			if (closestTarget <= -1) return // If target is in sight range...
			// Find vector to the target
			var tx: Number = validTargets[closestTarget].x - x;
			var ty: Number = validTargets[closestTarget].y - y;
			//Determine angle of rotation based on that vector
			angle = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			rotation = angle + 90;
		} // end handleAiming

		/**
		 * Function for finding valid targets.
		 */
		public function findValidTargets(): void {
			if (targetsDistances.length > 0) targetsDistances.length = 0;
			if (validTargets.length > 0) validTargets.length = 0;
			closestTargetDist = sightDistance;
			//trace(validTargets[0]);
			if (ScenePlay.enemies.length > 0) {
				for (var i: int = 0; i < ScenePlay.enemies.length; i++) {
					//trace("looking for enemy " + i);
					validTargets.push(ScenePlay.enemies[i]);
					//trace(validTargets[0]);
				}
			}
			if (ScenePlay.flyingEnemies.length > 0) {
				for (var i: int = 0; i < ScenePlay.flyingEnemies.length; i++) {
					//trace("looking for enemy " + i);
					validTargets.push(ScenePlay.flyingEnemies[i]);
					//trace(validTargets[0]);
				}
			}
			if (ScenePlay.toughEnemies.length > 0) {
				for (var i: int = 0; i < ScenePlay.toughEnemies.length; i++) {
					//trace("looking for enemy " + i);
					validTargets.push(ScenePlay.toughEnemies[i]);
					//trace(validTargets[0]);
				}
			}
			
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
				//get the closest target
				for (var k: int = 0; k < targetsDistances.length; k++) {
					//trace(targetsDistances[k] + " ? " + closestTargetDist);
					if (targetsDistances[k] <= closestTargetDist) {
						//trace("if ClosestTarget");
						closestTargetDist = targetsDistances[k];
						closestTarget = k;
						currentTarget.push(k);
						//trace("Closest Target: #" + k + validTargets[k] + " Distance: " + targetsDistances[k]);
					} else if (closestTarget <= -1) closestTarget = -1; // ends if
					if (currentTarget.length > 0) {
						// if the current tracked target's distance is greater than sight distance,
						// stop tracking target (out of range).
						for (var l: int = currentTarget.length - 1; l >= 0; l--) {
							if (targetsDistances[currentTarget[l]] > sightDistance) {
								closestTarget = -1;
								currentTarget.splice(l, 1);
							}// ends if
						}// ends for
					}// ends if
				}// ends for
			} else closestTarget = -1; // ends if
		}// ends findValidTargets
		
		/**
		 * Function handling shooting of targets.
		 * This function holds base values to be overridden by individual towers.
		 */
		public function shootTarget(): void {
			// De-increment aiming timer
			aimingTimer -= Time.dtScaled;
			if (aimingTimer <= 0) {// If aiming timer runs out...
				// Reset aiming timer
				aimingTimer = 1;
				// Spawn a bullet
				ScenePlay.main.spawnBullet(this);
				return
			}// ends ifs
		}// ends shootTarget
	}// ends class
}// ends package
			
﻿package code {
	import flash.display.MovieClip;
	
	/**
	 * This is the parent class for turrets.
	 */
		/* Variable identifying the closest target */
		/* How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;
		
		public function update(): void {
			// Finds targets within tower's sight range
			// Aims the turret
			// If closest target is in range, shoot that target
				shootTarget();
			}// ends if
		}// ends update
		