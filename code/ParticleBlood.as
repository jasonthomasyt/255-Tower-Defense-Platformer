package code {
	
	import flash.display.MovieClip;
	
	
	public class ParticleBlood extends Particle {
		
		
		public function ParticleBlood(spawnX: Number, spawnY: Number) {
			
			super(spawnX, spawnY);
			
			velocity.x = Math.random() * 400 - 200;
			velocity.y = Math.random() * 400 - 350;
			
			rotation = Math.random() * 360;
			
			angularVelocity = Math.random() * 180 - 90;
			
			scaleX = Math.random() * .4;
			
			scaleY = scaleX;

			lifeSpan = Math.random() * 1.5 + .5;
			
		}
	}
	
}
