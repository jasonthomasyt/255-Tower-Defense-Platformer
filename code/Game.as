package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Game extends MovieClip {
		
		
		public function Game() {
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);
		} // ends Game
		
		/**
		 * The gameLoop design pattern.
		 * Updates time, the player, and keyboard input.
		 */
		private function gameLoop(e: Event): void {
			
			Time.update();
			
			player.update();
			
		} // ends gameLoop
	} // ends class
} // ends package
