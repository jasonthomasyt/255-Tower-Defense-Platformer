package code {
	import flash.display.MovieClip;
	/**
	 * This is the parent class for towers.
	 */
	public class Tower extends MovieClip {		
		/* Variable tracking the tower's current health */
		public var health: int = 100;
		/* Variable tracking the tower's max health */
		public var maxHealth: int = 100;
		/* Bool tracking if the tower is "dead" */
		public var isDead: Boolean = false;		
		/**
		 * Constructor function for the towers.
		 */
		public function Tower() {
			
		}
		/**
		 * Update function for the towers.
		 */
		public function update(scenePlay: ScenePlay): void {
			// It is here to be overridden by individual tower types
		}// ends update
	}// ends class
}// ends package