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
		
		/** 
		 * The constructor function for the Floating Platform game object.
		 */
		public function FloatingPlatform() {

			collider = new AABB(width/2, height/2)
			collider.calcEdges(x, y);
			
			// add to floating platforms array...
			ScenePlay.floatingPlatforms.push(this);
			stop();
		} // ends FloatingPlatform
		
		public function update(): void {
			collider.calcEdges(x, y);
		} // ends update
		
	} // ends class
	
} // ends package
