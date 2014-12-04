package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	/*
	 *	Tässä luokassa on tarkoitus luoda roskakorit ja niiden sijainti  
	 */
	public class Roskakorit extends Sprite
	{
		private var _binCount:int;
		
		private var binArea:int = 490;
		
		public function Roskakorit(value:int)
		{
			this.korienMaara = value;
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
				var kori:Image = new Image(Assets.getAtlas().getTexture("kori_" + Math.ceil(Math.random()*6)));
				kori.width = 120;
				kori.height = 125
				kori.x = ((binArea / _binCount) / 2) * (i * 2) + 20
				
				kori.y = 480 - 125;
				this.addChild(kori);
			}
		}
	}
}