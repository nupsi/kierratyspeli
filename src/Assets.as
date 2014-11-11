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
		public static const tausta1:Class;
		
		[Embed(source="../media/textures/tausta2.png")]
		public static const tausta2:Class;
		
		[Embed(source="../media/textures/tausta3.png")]
		public static const tausta3:Class;
		
		[Embed(source="../media/textures/playBtn.png")]
		public static const playBtn:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		/*
		[Embed(source="../media/textures/GUI.png")]
		public static const AtlasTextureGame:Class
		
		[Embed(source="../media/textures/GUI.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class*/
		
		
		public static function getTextures(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		/*
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTextures("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml)
			}
			return gameTextureAtlas
		}
		*/
	}
	
}