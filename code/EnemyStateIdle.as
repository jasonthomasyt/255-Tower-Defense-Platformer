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
			/*
			DESIRED BEHAVIOR:
			LOOK FOR THE CASTLE, THE TOWERS, AND THE PLAYER.
			IF ANY OF THOSE TARGETS ARE WITHIN RANGE, SHOOT THAT TARGET.
			IF NONE ARE IN RANGE, ADVANCE TO THE LEFT.
			*/
			
			//trace("I'm pretty idle right now");
			// BEHAVIOR:
			// Go to the left
			enemy.handleWalking(-1);
			
			// Look for tergets in range
			enemy.findValidTargets();
			//enemy.getDistToTargets();
			
			// TRANSITIONS:
			// If in range, Go Aggro:
			if(enemy.closestTarget > -1){
				// we can see a target!
				// Get Closest Target
				return new EnemyStateAggro();
			}
			
			return null;
		} // ends update
	}// ends class
} // ends package code