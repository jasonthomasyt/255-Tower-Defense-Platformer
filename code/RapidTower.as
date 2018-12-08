﻿package code {

	/**
	 * 
	 */
	public class RapidTower extends Tower {

		/** The collider for the player. */
		public var colliderSpire: AABB;
		/** The collider for the player. */
		public var colliderBase: AABB;
		
		public var isBasicTower = false;
		
		public var isRapidTower = true;
		
		public var isBombTower = false;
		
		/**
		 * 
		 */
		public function RapidTower() {
			// constructor code
			colliderSpire = new AABB(rapidTowerSpire.width / 2, rapidTowerSpire.height / 2);
			colliderBase = new AABB(rapidTowerBase.width / 2, rapidTowerBase.height / 2);
		}
		/**
		 * 
		 * 
		 */
		public override function update(scenePlay: ScenePlay): void {
			towerHealth.barColor.scaleX = health / maxHealth;
			
			colliderSpire.calcEdges(x, y);
			colliderBase.calcEdges(x, y);
		}
	}
}