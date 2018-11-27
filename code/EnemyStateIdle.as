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
			// BEHAVIOR:
			enemy.handleWalking(0);
			enemy.doPhysics();
			
			// TRANSITIONS:
			
			// to aggro:
			
			
			if(enemy.getDistToPlayer() < enemy.sightDistance){
				// we can see the player!
				return new EnemyStateAggro();
			}
			
			// if player is too close...
			
			return null;
		} // ends update
	}// ends class
} // ends package code