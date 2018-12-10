package code {
	
	import flash.display.MovieClip;
	
	/** The smoke particle object that spawns in the background of the game. */
	public class ParticleSmokeParticle extends Particle {
		
		/**
		 * The constructor function for the smoke particle. 
		 * @param spawnX The X spawn location.
		 * @param spawnY The Y spawn location.
		 */
		public function ParticleSmokeParticle(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
			
			acceleration.y = Math.random() * 50 - 70;
			
			rotation = Math.random() * 360;
			
			angularVelocity = Math.random() * 180 - 90;
			
			scaleX = Math.random() * .2;
			
			scaleY = scaleX;

			lifeSpan = Math.random() * 10 + 1;
		} // ends ParticleSmokeParticle
	} // ends class
	
} // ends package
