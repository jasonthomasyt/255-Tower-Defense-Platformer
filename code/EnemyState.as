package code {
	
	/**
	 * Our ABSTRACT super class for all of our Basic Enemy states.
	 */
	public class EnemyState {

		/**
		 * Our constructor code for our EnemyState
		 */
		public function EnemyState() {
			// constructor code
		} // ends constructor
		/**
		 * This is our update method that will get overwriten by it's children.
		 * @param enemy A reference to the specific Enemy that this state is controlling.
		 * @return The next EnemyState we want to switch to. Will return null if we don't want to change.
		 */
		public function update(enemy:Enemy):EnemyState {
			return null;
		} // ends update
		/**
		 * The function that should get called before this Object does anything.
		 */
		public function onBegin():void { }
		/**
		 * The function that should get called at the very end of it's life before this Object gets deleted.
		 */
		public function onEnd():void { }
		
	} // ends class EnemyState
} // ends package code