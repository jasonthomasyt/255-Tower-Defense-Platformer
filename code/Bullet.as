﻿package code {
	
	import flash.display.MovieClip;
	
	/**
	 * The class for the Bullet object.
	 */
	public class Bullet extends MovieClip {
		
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
		public var lifeMax: Number = 2;
		
		/** The current amount of time the bullet has been on screen */
		private var lifeCurrent: Number = 0;
		
		/** The AABB collision for this object. */
		public var collider:AABB;
		
		
		/**
		 * Bullet constructor function.
		 * @param p The player object of the game.
		 */
		public function Bullet(p: Player = null, t:Turret = null) {
			
			collider = new AABB(width/2, height/2)
			collider.calcEdges(x, y);
			
			if (p) {
				// Set coordinates of bullet to player coordinates. 
				x = p.x - p.gun.x;
				y = p.y;
			
				// Set angle to gun rotation.
				angle = (p.gun.rotation - 90) * Math.PI /180;
			} else if (t) {
				// Set coordinates of bullet to player coordinates. 
				x = t.x;
				y = t.y;
			
				// Set angle to gun rotation.
				angle = (t.rotation - 90) * Math.PI /180;
			} 
			

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