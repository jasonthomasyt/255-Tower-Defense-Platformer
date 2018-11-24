package code {
	
	import flash.display.MovieClip;
	
	
	public class ParticleSmokeParticle extends Particle {
		
		
		public function ParticleSmokeParticle(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
			
			acceleration.y = Math.random() * 50 - 70;
			
			rotation = Math.random() * 360;
			
			angularVelocity = Math.random() * 180 - 90;
			
			scaleX = Math.random() * .2;
			
			scaleY = scaleX;

			lifeSpan = Math.random() * 10 + 1;
		}
	}
	
}
