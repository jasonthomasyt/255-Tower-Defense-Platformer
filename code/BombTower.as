package code {
	/**
	 * This is the class for bomb towers.
	 */
	public class BombTower extends Tower {
		/* The collider for the tower's spire. */
		public var colliderSpire: AABB;
		/* The collider for the toer's base. */
		public var colliderBase: AABB;
		/* Bools identifying this tower */
		public var isBasicTower = false;		
		public var isRapidTower = false;		
		public var isBombTower = true;		
		/**
		 * Constructor code for the bomb towers.
		 */
		public function BombTower() {
			// Instantiates the tower's colliders.
			colliderSpire = new AABB(bombTowerSpire.width / 2, bombTowerSpire.height / 2);
			colliderBase = new AABB(bombTowerBase.width / 2, bombTowerBase.height / 2);
		}// ends BombTower
		/**
		 * Update function for the bomb towers.
		 */
		public override function update(scenePlay: ScenePlay): void {
			// Updates the tower's health bar
			towerHealth.barColor.scaleX = health / maxHealth;
			// Updates the tower's colliders
			colliderSpire.calcEdges(x, y);
			colliderBase.calcEdges(x, y);
		}// ends update
	}// ends class
}// ends package