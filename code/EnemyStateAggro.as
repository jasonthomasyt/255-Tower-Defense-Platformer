package code {
	
	/**
	 * 
	 */
	public class EnemyStateAggro extends EnemyState {

		/**
		 * 
		 */
		public function EnemyStateAggro() {
			// constructor code
		} // ends constructor
		/**
		 * 
		 * 
		 * 
		 */
		override public function update(enemy:Enemy):EnemyState {
			trace("I'm so aggro right now");
			return null;
		} // ends update
	}// ends class
} // ends package code