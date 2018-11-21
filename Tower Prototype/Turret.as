package  {
	
	import flash.display.MovieClip;
	
	/* This is the class for the turret */
	public class Turret extends MovieClip {
		
		/* Constructor code for the turret class */
		public function Turret() {
			// constructor code
		}
		/* Update function for the turret */
		public function update():void {
			
			/**
			 * Updates the rotation angle of the turret to follow the mouse
			 * TO DO: Update to follow closest enemy
			 */
			var tx:Number = parent.mouseX - x;
			var ty:Number = parent.mouseY - y;
			var angle:Number = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			rotation = angle + 90;
		}
	}
	
}
