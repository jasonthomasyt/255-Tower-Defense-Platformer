package  {
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	/* This is the class for bullets */
	public class Bullet extends MovieClip{
		/* Boolean tracking if the bullet is "dead" */
		public var isDead:Boolean = false;
		/* Point tracking the x and y velocity values for bullets */
		public var velocity:Point = new Point(0, 0);
		/* Constructor for the bullet class */
		public function Bullet() {
			// constructor code
		}
		/* Update function for the bullets */
		public function update():void{
			x += velocity.x; //moves the bullets
			y += velocity.y;
			
			if(y < 0 || y > 400 || x < 0 || x > 550){ //sets isDead to true if bullets move outside screen boundaries
				isDead = true;
			}
		}
		/* Function handling setting the bullets' positions/velocities at spawn */
		public function setVelocity(t:Turret):void{
			
			var angle:Number = (t.rotation - 90) / (180 / Math.PI); //Gets angle from turret's angle of rotation
			
			x = t.x + 75 * Math.cos(angle); //Sets starting position of bullets
			y = t.y + 75 * Math.sin(angle);
			
			velocity.x = 10 * Math.cos(angle); //Sets velocities of bullets
			velocity.y = 10 * Math.sin(angle);
			/* TO DO: Implement delta time where necessary */
			
		}

	}
	
}
