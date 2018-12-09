package code {
	
	import flash.display.MovieClip;
	
	/**
	 * This object is for all platforms that float.
	 * They will be handled differently than normal platforms.
	 * The player can fall through them by holding the 'down' key.
	 */
	public class FloatingPlatform extends MovieClip {
		
		/** The AABB collision for this object. */
		public var collider:AABB;
		
		public function FloatingPlatform() {
			// constructor code
			collider = new AABB(width/2, height/2)
			collider.calcEdges(x, y);
			
			// add to platforms array...
			ScenePlay.floatingPlatforms.push(this);
			stop();
		}
		
		public function update(): void {
			collider.calcEdges(x, y);
		} // ends update
	} // ends class
	
} // ends package
