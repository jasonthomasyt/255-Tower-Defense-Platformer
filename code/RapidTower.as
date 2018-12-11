package code {
	/**
	 * This is the class for rapid-fire towers.
	 */
	public class RapidTower extends Tower {
		/* The collider for the tower's spire. */
		public var colliderSpire: AABB;
		/* The collider for the tower's base. */
		public var colliderBase: AABB;
		/* Bools identifying this tower */
		public var isBasicTower = false;		
		public var isRapidTower = true;		
		public var isBombTower = false;		
		/**
		 * Constructor code for the rapid-fire tower.
		 */
		public function RapidTower() {
			// Instantiates the tower's colliders.
			colliderSpire = new AABB(rapidTowerSpire.width / 2, rapidTowerSpire.height / 2);
			colliderBase = new AABB(rapidTowerBase.width / 2, rapidTowerBase.height / 2);
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