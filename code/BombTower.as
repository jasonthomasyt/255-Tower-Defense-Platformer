package code {

	/**
	 * 
	 */
	public class BombTower extends Tower {

		/** The collider for the player. */
		public var colliderSpire: AABB;
		/** The collider for the player. */
		public var colliderBase: AABB;
		
		public var isBasicTower = false;
		
		public var isRapidTower = false;
		
		public var isBombTower = true;
		
		/**
		 * 
		 */
		public function BombTower() {
			// constructor code
			colliderSpire = new AABB(bombTowerSpire.width / 2, bombTowerSpire.height / 2);
			colliderBase = new AABB(bombTowerBase.width / 2, bombTowerBase.height / 2);
		}
		/**
		 * 
		 * 
		 */
		public override function update(scenePlay: ScenePlay): void {
			towerHealth.barColor.scaleX = health / maxHealth;
			
			colliderSpire.calcEdges(x, y);
			colliderBase.calcEdges(x, y);
		}
	}
}