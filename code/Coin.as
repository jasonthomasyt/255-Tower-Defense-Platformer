package code {

	import flash.display.MovieClip;
	import flash.geom.Point;

	/** This object is for all coins in the game. */
	public class Coin extends MovieClip {

		/** The collider for the coin. */
		public var collider: AABB;

		/** Sets the gravity for the coin. */
		private var gravity: Point = new Point(0, 500);

		/** The velocity for each coin. */
		private var velocity: Point = new Point(0, 10);

		/** Determines if the coin should be removed from the stage. */
		public var isDead: Boolean = false;

		/** Sets the horizontal deceleration constant for the coin. */
		private const HORIZONTAL_DECELERATION: Number = 50;
		
		/** Sets the angular deceleration constant for the coin. */
		private const ANGULAR_DECELERATION: Number = 50;
		
		/** Angular velocity for the coin. */
		private var angularVelocity: Number = 0;

		/**
		 * The constructor function for the coin game object. 
		 */
		public function Coin(spawnX: Number, spawnY: Number) {

			collider = new AABB(width / 2, height / 2);

			x = spawnX;
			y = spawnY;

			velocity.x = Math.random() * 400 - 200;
			velocity.y = Math.random() * 900 - 800;
			
			rotation = Math.random() * 360;
			
			angularVelocity = Math.random() * 270 - 180;

		} // ends Coin

		/**
		 * The update design pattern for the coin.
		 * Handles collider calculations.
		 */
		public function update(): void {

			handleDeceleration();

			doPhysics();

			collider.calcEdges(x, y);

		} // ends update

		/**
		 * Handles deceleration of the coin when it is on the ground.
		 */
		private function handleDeceleration(): void {
			if (velocity.x < 0) { // moving left
				velocity.x += HORIZONTAL_DECELERATION * Time.dt; // accelerate right
				if (velocity.x > 0) velocity.x = 0; // clamp at 0
			}

			if (velocity.x > 0) {
				velocity.x -= HORIZONTAL_DECELERATION * Time.dt; // accelerate left
				if (velocity.x < 0) velocity.x = 0; // clamp at 0
			}
			
			if (angularVelocity < 0) {
				angularVelocity += ANGULAR_DECELERATION * Time.dt; // accelerate right
				if (angularVelocity > 0) angularVelocity = 0;
			}
			
			if (angularVelocity > 0) {
				angularVelocity -= ANGULAR_DECELERATION * Time.dt; // accelerate right
				if (angularVelocity < 0) angularVelocity = 0;
			}
		} // ends handleDeceleration
		
		/**
		 * Handles physics for the coin.
		 */
		private function doPhysics(): void {
			
			rotation += angularVelocity * Time.dt;
			
			velocity.y += gravity.y * Time.dt;

			// apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
			
		} // ends doPhysics

		/**
		 * Applies the overlap fix detected by the collider.
		 * Adjusts the coin position according to the fix.
		 */
		public function applyFix(fix: Point): void {
			if (fix.x != 0) {
				x += fix.x;
				velocity.x = 0;
			}

			if (fix.y != 0) {
				y += fix.y;
				velocity.y = 0;
			}

			collider.calcEdges(x, y);
		} // ends applyFix
	}

}