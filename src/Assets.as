package
{
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.formats.Direction;
	
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets
	{
		[Embed(source="../media/textures/tausta1.png")]
		public static const Bg1:Class;
		
		[Embed(source="../media/textures/tausta2.png")]
		public static const Bg2:Class;
		
		[Embed(source="../media/textures/playBtn.png")]
		public static const playBtn:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTextures(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
	
}