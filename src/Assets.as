package
{
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.formats.Direction;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/*
		Tässä luokassa todaan pelin texturet
	*/
	public class Assets
	{	
//IMAGES
		[Embed(source="../media/fonts/Arial.ttf", embedAsCFF="false", fontFamily="embedFont")]
		private static const embedFont:Class;
		
		[Embed(source="../media/textures/tausta1.png")]
		public static const tausta1:Class;
		
		[Embed(source="../media/textures/tausta2.png")]
		public static const tausta2:Class;
		
		[Embed(source="../media/textures/tausta3.png")]
		public static const tausta3:Class;
		
		[Embed(source="../media/textures/tausta4.png")]
		public static const tausta4:Class;
		
		[Embed(source="../../media/textures/ikkuna.swf", mimeType="application/octet-stream")]
		public static const ikkuna:Class;
		
		[Embed(source="../media/textures/kone.png")]
		public static const kone:Class;
		
		[Embed(source="../media/textures/kaupanPohjaKuva.png")]
		public static const kaupanPohjaKuva:Class;
		
		[Embed(source="../media/textures/saavutustenPohjaKuva.png")]
		public static const saavutustenPohjaKuva:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../media/textures/spriteSheet1.png")]
		public static const AtlasTextureGame:Class
		
		[Embed(source="../media/textures/spriteSheet1.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class
		
		
		public static function getTextures(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
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
//SOUNDS
		[Embed(source="../media/sounds/kierratyspeliTheme.mp3")]
		public static const theme:Class;
//ITEM SHEET
		[Embed(source="../media/textures/itemSheet.png")]
		public static const AtlasTextureItem:Class
		
		[Embed(source="../media/textures/itemSheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlItem:Class
		
		private static var itemTextureAtlas:TextureAtlas;
		
		public static function getItems():TextureAtlas
		{
			if(itemTextureAtlas == null)
			{
				var texture:Texture = getTextures("AtlasTextureItem");
				var xml:XML = XML(new AtlasXmlItem());
				itemTextureAtlas = new TextureAtlas(texture, xml)
			}
			return itemTextureAtlas
		}
	}	
}