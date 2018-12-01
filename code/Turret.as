package  code {
	
	import flash.display.MovieClip;
	
	/* This is the class for the turret */
	public class Turret extends MovieClip {
		
		/** */
		public var closestTarget: int = -1;
		/** */
		public var validTargets: Array = new Array();
		/** The angle that the gun is pointed. */
		public var angle: Number = 0;
		/** */
		public var targetsDistances: Array = new Array();
		/** */
		public var closestTargetDist: Number = 20000;
		/** */
		public var sightDistance: Number = 500;
		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;
		
		/**
		 * Constructor code for the turret class 
		 */
		public function Turret() {
			// constructor code
		}
		/**
		 * Update function for the turret
		 */
		public function update():void {
			
			/*
			 * Updates the rotation angle of the turret to follow the mouse
			 * TO DO: Update to follow closest enemy
			 */
			handleAiming();
			findValidTargets();
			shootTarget();
		}
		/**
		 * Changes the gun's rotation based on where the mouse is pointing.
		 */
		public function handleAiming(): void {
			if (closestTarget <= -1) return
			var tx: Number = validTargets[closestTarget].x - x;
			var ty: Number = validTargets[closestTarget].y - y;

			angle = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			rotation = angle + 90;
		} // end handleAiming

		/**
		 *
		 */
		public function findValidTargets(): void {
			if (targetsDistances.length > 0) targetsDistances.length = 0;
			if (validTargets.length > 0) validTargets.length = 0;
			closestTargetDist = sightDistance;
			//trace(validTargets[0]);
			for (var i: int = 0; i < ScenePlay.enemies.length; i++) {
				//trace("looking for enemy " + i);
				validTargets.push(ScenePlay.enemies[i]);
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
		 *
		 */
		public function shootTarget(): void {
			//trace(aimingTimer + "Before");
			aimingTimer -= Time.dtScaled;
			//trace(aimingTimer + "After");
			if (aimingTimer <= 0) {
				aimingTimer = 1;
				ScenePlay.main.spawnBullet(this);
			}
		}
	}
}