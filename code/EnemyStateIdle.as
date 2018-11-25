package code {
	
	/**
	 * 
	 */
	public class EnemyStateIdle extends EnemyState {

		/**
		 * 
		 */
		public function EnemyStateIdle() {
			// constructor code
		} // ends constructor
		/**
		 * 
		 * 
		 * 
		 */
		override public function update(enemy:Enemy):EnemyState {
			//trace("I'm pretty idle right now");
			
			enemy.doPhysics();
			
			
			return null;
		} // ends update
	}// ends class
} // ends package code