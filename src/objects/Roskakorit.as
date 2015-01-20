package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	/*
	 *	Tässä luokassa on tarkoitus luoda roskakorit ja niiden sijainti  
	 */
	public class Roskakorit extends Sprite
	{
		private var _binCount:int;
		private var kori1:int;
		private var kori2:int;
		private var kori3:int;
		private var kori4:int;
		
		private var binArea:int = 480;
		
		public function Roskakorit(value:int, k1:int,k2:int,k3:int,k4:int)
		{
			this.korienMaara = value;
			kori1 = k1;
			kori2 = k2;
			kori3 = k3;
			kori4 = k4;
			createHihna(_binCount);
		}		
		
		public function get korienMaara():int
		{
			return _binCount;
		}
		
		public function set korienMaara(value:int):void
		{
			_binCount = value;
		}
		
		private function createHihna(value:int):void
		{
			var num:int = value;
			for(var i:int = 0; i < num; i++)
			{
				var u:int
				
				switch(i)
				{
					case 0:
						u = kori1
						break;
					case 1:
						u = kori2
						break;
					case 2:
						u = kori3
						break;
					case 3:
						u = kori4
						break;
				}
			//sets the texture and calculates x position
				var kori:Image = new Image(Assets.getAtlas().getTexture("kori_" + u));
				kori.width = 110;
				kori.height = 125;
				kori.x = (((binArea / 4) / 2) * (i * 2) + 20);
				kori.y = 480 - kori.height;
				this.addChild(kori);
				koriTypeText(kori.x,kori.width,kori.y,u)
			}
		}
		
		private function koriTypeText(x:Number, width:Number, y:int,u:int):void
		{
			var typeText:TextField = new TextField(width,40,"","EmbedFont",15,0x0);
				typeText.x = x;
				typeText.y = y + 50;
			switch(u)
			{
				case 1:
					typeText.text = "Pahvi";
					break;
				case 2:
					typeText.text = "Metalli";
					break;
				case 3:
					typeText.text = "Lasi";
					break;
				case 4:
					typeText.text = "Biojäte";
					break;
				case 5:
					typeText.text = "Vaarallinen\njäte";
					break;
				case 6:
					typeText.text = "Sekajäte";
					break;
			}
			this.addChild(typeText)
		}
	}
}