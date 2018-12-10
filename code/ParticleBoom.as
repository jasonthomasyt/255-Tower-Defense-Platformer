package code {
	
	/** The particle effect that happens when the player bullet explodes. */
	public class ParticleBoom extends Particle {

		/**
		 * The constructor function for the particle boom effect.
		 * @param spawnX The X spawn location.
		 * @param spawnY The Y spawn location.
		 */
		public function ParticleBoom(spawnX: Number, spawnY: Number) {
			
			super(spawnX, spawnY);
			
			velocity.x = Math.random() * 400 - 200;
			velocity.y = Math.random() * 400 - 350;
			
			rotation = Math.random() * 360;
			
			angularVelocity = Math.random() * 180 - 90;
			
			scaleX = Math.random() * .2;
			
			scaleY = scaleX;

			lifeSpan = Math.random() * 1.5 + .5;
		} // ends ParticleBoom

	} // ends class
	
} // ends package
