package  {
	
	import flash.display.MovieClip;
	
	
	public class Tower extends MovieClip {
		
		
		public function Tower() {
			// constructor code
		}
		public function update():void {
			
			var tx:Number = parent.mouseX - x;
			var ty:Number = parent.mouseY - y;
			var angle:Number = Math.atan2(ty, tx);
			angle *= 180 / Math.PI;
			
			rotation = angle + 90;
		}
	}
	
}
