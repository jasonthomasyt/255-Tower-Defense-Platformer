package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Game extends MovieClip {
		/* The array for bullets */
		var bullets:Array = new Array();
		var turrets:Array = new Array();
		private var towerExists:Boolean = false;
		
		/* The constructor for the game class */
		public function Game() {
			
			addEventListener(Event.ENTER_FRAME, gameLoop); //Runs gameLoop on startup
			stage.addEventListener(MouseEvent.MOUSE_DOWN, spawnBullets); //adds mouse event listener for shooting
			buildSpot.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, spawnTower);//adds mouse event listener for build spot
			
		}
		
		/* The function for the game loop */
		public function gameLoop(e:Event):void {
			
			updateTurrets(); //updates the turrets
			updateBullets(); //updates the bullets
			
		}
		
		/* The function handling the spawning of bullets */
		private function spawnBullets(e:MouseEvent):void {
			
			if(towerExists){
				var b:Bullet = new Bullet(); //instantiate bullet
				addChild(b);
				for (var i = turrets.length - 1; i >= 0; i--){
					b.setVelocity(turrets[i]); //set its speed with the setVelocity function
				}
				bullets.push(b);
			}
			
		}
		
		/* The function handling the updating of bullets */
		private function updateBullets():void {
			
			for(var i = bullets.length - 1; i >= 0; i --){
				bullets[i].update(); //update each bullet's position
				if(bullets[i].isDead){ //remove bulets if they are dead
					removeChild(bullets[i]);
					bullets.splice(i, 1);
				}
			}
			
		}
		private function updateTurrets():void {
			
			for (var i = turrets.length - 1; i >= 0; i--){
				turrets[i].update();
			}
			
		}
		
		private function spawnTower(e:MouseEvent):void {
			
			if(!towerExists){
				trace("yay");
				/* Instantiate a tower */
				var newTower:Tower = new Tower();
				/* Set tower's position to the build spot's */
				newTower.x = buildSpot.x;
				newTower.y = buildSpot.y;
				/* Instantiate a turret */
				var newTurret:Turret = new Turret();
				/* Set turret's position to the new tower's */
				newTurret.x = newTower.x;
				newTurret.y = newTower.y - 225;
				/* Adds tower/turret to stage */
				addChild(newTower);
				addChild(newTurret);
				/* Adds turret to turret array */
				turrets.push(newTurret);
				towerExists = true;
				buildSpot.visible = false;
			}
			
		}
	}
}
