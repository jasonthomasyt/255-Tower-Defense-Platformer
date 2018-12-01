package code {

	import flash.display.MovieClip;

	public class Castle extends MovieClip {

		/** Checks for if the castle should be deleted. */
		public var isDead: Boolean = false;

		/** The collider for the castle. */
		public var colliderCenter: AABB;
		/** The collider for the castle. */
		public var colliderRight: AABB;
		/** The collider for the castle. */
		public var colliderLeft: AABB;

		public var health: int = 100;

		public var maxHealth: int = 100;

		public function Castle() {
			colliderCenter = new AABB(colliderBoxCenter.width / 2, colliderBoxCenter.height / 2);
			colliderRight = new AABB(colliderBoxRight.width / 2, colliderBoxRight.height / 2);
			colliderLeft = new AABB(colliderBoxLeft.width / 2, colliderBoxLeft.height / 2);
			colliderBoxCenter.alpha = 0;
			colliderBoxRight.alpha = 0;
			colliderBoxLeft.alpha = 0;
		}

		/**
		 * The update design pattern for the castle.
		 */
		public function update(): void {

			colliderCenter.calcEdges(x, y);
			colliderRight.calcEdges(x, y);
			colliderLeft.calcEdges(x, y);
			castleHealth.barColor.scaleX = health / maxHealth;
			if (health <= 0) isDead = true;
		}
	}

}