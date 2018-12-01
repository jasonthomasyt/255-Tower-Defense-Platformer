package code {
	
	import flash.display.MovieClip;
	
	/**
	 * The class for the Bullet object.
	 */
	public class BulletBad extends MovieClip {
		
		/** Speed of the bullet. */
		public const SPEED: Number = 420;

		/** The X Velocity of the bullet. */
		public var velocityX: Number = 0;
		/** The Y Velocity of the bullet. */
		public var velocityY: Number = -10;

		/** Checks for if the bullet should be deleted. */
		public var isDead: Boolean = false;

		/** Radius of the bullet. */
		public var radius: Number = 10;

		/** Angle of the bullet. */
		public var angle: Number = 0;
		
		/** The amount of time the bullet will stay alive for in seconds. */
		private var lifeMax: Number = 2;
		/** The current amount of time the bullet has been on screen */
		private var lifeCurrent: Number = 0;
		
		/** The AABB collision for this object. */
		public var collider:AABB;
		
		/**
		 * Bullet constructor function.
		 * @param p The player object of the game.
		 */
		public function BulletBad(e: Enemy) {
			
			collider = new AABB(width/2, height/2)
			collider.calcEdges(x, y);
			
			// Set coordinates of bullet to player coordinates. 
			x = e.x - e.gun.x;
			y = e.y;
			
			// Set angle to gun rotation.
			angle = (e.gun.rotation - 90) * Math.PI /180;

			// Set velocity according to speed and angle of the bullet.
			velocityX = SPEED * Math.cos(angle);
			velocityY = SPEED * Math.sin(angle);
		} // ends Bullet
		
		/**
		 * The update design pattern for the bullet.
		 */
		public function update(): void {
			
			collider.calcEdges(x, y);
			
			// Moves bullet according to velocity.
			x += velocityX * Time.dtScaled;
			y += velocityY * Time.dtScaled;
			
			// Increment how long this bullet has been alive for.
			lifeCurrent += Time.dtScaled;

			// If this object has lived a long fulfillful life, mark it as dead.
			if (lifeCurrent > lifeMax) isDead = true;
			
		} // ends update
	} // ends class
} // ends package