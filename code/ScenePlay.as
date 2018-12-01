﻿
package code {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import sounds.*;

	/**
	 * This is our ScenePlay Object, where our gameplay should take place in.
	 */
	public class ScenePlay extends GameScene {

		/** */
		public var waveCount: int = 0;

		private var spawnIncrement: int = 0;

		private var enemyCounter: int = 0;

		private var waveStart: Boolean = false;

		private var waveEnd: Boolean = true;

		private var spawnDecrement: int = 5;

		private var spawnRate: int = 2000;

		private var spawnRateMin: int = 900;

		public var enemiesRemainingCount: int = 0;

		private var enemyNum: int = 0;

		/** */
		//public var coin: int = 20;

		/** */
		private var shakeTimer: Number = 0;
		private var delaySpawn: int = 0;

		/** This is our array of Platform Objects. */
		static public var platforms: Array = new Array();
		/** */
		static public var enemies: Array = new Array();
		/** */
		public var towers: Array = new Array();

		public var smokeParticleDelay: Number = 0;

		static public var main: ScenePlay; // singleton

		/** The player object for the game. */
		public var player: Player;
		/** This is our array of Bullet Objects. */
		private var bullets: Array = new Array();
		/** The castle object for the game. */
		public var castle: Castle;

		/** The array of particle objects. */
		private var particles: Array = new Array();

		/** The sound for shooting bullets. */
		private var shootSound: ShootSound = new ShootSound();

		/** The sound for when the bullet hits a wall. */
		private var hitSound: HitSound = new HitSound();

		public var coinCount: int = 20;

		static public var coins: Array = new Array();
		/** */
		private var buildSpotChooser: int = 0;
		private var bulletsBad: Array = new Array();
		/** */
		static public var towers: Array = new Array();
		/** */
		static public var turrets: Array = new Array();
		private var enemyDieSound: EnemyDieSound = new EnemyDieSound();

		private var coinSound: CoinSound = new CoinSound();

		/** */
		private var gameOver: Boolean = false;



		/**
		 * This is our constructor script. It loads us our level.
		 */
		public function ScenePlay() {
			// constructor code
			ScenePlay.main = this;

			loadLevel();
			spawnPlayer();
		}
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
			enemies = new Array();
			towers = new Array();
			waveCount = 0;
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
		 * This is our update function that is called every frame! It lets our game run.
		 * @param previousScene If passed in, it allows us to save everything that happened on the scene previous to this one. (Left over from pause screen functionality.)
		 * @return This returns null every frame, unless it is time to switch scenes. Then we pass in a new GameScene Object we wish to switch to.
		 */
		override public function update(previousScene: GameScene = null): GameScene {
			if (player.isDead) {
				killPlayer();
				spawnPlayer();
			}
			player.update();
			updateBullets();
			spawnSmokeParticles();
			spawnEnemy(5);
			updateEnemies();
			updateBulletsBad();
			updateCoins();

			updatePlatforms();
			castle.update();
			updateTurrets();

			updateParticles();

			doCollisionDetection();

			doCameraMove();



			hud.update(this);

			if (castle.isDead) {
				//start Game Over Sequence
				//replace this later for polish
				gameOver = true;
			}
			if (KeyboardInput.onKeyDown(Keyboard.R)) {
				// Dubugging Game Overs
				// Remove this for final Project
				castle.isDead = true;
			}

			if (gameOver) return new SceneLose();

			return null
		} // ends update
		/**
		 * This loads the level
		 */
		private function loadLevel(): void {
			//level = new Level01();
			//addChild(level);
			//spawnPlayer();
			castle = level.castle
			ScenePlay.platforms.splice(3, 1);
			level.playerWall.alpha = 0;
		}
		/**
		 *
		 */
		private function findIndexInArray(value: Object, arr: Array): Number {
			for (var i: uint = 0; i < arr.length; i++) {
				if (arr[i] == value) {
					return i;
				}
			}
			return NaN;
		}
		/**
		 * If a player is currently valid, nothing will happen. Otherwise, this method spawns us a player at our playerSpawner location.
		 */
		private function spawnPlayer(): void {
			if (!level.player) {
				level.player = new Player();
				level.addChild(level.player);
			}
			player = level.player;
			level.player.x = level.playerSpawner.x;
			level.player.y = level.playerSpawner.y;
			/*
			if (player){
				level.pleyer.isDead = false;
			}
			*/
		}
		/**
		 * Will destroy the current player object and remove it from memory. Currently does nothing.
		 */
		private function killPlayer(): void {
			if (level.contains(player)) {
				level.removeChild(player);
				player = null;
				level.player = null;
			}

		}
		/** 
		 * Spawns a bullet from the player everytime the user clicks the left mouse button.
		 */
		private function spawnBullet(): void {

			var b: Bullet = new Bullet(player);
			level.addChild(b);
			bullets.push(b);

		} // ends spawnBullet
		/** 
		 * Spawns a bullet from the player everytime the user clicks the left mouse button.
		 */
		public function spawnBulletBad(enemy: Enemy): void {
			//trace("spawnBulletBad FIRE!");
			var b: BulletBad = new BulletBad(enemy);
			level.addChild(b);
			bulletsBad.push(b);

		} // ends spawnBulletBad

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
		 *
		 */
		private function updateEnemies(): void {
			for (var i: int = ScenePlay.enemies.length - 1; i >= 0; i--) {
				ScenePlay.enemies[i].update();
				if (ScenePlay.enemies[i].isDead) {
					level.removeChild(ScenePlay.enemies[i]);
					ScenePlay.enemies.splice(i, 1);
					enemiesRemainingCount--;
				}

			}

			if (ScenePlay.enemies.length == 0) {
				updateWave();
			}
		} // ends updateEnemies

		/**
		 * Because our camera moves our platforms around on-screen, we call this function to primarily recalculate our platforms AABB's.
		 * However, because it is an update function, we can add some more functionality to our platforms if we so wish.
		 */
		private function updatePlatforms(): void {
			for (var i: int = platforms.length - 1; i >= 0; i--) {
				//addChild(level);
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
		 * Updates turrets every frame.
		 */
		private function updateTurrets(): void {
			for (var i: int = turrets.length - 1; i >= 0; i--) {
				turrets[i].update();
			}
		} //ends updateTurrets

		private function updateWave(): void {
			if (waveEnd == true) {
				enemiesRemainingCount = enemyNum;
				waveCount++;
				waveEnd = false;
				waveStart = true;
			}
		}

		/**
		 * This is where we do all of our AABB collision decetction.
		 */
		private function doCollisionDetection(): void {

			for (var i: int = 0; i < ScenePlay.platforms.length; i++) {

				//Collision for platforms and everything else.
				platformCollision(i);
				
				// Collision for player bullets hitting enemies.
				bulletEnemyCollision();
				
				// Collision between player and enemies
				playerEnemyCollision();

			} // ends for
//Keep all of the collisions that don't need to be in the for loop out!
			// Collision bewteen good bullets and bad bullets
			doubleBulletCollision();

			// Collision between player and badBullets
			playerBulletBadCollision();

			// Collision between player and coins
			playerCoinCollision();

			// Collision between the Castle and badBullets
			castleBulletBadCollision();

			//Collision between the player and the build spot boxes
			playerBuildSpotCollsion();
			
			//Collision between the player and the far wall
			playerWallCollision();

		} // ends doCollisionDetection()
		/*
			for (var k: int = 0; k < bullets.length; k++) {
				if (bullets[k].y > 700) { // If bullet hits ground...
					explodePlayerBullet(k);
				}

				if (bullets[k].collider.checkOverlap(castle.collider)) {
					explodePlayerBullet(k);
				}
			} // ends for
		} // ends playerEnemyCollision

		private function playerCoinCollision(): void {
			for (var i: int = 0; i < ScenePlay.coins.length; i++) {
				if (player.collider.checkOverlap(ScenePlay.coins[i].collider)) {
					collectCoin(i);
				}
			}
			
			if (player.collider.checkOverlap(castle.collider)) {
				var castleFix: Point = player.collider.findOverlapFix(castle.collider);

				player.applyFix(castleFix);
			}
			*/
		// ends doCollisionDetection()
		/**
		 *
		 */
		private function damagePlayer(): void {
			player.health -= 5;
		}

		/**
		 *
		 */
		private function damageCastle(): void {
			castle.health -= 5;
		}

		/**
		 * This handles our camera movement within our level to keep our player in the middle of the screen and lets make our levels bigger.
		 */
		private function doCameraMove(): void {
			var targetX: Number = -player.x + stage.stageWidth / 2;
			var targetY: Number = -player.y + stage.stageHeight / 2;
			var offsetX: Number = 0 //Math.random() * 20 - 10;
			var offsetY: Number = 4 //Math.random() * 20 - 10;
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
		 * Explodes the player bullet with particles when it hits a wall or the ground.
		 * @param index The index of the bullet in the bullets array.
		 */
		private function explodePlayerBullet(index: int): void {

			hitSound.play();

			bullets[index].isDead = true;

			for (var i: int = 0; i < 5; i++) {
				var p: Particle = new ParticleBoom(bullets[index].x, bullets[index].y);
				level.addChild(p);
				particles.push(p);
			} // ends for
		} // ends explodePlayerBullet

		/**
		 * Explodes the enemy bullet with particles when it hits a wall or the ground.
		 * @param index The index of the bullet in the bullets array.
		 */
		private function explodeEnemyBullet(index: int): void {

			hitSound.play();

			bulletsBad[index].isDead = true;

			for (var i: int = 0; i < 5; i++) {
				var p: Particle = new ParticleBoom(bulletsBad[index].x, bulletsBad[index].y);
				level.addChild(p);
				particles.push(p);
			} // ends for
		} // ends explodePlayerBullet

		private function spawnSmokeParticles(): void {

			smokeParticleDelay--;

			if (smokeParticleDelay <= 0) {
				for (var i: int = 0; i < 5; i++) {
					var p: Particle = new ParticleSmokeParticle(Math.random() * stage.width, 670);
					level.addChildAt(p, 1);
					particles.push(p);
				}
				smokeParticleDelay = Math.random() * 3 + .5;
			}
		}

		private function spawnEnemy(spawnCount: int): void {
			// spawn snow:
			spawnCount += spawnIncrement;
			enemyNum = spawnCount;
			if (enemyCounter < spawnCount && waveStart == true) {
				for (var i: int = 0; i < spawnCount; i++) {
					delaySpawn -= Time.dtScaled;
					if (delaySpawn <= 0) {
						var e: Enemy = new Enemy();
						level.addChild(e);
						ScenePlay.enemies.push(e);
						enemyCounter++;
						delaySpawn = (int)(Math.random() * spawnRate + spawnRateMin);
					}
				}
			}

			if (enemyCounter == spawnCount) {
				waveStart = false;
				waveEnd = true;
				enemyCounter = 0;
				spawnIncrement += 5;
				spawnRate -= spawnDecrement;
				spawnRateMin -= spawnDecrement;
			}

		}


		/**
		 *
		 */
		private function spawnTower(): void {
			if (KeyboardInput.onKeyDown(Keyboard.NUMBER_1)) { //if "1" key is pressed...
				/* Spawns a basic tower. */
				spawnBasicTower();

			}
			if (KeyboardInput.onKeyDown(Keyboard.NUMBER_2)) { //if "2" key is pressed...
				/* Spawns a rapid fire tower. */
				spawnRapidTower();

			}
			if (KeyboardInput.onKeyDown(Keyboard.NUMBER_3)) { //if "3" key is pressed...
				/* Spawns a bomb tower. */
				spawnBombTower();

			}
		}
		private function spawnBasicTower(): void {
			var newBasicTower: BasicTower = new BasicTower();
			var newBasicTurret: BasicTurret = new BasicTurret();
			if (coinCount >= 20) {
				/* Sets tower/turret x and y positions */
				if (buildSpotChooser == 1) {
					newBasicTower.y = level.buildSpot1.y;
					newBasicTower.x = level.buildSpot1.x;
					level.removeChild(level.buildSpot1);
					level.buildSpot1.used = true;
				} else if (buildSpotChooser == 2) {
					newBasicTower.y = level.buildSpot2.y;
					newBasicTower.x = level.buildSpot2.x;
					level.removeChild(level.buildSpot2);
					level.buildSpot2.used = true;
				}
				newBasicTurret.y = newBasicTower.y - 75;
				newBasicTurret.x = newBasicTower.x;
				/* Removes build spot from stage and adds tower/turret */
				level.addChild(newBasicTower);
				level.addChild(newBasicTurret);
				/* Adds tower/turret to their respective arrays */
				towers.push(newBasicTower);
				turrets.push(newBasicTurret);

				spendCoins(20);
			}

		} // ends spawnBasicTower

		private function spawnRapidTower(): void {
			var newRapidTower: RapidTower = new RapidTower();
			var newRapidTurret: RapidTurret = new RapidTurret();
			if (coinCount >= 35) {
				/* Sets tower/turret x and y positions */
				if (buildSpotChooser == 1) {
					newRapidTower.y = level.buildSpot1.y;
					newRapidTower.x = level.buildSpot1.x;
					level.removeChild(level.buildSpot1);
					level.buildSpot1.used = true;
				} else if (buildSpotChooser == 2) {
					newRapidTower.y = level.buildSpot2.y;
					newRapidTower.x = level.buildSpot2.x;
					level.removeChild(level.buildSpot2);
					level.buildSpot2.used = true;
				}
				newRapidTurret.y = newRapidTower.y - 75;
				newRapidTurret.x = newRapidTower.x;
				/* Removes build spot from stage and adds tower/turret */
				level.addChild(newRapidTower);
				level.addChild(newRapidTurret);
				/* Adds tower/turret to their respective arrays */
				towers.push(newRapidTower);
				turrets.push(newRapidTurret);

				spendCoins(35);
			}

		} // ends spawnRapidTower

		private function spawnBombTower(): void {
			var newBombTower: BombTower = new BombTower();
			var newBombTurret: BombTurret = new BombTurret();
			if (coinCount >= 50) {
				/* Sets tower/turret x and y positions */
				if (buildSpotChooser == 1) {
					newBombTower.y = level.buildSpot1.y;
					newBombTower.x = level.buildSpot1.x;
					level.removeChild(level.buildSpot1);
					level.buildSpot1.used = true;
				} else if (buildSpotChooser == 2) {
					newBombTower.y = level.buildSpot2.y;
					newBombTower.x = level.buildSpot2.x;
					level.removeChild(level.buildSpot2);
					level.buildSpot2.used = true;
				}
				newBombTurret.y = newBombTower.y - 75;
				newBombTurret.x = newBombTower.x;
				/* Removes build spot from stage and adds tower/turret */
				level.addChild(newBombTower);
				level.addChild(newBombTurret);
				/* Adds tower/turret to their respective arrays */
				towers.push(newBombTower);
				turrets.push(newBombTurret);

				spendCoins(50);
			}

		} // ends spawnBombTower

		private function spawnCoin(coinNum: int, spawnX: Number, spawnY: Number): void {

			for (var i: int = 0; i < coinNum; i++) {
				var c: Coin = new Coin(spawnX, spawnY);
				level.addChild(c);
				coins.push(c);
				updateCoins();
			}
		} // ends spawnCoin

		private function updateCoins(): void {

			// update everything:
			for (var i: int = ScenePlay.coins.length - 1; i >= 0; i--) {
				ScenePlay.coins[i].update(); // Update design pattern.

				/** If bullet is dead, remove it. */
				if (ScenePlay.coins[i].isDead) {
					// remove it!!

					// 1. remove the object from the scene-graph
					level.removeChild(ScenePlay.coins[i]);

					// 2. nullify any variables pointing to it
					// if the variable is an array,
					// remove the object from the array
					ScenePlay.coins.splice(i, 1);
				}
			} // ends for loop updating bullets

		}

		/**
		 * Updates bullets for every frame.
		 */
		private function updateBulletsBad(): void {

			// update everything:
			for (var i: int = bulletsBad.length - 1; i >= 0; i--) {
				bulletsBad[i].update(); // Update design pattern.

				/** If bullet is dead, remove it. */
				if (bulletsBad[i].isDead) {
					// remove it!!

					// 1. remove the object from the scene-graph
					level.removeChild(bulletsBad[i]);

					// 2. nullify any variables pointing to it
					// if the variable is an array,
					// remove the object from the array
					bulletsBad.splice(i, 1);
				}
			} // ends updateBullets
		} // ends for loop updating bullets

		/**
		 *
		 */
		private function doubleBulletCollision(): void {
			for (var j: int = 0; j < bullets.length; j++) {
				for (var i: int = 0; i < bulletsBad.length; i++) {
					if (bullets[j].collider.checkOverlap(bulletsBad[i].collider)) {
						explodePlayerBullet(j);
						explodeEnemyBullet(i);
					}
				}
			}
		}
		/**
		 *
		 */
		private function castleBulletBadCollision(): void {
			for (var i: int = 0; i < bulletsBad.length; i++) {
				if (castle.colliderCenter.checkOverlap(bulletsBad[i].collider)) {
					damageCastle();
					explodeEnemyBullet(i);
				}
				if (castle.colliderRight.checkOverlap(bulletsBad[i].collider)) {
					damageCastle();
					explodeEnemyBullet(i);
				}
				if (castle.colliderLeft.checkOverlap(bulletsBad[i].collider)) {
					damageCastle();
					explodeEnemyBullet(i);
				}
			}
		}


		/**
		 *
		 */
		private function playerBulletBadCollision(): void {
			for (var i: int = 0; i < bulletsBad.length; i++) {
				if (player.collider.checkOverlap(bulletsBad[i].collider)) {
					damagePlayer();
					explodeEnemyBullet(i);
				}
			}
		}
		/**
		 * 
		 */
		private function playerWallCollision(): void {
			if(player.collider.checkOverlap(level.playerWall.collider)) {
				// find the fix:
				var fix: Point = player.collider.findOverlapFix(level.playerWall.collider);
				//trace(fix);
				// apply the fix:
				player.applyFix(fix);
			}
		}

		/**
		 * 
		 * @param i 
		 */
		private function platformCollision(i: Number): void {
			// Collision for player hitting platforms.
			if (player.collider.checkOverlap(ScenePlay.platforms[i].collider)) { // if we are overlapping
				// find the fix:
				var fix: Point = player.collider.findOverlapFix(ScenePlay.platforms[i].collider);
				//trace(fix);
				// apply the fix:
				player.applyFix(fix);
			}

			// Collision for enemies hitting platforms.
			for (var k: int = 0; k < ScenePlay.enemies.length; k++) {
				if (ScenePlay.enemies[k].collider.checkOverlap(ScenePlay.platforms[i].collider)) {
					var enemyFix: Point = ScenePlay.enemies[k].collider.findOverlapFix(ScenePlay.platforms[i].collider);
					ScenePlay.enemies[k].applyFix(enemyFix);

				}
			}
			// Collision for player bullets hitting platforms.
			for (var j: int = 0; j < bullets.length; j++) {
				if (bullets[j].collider.checkOverlap(ScenePlay.platforms[i].collider)) {
					//trace(player.collider.checkOverlap(platforms[i].collider));
					explodePlayerBullet(j);
				}
			} // ends for

			// Collision for enemy bullets hitting platforms.
			for (var m: int = 0; m < bulletsBad.length; m++) {
				if (bulletsBad[m].collider.checkOverlap(ScenePlay.platforms[i].collider)) {
					//trace(player.collider.checkOverlap(platforms[i].collider));
					explodeEnemyBullet(m);
				}
			} // ends for
			// Collision for coins hitting platforms.
			for (var l: int = 0; l < coins.length; l++) {
				if (ScenePlay.coins[l].collider.checkOverlap(ScenePlay.platforms[i].collider)) {
					var coinFix: Point = ScenePlay.coins[l].collider.findOverlapFix(ScenePlay.platforms[i].collider);
					ScenePlay.coins[l].applyFix(coinFix);
				}
			} // ends for 
		} // ends platformCollision

		private function playerBuildSpotCollsion(): void {
			//trace("playerBuildSpotCollision()");
			if (player.collider.checkOverlap(level.buildSpot1.collider)) {
				//trace("If player overlaps with BuildSpot1 ...");
				level.buildSpot1.buildInstructions.alpha = 1;
				if (!level.buildSpot1.used) {
					//trace("If BuildSpot1 hasn't been used ...");
					buildSpotChooser = 1;
					spawnTower();
				}
			} else level.buildSpot1.buildInstructions.alpha = 0;
			if (player.collider.checkOverlap(level.buildSpot2.collider)) {
				level.buildSpot2.buildInstructions.alpha = 1;
				if (!level.buildSpot2.used) {
					buildSpotChooser = 2;
					spawnTower();
				}
			} else level.buildSpot2.buildInstructions.alpha = 0;
		}

		private function bulletEnemyCollision(): void {
			for (var i: int = 0; i < bullets.length; i++) {
				for (var j: int = 0; j < ScenePlay.enemies.length; j++) {
					if (bullets[i].collider.checkOverlap(ScenePlay.enemies[j].collider)) {
						killEnemy(j);
						explodePlayerBullet(i);
						explodePlayerBullet(i);
						spawnCoin(3, ScenePlay.enemies[j].x, ScenePlay.enemies[j].y);
						updateEnemies();
					}
				} // ends for
			} // ends for
		} // ends bulletEnemyCollision

		private function playerEnemyCollision(): void {
			for (var i: int = 0; i < ScenePlay.enemies.length; i++) {
				if (player.collider.checkOverlap(ScenePlay.enemies[i].collider)) {
					var playerFix: Point = player.collider.findOverlapFix(ScenePlay.enemies[i].collider);
					//var enemyFix: Point = ScenePlay.enemies[i].collider.findOverlapFix(player.collider);
					player.applyFix(playerFix);
					//ScenePlay.enemies[i].applyFix(enemyFix);
				}
			} // ends for
		} // ends playerEnemyCollision

		private function playerCoinCollision(): void {
			for (var i: int = 0; i < ScenePlay.coins.length; i++) {
				if (player.collider.checkOverlap(ScenePlay.coins[i].collider)) {
					collectCoin(i);
				}
			}
		}

		private function collectCoin(index: int) {
			coinSound.play();
			ScenePlay.coins[index].isDead = true;
			updateCoins();
			coinCount++;
		}

		private function killEnemy(index: int): void {
			enemyDieSound.play();
			ScenePlay.enemies[index].isDead = true;

			for (var i: int = 0; i < 10; i++) {
				var p: Particle = new ParticleBlood(ScenePlay.enemies[index].x, ScenePlay.enemies[index].y);
				level.addChild(p);
				particles.push(p);
			}
		}

		private function spendCoins(coinNum: int): void {
			coinCount -= coinNum;

			if (coinCount <= 0) {
				coinCount = 0;
			}
		}
	} // ends class
} // ends package