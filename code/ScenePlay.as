package code {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	
	public class ScenePlay extends GameScene {

		/** This is our array of Bullet Objects. */
		private var bullets: Array = new Array();
		//private var level: MovieClip;

		/** */
		private var shakeTimer: Number = 0;

		/** This is our array of Platform Objects. */
		static public var platforms: Array = new Array();
		/** */
		public var player: Player;
		
		/**
		 * This is our constructor script. It loads us our level.
		 */
		public function ScenePlay() {
			// constructor code
			loadLevel();
		}
		private function doCameraMove(): void {
			var targetX: Number = -player.base.x + stage.stageWidth / 2;
			var targetY: Number = -player.base.y + stage.stageHeight / 2;
			var offsetX: Number = 0 //Math.random() * 20 - 10;
			var offsetY: Number = 0 //Math.random() * 20 - 10;
			var camEaseMultipler: Number = 5;
			level.x += (targetX - level.x) * Time.dt * camEaseMultipler + offsetX;
			level.y += (targetY - level.y) * Time.dt * camEaseMultipler + offsetY;
			if (shakeTimer > 0) {
				shakeTimer -= Time.dt;
				var shakeIntensity: Number = shakeTimer;
				if (shakeIntensity > 1) shakeIntensity = 1;
				shakeIntensity = 1 - shakeIntensity;
				shakeIntensity *= shakeIntensity;
				shakeIntensity = 1 - shakeIntensity;
				var shakeAmount: Number = 20 * shakeIntensity;
				offsetX = Math.random() * shakeAmount - shakeAmount / 2;
				offsetY = Math.random() * shakeAmount - shakeAmount / 2;

			}
		} // ends doCameraMove

		/**
		 * This is our update function that is called every frame! It lets our game run.
		 * @param previousScene If passed in, it allows us to save everything that happened on the scene previous to this one. (Left over from pause screen functionality.)
		 * @return This returns null every frame, unless it is tim to switch scenes. Then we pass in a new GameScene Object we wish to switch to.
		 */
		override public function update(previousScene: GameScene = null): GameScene {
			player.update();
			doCameraMove();
			updateBullets();
			updatePlatforms();
			updateParticles();
			doCollisionDetection();

			if (KeyboardInput.onKeyDown(Keyboard.R) || castle.isDead) {
				//trace("if is true");
				return new SceneLose();
			}

			return null
		} // ends update

		/**
		 * Adds our EventListeners to the stage when this scene is created.
		 */
		override public function onBegin(): void {
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
		} // end onBegin
		/**
		 * Removes our EventListeners to the stage when this scene is created.
		 */
		override public function onEnd(): void {
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			platforms = new Array();
		} // end onEnd
		/**
		 * This event-handler is called everytime the left mouse button is down.
		 * It causes the player to shoot bullets.
		 * @param e The MouseEvent that triggered this event-handler.
		 */
		private function handleClick(e: MouseEvent): void {

			spawnBullet();

		} // ends handleClick
		/**
		 * 
		 */
		private function updatePlatforms(): void {
			for (var i: int = platforms.length - 1; i >= 0; i--) {
				platforms[i].update();
			}
		} // ends updatePlatforms

		/**
		 * Updates particles for every frame.
		 */
		private function updateParticles(): void {
			for (var i: int = particles.length - 1; i >= 0; i--) {
				particles[i].update();

				if (particles[i].isDead) {
					level.removeChild(particles[i]);
					particles.splice(i, 1);
				}
			}
		} // ends updateParticles

		/** 
		 * Spawns a bullet from the player everytime the user clicks the left mouse button.
		 */
		private function spawnBullet(): void {

			var b: Bullet = new Bullet(player);
			level.addChildAt(b, 0);
			bullets.push(b);

		} // ends spawnBullet
		/**
		 * This loads the level
		 */
		private function loadLevel(): void {
			//level = new Level01();
			addChild(level);
			if (!player && level.player) {
				player = level.player;
			}
		}
		/**
		 * Updates bullets for every frame.
		 */
		private function updateBullets(): void {

			// update everything:
			for (var i: int = bullets.length - 1; i >= 0; i--) {
				bullets[i].update(); // Update design pattern.

				/** If bullet is dead, remove it. */
				if (bullets[i].isDead) {
					// remove it!!

					// 1. remove the object from the scene-graph
					level.removeChild(bullets[i]);

					// 2. nullify any variables pointing to it
					// if the variable is an array,
					// remove the object from the array
					bullets.splice(i, 1);
				}
			} // ends for loop updating bullets
		} // ends updateBullets

		/**
		 * This is where we do all of our AABB collision decetction. It loops through all of our walls and checks if
		 * the player is colliding with any of them.
		 */
		private function doCollisionDetection(): void {

			// Collision for player bullets hitting platforms or the castle.
			for (var i: int = 0; i < platforms.length; i++) {
				for (var j: int = 0; j < bullets.length; j++) {
					if (platforms[i].collider.checkOverlap(bullets[j].collider)) {
						explodePlayerBullet(j);
					}

					if (bullets[j].y > 700) { // If bullet hits ground...
						explodePlayerBullet(j);
					}

					if (bullets[j].collider.checkOverlap(castle.collider)) {
						explodePlayerBullet(j);
					}
				}

				if (player.collider.checkOverlap(platforms[i].collider)) { // if we are overlapping
					// find the fix:
					var platformFix: Point = player.collider.findOverlapFix(platforms[i].collider);

					// apply the fix:
					player.applyFix(platformFix);

					// Recalculate player collider
					player.collider.calcEdges(player.x, player.y);

				}
			} // ends for

			if (player.collider.checkOverlap(castle.collider)) {
				var castleFix: Point = player.collider.findOverlapFix(castle.collider);

				player.applyFix(castleFix);
			}
		} // ends doCollisionDetection()

		/**
		 * Explodes the player bullet with particles when it hits a wall or the ground.
		 * @param index The index of the bullet in the bullets array.
		 */
		private function explodePlayerBullet(index: int): void {
			bullets[index].isDead = true;

			for (var i: int = 0; i < 5; i++) {
				var p: Particle = new ParticleBoom(bullets[index].x, bullets[index].y);
				level.addChild(p);
				particles.push(p);
			} // ends for
		} // ends explodePlayerBullet
	} // ends class
} // ends package
	
	/**
	 * This is our ScenePlay Object, where our gameplay should take place in.
	 */
		static public var platforms: Array = new Array();
		/** */
		public var player: Player;
		/** */
		private var enemies: Array = new Array();
		/** */
		public var towers: Array = new Array();
		
		static public var platforms: Array = new Array();

		/** The player object for the game. */
		public var player: Player;

		/** The castle object for the game. */
		public var castle: Castle;

		/** The array of particle objects. */
		private var particles: Array = new Array();

			loadLevel();
			
		}
		/**
		 * This handles our camera movement within our level to keep our player in the middle of the screen and lets make our levels bigger.
		 */
			player.update();
			if (player.isDead) {
				killPlayer();
				spawnPlayer();
			}
			doCameraMove();
			castle.update();
		} // ends handleClick
		/**
		 * Because our camera moves our platforms around on-screen, we call this function to primarily recalculate our platforms AABB's.
		 * However, because it is an update function, we can add some more functionality to our platforms if we so wish.
		 */
		private function updatePlatforms(): void {
			for (var i: int = platforms.length - 1; i >= 0; i--) {
			//addChild(level);
			spawnPlayer();
		}
		/**
		 * Will destroy the current player object and remove it from memory. Currently does nothing.
		 */
		private function killPlayer(): void {
			//level.removeChild(player);
			//player = null;
		}
		/**
		 * If a player is currently valid, nothing will happen. Otherwise, this method spawns us a player at our playerSpawner location.
		 */
		private function spawnPlayer(): void {
			if (!player) {
				if (!level.player) {
					level.player = new Player();
					level.addChild(level.player);
				}
				player = level.player;
			}
			level.player.x = level.playerSpawner.x;
			level.player.y = level.playerSpawner.y;
			/*
			if (player){
				level.pleyer.isDead = false;
			}
			*/