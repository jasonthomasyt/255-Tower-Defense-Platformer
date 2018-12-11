package code {
	/**
	 * This is the class for bomb turrets.
	 */
	public class BombTurret extends Turret{		
		/* How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;
		/**
		 * Constructor code for bomb turrets.
		 */
		public function BombTurret() {
			
		}// ends BombTurret
		/** 
		 * Shooting function for basic turrets.
		 */
		override public function shootTarget():void {
			// De-increments the aiming timer.
			aimingTimer -= Time.dtScaled;			
			if (aimingTimer <= 0) {// If aiming timer runs out...
				// Reset aiming timer
				aimingTimer = 2;
				// Spawn a bullet
				ScenePlay.main.spawnBomb(this);
			}// ends ifs
		}// ends shootTarget
	}// ends class
}// ends package
