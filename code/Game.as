package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import sounds.*;
	
	/**
	 * This is our Game Class. It runs and rules over all of our app logic.
	 */
	public class Game extends MovieClip {
		
		
		/**
		 * This stores the current scene using a Finite State Machine.
		 * 1: Title
		 * 2: Play
		 * 3: Game Over
		 * 0: Error
		 */
		private var gameScene: GameScene;
		
		/** This stores the previous scene */
		private var gameScenePrevious: GameScene;
		
		private var bgMusic: BGMusic = new BGMusic();
		
		/**
		 * This is the constructor code for our game, where we set up some of our Objects and Event Listeners.
		 */
		public function Game() {
			KeyboardInput.setup(stage);
			switchScene(new SceneTitle());
			addEventListener(Event.ENTER_FRAME, gameLoop);
			bgMusic.play(0, 9999);
			
		} // ends Game
		/**
		 * The gameLoop design pattern. Updates time, keyboard input, and the current GameScene.
		 * @param e The current frame we are on. It is the Event that triggered this event-handler.
		 */
		private function gameLoop(e: Event): void {
			
			Time.update();
			if (gameScene) switchScene(gameScene.update(gameScenePrevious));
			
		} // ends gameLoop
		/**
		 * This gets called every frame to check if we need to change our current scene.
		 * @param newScene The new scene we would want to switch to.
		 */
		private function switchScene(newScene: GameScene): void {
			if (newScene) {
				//switch scenes...
				if (gameScene) gameScene.onEnd();
				if (gameScene) removeChild(gameScene);
				if (gameScene) gameScenePrevious = gameScene; //cache the current scene before switching to the new one
				gameScene = newScene;
				addChild(gameScene);
				gameScene.onBegin();
				stage.focus = stage;
			}
		} // end switchScene
	} // ends class
} // ends package
