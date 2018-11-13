package code {
	
	import flash.display.MovieClip;
	
	/**
	 * This Object is what the player will be staning on as floors and running into as walls.
	 */
	public class Platform extends MovieClip {
		
		/** The AABB collision for this object. */
		public var collider:AABB;
		
		/**
		 * The constructor code for this Object, where we go all of our logic for the Platform.
		 */
		public function Platform() {
			// constructor code
			collider = new AABB(width/2, height/2)
			collider.calcEdges(x, y);
			
			// add to platforms array...
			ScenePlay.platforms.push(this);
		} // end constructor
	} // end class Platform
} // end package code