package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	/*
	 *	Tässä luokassa on tarkoitus luoda roskakorit ja niiden sijainti  
	 */
	public class Roskakorit extends Sprite
	{
		private var kori1:Image;
		private var kori2:Image;
		private var kori3:Image;
		private var kori4:Image;
		private var kori5:Image;
		private var kori6:Image;
		
		public function Roskakorit()
		{
			setKoriTextures();
			setKoriPos();
			addKori();
		}
		
		private function addKori():void
		{
			this.addChild(kori1);
			this.addChild(kori2);
			this.addChild(kori3);
			this.addChild(kori4);
			this.addChild(kori5);
			this.addChild(kori6);
		}
		
		private function setKoriPos():void
		{
			kori1.x = 10;
			kori2.x = kori1.x + kori1.width + 10;
			kori3.x = kori2.x + kori2.width + 10;
			kori4.x = kori3.x + kori3.width + 10;
			kori5.x = kori4.x + kori4.width + 10;
			kori6.x = kori5.x + kori5.width + 10;
		}
		
		private function setKoriTextures():void
		{
			kori1 = new Image(Assets.getAtlas().getTexture("kori1"));
			kori2 = new Image(Assets.getAtlas().getTexture("kori2"));
			kori3 = new Image(Assets.getAtlas().getTexture("kori3"));
			kori4 = new Image(Assets.getAtlas().getTexture("kori4"));
			kori5 = new Image(Assets.getAtlas().getTexture("kori5"));
			kori6 = new Image(Assets.getAtlas().getTexture("kori6"));
		}
	}
}