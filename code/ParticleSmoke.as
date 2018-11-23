package code {
	
	import flash.display.MovieClip;
	
	
	public class ParticleSmoke extends Particle {
		
		
		public function ParticleSmoke(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
			
			acceleration.y = Math.random() * 50 - 70;
			
			lifeSpan = Math.random() * 1 + .5;
			
			scalarVelocity = Math.random() * .1;
			
			alphaVelocity = -.005;
			
			alpha = 1;
		}
		
		override public function shouldDie(): Boolean {
			
			if (alpha <= 0) return true;
			
			return false;
			
		}
	}
	
}
