package  code {
	import flash.display.MovieClip;
	
	public class BuildSpot extends MovieClip{
		
		public var collider:AABB;

		public function BuildSpot() {
			// constructor code
			collider = new AABB(width / 2, height / 2);
			collider.calcEdges(x, y);
		}
		
		private function update():void{
			
		}

	}
	
}
