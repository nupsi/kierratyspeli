package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Assets extends Sprite
	{
		[Embed('/textures/kauppaKuvake.png')]
		public static var shopImage:Class;
		
		[Embed('/textures/achiementBg.png')]
		public static var achiementB:Class;
		
		[Embed('/textures/kaupanPohjaKuva.png')]
		public static var shopBg:Class;
		
		[Embed('/textures/hihnaAnim.swf')]
		public static var hihnaAnim:Class
		
		
		public function Assets()
		{
			super();
		}
	}
}