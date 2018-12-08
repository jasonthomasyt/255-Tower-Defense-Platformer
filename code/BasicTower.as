package code {

	/**
	 * 
	 */
	public class BasicTower extends Tower {

		/** The collider for the player. */
		public var colliderSpire: AABB;
		/** The collider for the player. */
		public var colliderBase: AABB;
		
		public var isBasicTower = true;
		
		public var isRapidTower = false;
		
		public var isBombTower = false;
		
		/**
		 * 
		 */
		public function BasicTower() {
			// constructor code
			colliderSpire = new AABB(basicTowerSpire.width / 2, basicTowerSpire.height / 2);
			colliderBase = new AABB(basicTowerBase.width / 2, basicTowerBase.height / 2);
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