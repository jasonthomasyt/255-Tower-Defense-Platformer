package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * 
	 */
	public class EnemyTough extends MovieClip {
		
		/** Whether or not This object should be dead. */
		public var isDead: Boolean = false;
		/** The collider for the player. */
		public var collider: AABB;
		
		public var radius: Number = 80;
		
		/**
		 * 
		 */
		public function EnemyTough() {
			// constructor code
			x = 690;
			y = 80;
		} // ends constructor
		/**
		 * 
		 */
		public function update(): void {
			
		}
	} // ends class EnemyTough
} // ends package code