package code {
	/**
	 * This is the class for basic towers.
	 */
	public class BasicTower extends Tower {
		/* The collider for the tower's spire. */
		public var colliderSpire: AABB;
		/* The collider for the tower's base. */
		public var colliderBase: AABB;
		/* Bools identifying this tower */
		public var isBasicTower = true;		
		public var isRapidTower = false;		
		public var isBombTower = false;		
		/**
		 * Constructor code for the basic tower.
		 */
		public function BasicTower() {
			// Insantiates the tower's colliders.
			colliderSpire = new AABB(basicTowerSpire.width / 2, basicTowerSpire.height / 2);
			colliderBase = new AABB(basicTowerBase.width / 2, basicTowerBase.height / 2);
		}// ends RapidTower
		/**
		 * The update function for the rapid-fire towers.
		 */
		public override function update(scenePlay: ScenePlay): void {
			// Updates the tower's health bar
			towerHealth.barColor.scaleX = health / maxHealth;
			// Updates the tower's AABBs
			colliderSpire.calcEdges(x, y);
			colliderBase.calcEdges(x, y);
		}// ends update
	}// ends class
}// ends package