package code {
	
	public class BasicTurret extends Turret {
		
		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;

		public function BasicTurret() {
			// constructor code
		}
		
		override public function shootTarget():Turret {
			aimingTimer -= Time.dtScaled;
			//trace(aimingTimer + "After");
			if (aimingTimer <= 0) {
				aimingTimer = 1;
				ScenePlay.main.spawnBullet(this);
				return null
			}
			return null
		}
	}	
}
