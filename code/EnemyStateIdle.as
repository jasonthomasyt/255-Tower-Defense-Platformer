package code {
	
	/**
	 * Our ABSTRACT class for our Basic Enemy idle state behavior.
	 */
	public class EnemyStateIdle extends EnemyState {

		/**
		 * Our constructor code for our EnemyStateIdle
		 */
		public function EnemyStateIdle() {
			// constructor code
		} // ends constructor
		/**
		 * This is our update method that overrides it's perent class..
		 * @param enemy A reference to the specific Enemy that this state is controlling.
		 * @return The next EnemyState we want to switch to. Will return null if we don't want to change.
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