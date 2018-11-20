package code {
	
	import flash.display.MovieClip;
	
	
	public class Castle extends MovieClip {
		
		/** Checks for if the castle should be deleted. */
		public var isDead: Boolean = false;
		
		/** The collider for the castle. */
		public var collider:AABB;
		
		public function Castle() {
			collider = new AABB(width / 2, height / 2);
		}
		
		/**
		 * The update design pattern for the castle.
		 */
		public function update(): void {
			collider.calcEdges(x, y);
		}
	}
	
}
