package code {
	
	public class BasicTower extends Tower{

		public function BasicTower() {
			// constructor code
		}
	public override function update(scenePlay: ScenePlay): void {


			towerHealth.scaleX = health / maxHealth;



		}
	}
	
}
