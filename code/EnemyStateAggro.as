package code {
	
	/**
	 * Our ABSTRACT class for our Basic Enemy aggro state behavior.
	 */
	public class EnemyStateAggro extends EnemyState {

		/**
		 * Our constructor code for our EnemyStateAggro
		 */
		public function EnemyStateAggro() {
			// constructor code
		} // ends constructor
		/**
		 *  This is our update method that overrides it's perent class..
		 * @param enemy A reference to the specific Enemy that this state is controlling.
		 * @return The next EnemyState we want to switch to. Will return null if we don't want to change.
		 */
		override public function update(enemy:Enemy):EnemyState {
			//trace("I'm so aggro right now");
			
			// BEHAVIOR:
			// Shoot at Target
			enemy.handleAiming();
			
			// Keep looking for valid targets
			enemy.findValidTargets();
			
			//SHOOT!
			enemy.shootTarget();
			
			/*
			if(ScenePlay.main.player.x < enemy.x){
				enemy.handleWalking(-1);
			}
			if(ScenePlay.main.player.x > enemy.x){
				enemy.handleWalking(1);
			}
			*/
			enemy.handleWalking(0);
			
			
			// TRANSITIONS:
			if(enemy.closestTarget <= -1){
				// we can'y see the player!
				return new EnemyStateIdle();
			}
			
			return null;
		} // ends update
	}// ends class
} // ends package code