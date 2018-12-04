package code {
	
	public class BombTurret extends Turret{
		
		/** How long it takes for this enemy to shoot at it's target in seconds. */
		private var aimingTimer: Number = 1;

		public function BombTurret() {
			// constructor code
		}
		
		override public function shootTarget():Turret {
			aimingTimer -= Time.dtScaled;
			//trace(aimingTimer + "After");
			if (aimingTimer <= 0) {
				aimingTimer = 3;
				ScenePlay.main.spawnBomb(this);
				return null
			}
			return null
		}

	}
	
}
