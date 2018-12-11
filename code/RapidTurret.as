package code {
	/**
	 * This is the class for rapid-fire turrets.
	 */
	public class RapidTurret extends Turret {
		/* How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;
		/**
		 * Constructor code for rapid-fire turrets.
		 */
		public function RapidTurret() {
			
		}//ends RapidTurret
		/** 
		 * Shooting function for rapid-fire turrets.
		 */
		override public function shootTarget():void {
			// De-increments the aiming timer.
			aimingTimer -= Time.dtScaled;
			if (aimingTimer <= 0) {// If aiming timer runs out...
				// Reset aiming timer
				aimingTimer = .2;
				// Spawn a bullet
				ScenePlay.main.spawnBullet(this);
			}// ends if
		}// ends shootTarget
	}// ends class
}// ends package
