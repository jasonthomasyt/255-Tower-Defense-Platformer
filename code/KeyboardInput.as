package code {

	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	/**
	 * The KeyboardInput class.
	 * Handles all keyboard input events.
	 */
	public class KeyboardInput {
		
		/** The state of each key. */
		static public var keysState: Array = new Array();
		
		/** The previous state of each key. */
		static public var keysPrevState: Array = new Array();

		/**
		 * Constructor function for KeyboardInput
		 * @param stage The main scene of the game.
		 */
		static public function setup(stage: Stage) {

			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);

		} // ends KeyboardInput
		
		/**
		 * This funciton's job is to cache all of the key values, for the NEXT frame.
		 */
		static public function update(): void {
			keysPrevState = keysState.slice(); // in this context, slice() gives us a copy of the array
		} // end update

		/** 
		 * Updates the key booleans when a certain key is pressed.
		 * @param keyCode The keycode of the key that is pressed.
		 * @param isDown Switches to true if the key has been pressed.
		 */
		static private function updateKey(keyCode: int, isDown: Boolean): void {

			keysState[keyCode] = isDown;

		} // ends updateKey

		/**
		 * If key is pressed, set boolean to true.
		 * @param e The keyboard input event.
		 */
		static private function handleKeyDown(e: KeyboardEvent): void {
			trace(e.keyCode)
			updateKey(e.keyCode, true);

		} // ends handleKeyDown

		/**
		 * If key is not pressed, set boolean to false.
		 * @param e The keyboard input event.
		 */
		static private function handleKeyUp(e: KeyboardEvent): void {

			updateKey(e.keyCode, false);

		} // ends handleKeyUp
		
		/**
		 * Checks if the key is currently pressed.
		 * @return The true/false value for the state of the key (if it is currently being pressed or not).
		 */
		static public function isKeyDown(keyCode: int): Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keysState.length) return false;
			trace("is " + keyCode + " down?");
			return keysState[keyCode];
		} // ends IsKeyDown
		
		/**
		 * Checks if the key has been pressed.
		 * @return The true/false value for the key (if it has just been pressed or not).
		 */
		static public function onKeyDown(keyCode: int): Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keysState.length) return false;
			
			return (keysState[keyCode] && !keysPrevState[keyCode]);
		} // ends OnKeyDown
	} // ends class
} // ends package