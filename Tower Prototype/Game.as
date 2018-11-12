package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Game extends MovieClip {
		/* The array for bullets */
		var bullets:Array = new Array();
		
		/* The constructor for the game class */
		public function Game() {
			addEventListener(Event.ENTER_FRAME, gameLoop); //Runs gameLoop on startup
			stage.addEventListener(MouseEvent.MOUSE_DOWN, spawnBullets);
		}
		/* The function for the game loop */
		public function gameLoop(e:Event):void {
			turret.update();
			updateBullets(); //updates the bullets
		}
		/* The function handling the spawning of bullets */
		private function spawnBullets(e:MouseEvent):void {
			var b:Bullet = new Bullet(); //instantiate bullet
			addChild(b);
			b.setVelocity(turret); //set its speed with the setVelocity function
			bullets.push(b);
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
	}
	
}
