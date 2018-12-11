﻿package code {

	/**
	 * 
	 */
	public class BasicTower extends Tower {

		/** The collider for the player. */
		public var colliderSpire: AABB;
		/** The collider for the player. */
		public var colliderBase: AABB;
		
		public var isBasicTower: Boolean = true;
		
		public var isRapidTower: Boolean = false;
		
		public var isBombTower: Boolean = false;
		
		/**
		 * 
		 */
		public function BasicTower() {
			// constructor code
			colliderSpire = new AABB(basicTowerSpire.width / 2, basicTowerSpire.height / 2);
			colliderBase = new AABB(basicTowerBase.width / 2, basicTowerBase.height / 2);
			
			colliderSpire.calcEdges(x, y);
			colliderBase.calcEdges(x, y);
		}
		/**
		 * 
		 * 
		 */
		public override function update(scenePlay: ScenePlay): void {
			towerHealth.scaleX = health / maxHealth;
			
			colliderSpire.calcEdges(x, y);
			colliderBase.calcEdges(x, y);
		}
	}
}