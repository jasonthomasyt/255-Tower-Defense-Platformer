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
			
			// BEHAVIOR:
			if(ScenePlay.main.player.x < enemy.x){
				enemy.handleWalking(-1);
			}
			if(ScenePlay.main.player.x > enemy.x){
				enemy.handleWalking(1);
			}
			//enemy.handleWalking(0);
			enemy.doPhysics();
			
			
			// TRANSITIONS:
			if(enemy.getDistToPlayer() > enemy.sightDistance){
				// we can'y see the player!
				return new EnemyStateIdle();
			}
			
			return null;
		} // ends update
	}// ends class
} // ends package code