package code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * The class for the Player object.
	 */
	public class Player extends MovieClip {
		
		/** Sets the gravity for the player. */
		private var gravity: Point = new Point(0, 1000);
		
		/** Sets the X max speed for the player. */
		private var maxSpeedX: Number = 200;
		
		/** Sets the velocity for the player. */
		private var velocity: Point = new Point(1, 5);

		/** Sets the horizontal acceleration constant for the player. */
		private const HORIZONTAL_ACCELERATION: Number = 800;
		
		/** Sets the horizontal deceleration constant for the player. */
		private const HORIZONTAL_DECELERATION: Number = 800;
		
		/** Checks if the player is on the ground. */
		private var isGrounded:Boolean = false;
		
		/** Whether or not the player is moving upward in a jump.  This affects gravity. */
		private var isJumping:Boolean = false;
		
		/** How many times the player can currently jump in the air. */
		private var airJumpsLeft:int = 1;
		
		/** The max number of jumps the player can perform in the air. */
		private var airJumpsMax:int = 1;
		
		/** The player's jump velocity. */
		private var jumpVelocity:Number = 400;
		
		/** Detects the ground in the game. */
		var ground: Number = 350;
		
		/**
		 * The Player constructor class
		 */
		public function Player() {
			// constructor code
		} // ends Player
		
		/**
		 * The update design pattern for the player.
		 * Handles physics, walking, jumping, and ground detection.
		 */
		public function update(): void {
			
			handleJumping();

			handleWalking();

			doPhysics();

			detectGround();
			
			if (y < ground){
				isGrounded = false; // this allows us to walk off edges and only be allowed one air jump.
			}
			
		} // ends update
		
		/**
		 * Handles the jumping action for the player.
		 */
		private function handleJumping(): void {
			if (KeyboardInput.OnKeyDown(Keyboard.SPACE)) {
				if (isGrounded) { // we are on the ground...
					isGrounded = false; // not on ground
					velocity.y = -jumpVelocity; // apply an impulse up
					isJumping = true;
				} else { // in air, attempting a double-jump
					if (airJumpsLeft > 0 && isJumping == false) { // if we have air-jumps left:
						velocity.y = -jumpVelocity; // air jump
						airJumpsLeft--;
						isJumping = true;
					}
				}
			}
			
			if (!KeyboardInput.IsKeyDown(Keyboard.SPACE)) isJumping = false;
			if (velocity.y > 0) isJumping = false;
		} // ends handleJumping
		
		/**
		 * This function looks at the keyboard input in order to accelerate the player
		 * left or right.  As a result, this function changes the player's velocity.
		 */
		private function handleWalking(): void {
			if (KeyboardInput.IsKeyDown(Keyboard.A)) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (KeyboardInput.IsKeyDown(Keyboard.D)) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (!KeyboardInput.IsKeyDown(Keyboard.A) && !KeyboardInput.IsKeyDown(Keyboard.D)) { // left and right not being pressed...
				if (velocity.x < 0) { // moving left
					velocity.x += HORIZONTAL_DECELERATION * Time.dt; // accelerate right
					if (velocity.x > 0) velocity.x = 0; // clamp at 0
				}

				if (velocity.x > 0) {
					velocity.x -= HORIZONTAL_DECELERATION * Time.dt; // accelerate left
					if (velocity.x < 0) velocity.x = 0; // clamp at 0
				}
			}
		} // ends handleWalking
		
		/**
		 * Handles physics for the player.
		 * Sets the velocity to the gravity and max speed.
		 */
		private function doPhysics(): void {
			
			var gravityMultiplier:Number = .5;
			
			if (!isJumping) gravityMultiplier = 2;
			
			// apply gravity to velocity:
			//velocity.x += gravity.x * Time.dt * gravityMultiplier;
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			// constrain to maxSpeed:
			if (velocity.x > maxSpeedX) velocity.x = maxSpeedX; // clamp going right
			if (velocity.x < -maxSpeedX) velocity.x = -maxSpeedX; // clamp going left

			// apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		} // ends doPhysics
		
		/**
		 * Detects when the player has hit the ground.
		 */
		private function detectGround(): void {
			// look at y position
			if (y >= ground) {
				y = ground; // clamp
				velocity.y = 0;
				isGrounded = true;
				airJumpsLeft = airJumpsMax;
			}
		} // ends detectGround
		
		
	} // ends class
} // ends package
