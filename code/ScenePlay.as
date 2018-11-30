
			} // ends for
			
			// Collision bewteen good bullets and bad bullets
			doubleBulletCollision();
			
			// Collision between player and badBullets
			playerBulletBadCollision();
		} // ends doCollisionDetection()

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
				if(castle.colliderCenter.checkOverlap(bulletsBad[i].collider)) {
					damageCastle();
					explodeEnemyBullet(i);
				}
				if(castle.colliderRight.checkOverlap(bulletsBad[i].collider)) {
					damageCastle();
					explodeEnemyBullet(i);
				}
				if(castle.colliderLeft.checkOverlap(bulletsBad[i].collider)) {
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
				if(player.collider.checkOverlap(bulletsBad[i].collider)) {
					damagePlayer();
					explodeEnemyBullet(i);
				}
			}
		}
		