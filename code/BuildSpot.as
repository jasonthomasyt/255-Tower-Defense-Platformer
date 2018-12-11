package  code {	
	import flash.display.MovieClip;	
	/**
	 * This is the class for build spots, for building towers.
	 */	
	public class BuildSpot extends MovieClip{		
		/* The AABB collider for this object */
		public var collider:AABB		
		/* Bool to determine if the player can build from the build spot */
		public var used:Boolean = false;
		/**
		 * The constructor code for the build spot.
		 */
		public function BuildSpot() {
			// Instantiates & Calculates the edges of the AABB.
			collider = new AABB(width / 2, height / 2);
			collider.calcEdges(x, y);
		}// ends BuildSpot
	}// ends class	
}// ends package
