package code {
	
	public class RapidTurret extends Turret {
		
		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;

		public function RapidTurret() {
			// constructor code
		}
		
		override public function shootTarget():void {
			aimingTimer -= Time.dtScaled;
			//trace(aimingTimer + "After");
			if (aimingTimer <= 0) {
				aimingTimer = .3;
				ScenePlay.main.spawnBullet(this);
			}
		}

	}
	
}
