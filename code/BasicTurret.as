package code {
	/**
	 * This is the class for basic turrets.
	 */
	public class BasicTurret extends Turret {		
		/* How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;
		/**
		 * Constructor code for basic turrets.
		 */
		public function BasicTurret() {
			
		}// ends BasicTurret
		/** 
		 * Shooting function for basic turrets.
		 */
		override public function shootTarget():void {
			// De-increments the aiming timer.
			aimingTimer -= Time.dtScaled;
			if (aimingTimer <= 0) {// If aiming timer runs out...
				// Reset aiming timer
				aimingTimer = 1;
				// Spawn a bullet
				ScenePlay.main.spawnBullet(this);
			}//ends ifs
		}// ends shootTarget
	}//ends class
}// ends package