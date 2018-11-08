package code {
	import flash.utils.getTimer;

	/**
	 * The static class for keeping track of time in the game.
	 */
	public class Time {

		/** Delta time variable. */
		public static var dt: Number = 0;

		/** Scaled delta time variable. */
		public static var dtScaled: Number = 0;

		/** Current time variable. */
		public static var time: Number = 0;

		/** Current time scale. */
		public static var scale: Number = 1;

		/** Previous time variable. */
		private static var timePrev: Number = 0;

		/**
		 * The Update design pattern.
		 * Determines the current scaled time based on FPS.
		 * @return void This method should not return anything.
		 */
		public static function update(): void {
			time = getTimer();
			dt = (time - timePrev) / 1000;
			dtScaled = dt * scale;
			timePrev = time; // cache for next frame
		} // ends update
	} // ends class
} // ends package