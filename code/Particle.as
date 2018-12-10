package code {
	import flash.geom.Point;
	import flash.display.MovieClip;

	/** The super class for all particles. */
	public class Particle extends MovieClip {

		/** The acceleration of the particle. */
		protected var acceleration: Point = new Point(0, 10);

		/** The velocity of the particle. */
		protected var velocity: Point = new Point(0, 10);
		
		/** The angular velocity of the particle. */
		protected var angularVelocity: Number = 0;
		
		/** The scalarVelocity of the particle. */
		protected var scalarVelocity: Number = 0;
		
		/** The alpha velocity of the particle. */
		protected var alphaVelocity: Number = 0;

		/** The lifespan for each particle. */
		protected var lifeSpan: Number;

		/** The current age of the particle (how long the particle has been in the scene). */
		protected var age: Number = 0;

		/** Checks if the particle is dead and ready to be removed from the scene. */
		public var isDead: Boolean = false;

		/**
		 * The constructor function for the particle.
		 * @param spawnX The X spawn location.
		 * @param spawnY The Y spawn location.
		 */
		public function Particle(spawnX: Number, spawnY: Number) {
			x = spawnX;
			y = spawnY;
		} // ends Particle

		/**
		 * The update design pattern for the particle.
		 */
		public function update(): void {

			rotation += angularVelocity * Time.dt;
			
			scaleX += scalarVelocity * Time.dt;
			scaleY = scaleX;
			
			alpha += alphaVelocity * Time.dt;

			velocity.x += acceleration.x * Time.dt;
			velocity.y += acceleration.y * Time.dt;

			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;

			age += Time.dt;

			if (shouldDie()) {
				isDead = true;
			}
		} // ends update
		
		/**
		 * Checks if the particle is ready to die.
		 */
		public function shouldDie(): Boolean {
			
			if (age > lifeSpan){
				return true;
			}
			
			return false;
			
		} // ends checkIfDead

	} // ends class

} // ends package