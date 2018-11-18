package code {
	
	public class ParticleBoom extends Particle {

		public function ParticleBoom(spawnX: Number, spawnY: Number) {
			
			super(spawnX, spawnY);
			
			velocity.x = Math.random() * 400 - 200;
			velocity.y = Math.random() * 400 - 350;
			
			rotation = Math.random() * 360;
			
			angularVelocity = Math.random() * 180 - 90;
			
			scaleX = Math.random() * .5;
			
			scaleY = scaleX;

			lifeSpan = Math.random() * 1.5 + .5;
		}

	}
	
}
