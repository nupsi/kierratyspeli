package screens
{
	import objects.hihna;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	/*
		Tässä luokassa luodaan: Peli
	*/
	public class GameMain extends Sprite
	{
		private var bg1:Image;
		
		private var hihnaa:hihna = new hihna();
		private var hihnaa2:hihna = new hihna();
		private var hihnaa3:hihna = new hihna();
		private var hihnaa4:hihna = new hihna();
		
		public function GameMain()
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			createScreen();
		}
		
		private function createScreen():void
		{
			bg1 = new Image(Assets.getTextures("tausta3"));
			this.addChild(bg1);
			
			createHihna();
		}
		
		private function createHihna():void
		{
			//TÄMÄ TOIMINTO PITÄÄ TODENNÄKÖISESTI TEHDÄ UUDESTAAN
			for(var i:int = 0; i < 5;i++)
			{
				hihnaa.x = 0;
				hihnaa2.x = hihnaa.x + hihnaa.width - .5;
				hihnaa3.x = hihnaa2.x + hihnaa2.width - .5;
				hihnaa4.x = hihnaa3.x + hihnaa3.width - .5;
				
				hihnaa.y = stage.stageHeight * 0.45;
				hihnaa2.y = hihnaa.y;
				hihnaa3.y = hihnaa.y;
				hihnaa4.y = hihnaa.y;
				
				this.addChild(hihnaa);
				this.addChild(hihnaa2);
				this.addChild(hihnaa3);
				this.addChild(hihnaa4);
			}
		}
		
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}	
	}
}