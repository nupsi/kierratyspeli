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
		private var kauppaBg:Image;
		private var saavutusBg:Image;
		
		private var kauppaBtn:Button;
		private var saavutusBtn:Button;
		
		private var kauppaAvausNopeus:int = 10;
		
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
			
			kauppaBg = new Image(Assets.getTextures("kaupanPohjaKuva"));
			kauppaBg.x = stage.stageWidth * 0.5 - kauppaBg.width * 0.5;
			kauppaBg.y = stage.stageHeight * 0.5 - kauppaBg.height * 0.5;
			saavutusBg = new Image(Assets.getTextures("saavutustenPohjaKuva"));
			saavutusBg.x = stage.stageWidth * 0.5 - saavutusBg.width * 0.5;
			saavutusBg.y = stage.stageHeight * 0.5 - saavutusBg.height * 0.5;
			
			kauppaBtn = new Button(Assets.getAtlas().getTexture("kauppaKuvake"));
			kauppaBtn.x = stage.stageWidth - kauppaBtn.width * 1.2;
			kauppaBtn.y = kauppaBtn.height * 0.2;
			
			saavutusBtn = new Button(Assets.getAtlas().getTexture("saavutus"));
			saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
			saavutusBtn.y = kauppaBtn.y;
			
			createHihna();
			
			this.addChild(kauppaBtn)
			this.addChild(saavutusBtn)
				
			this.addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
		private function onButtonClick(event:Event):void
		{
			var buttonC:Button = event.target as Button
			if((buttonC as Button) == kauppaBtn)
			{
				openShop()
			}
			
			if((buttonC as Button) == saavutusBtn)
			{
				openSaavutus()
			}
		}
		
		private function openShop():void
		{
			this.addEventListener(Event.ENTER_FRAME, kauppaLiike)
			kauppaBg.y = stage.stageHeight;
			this.addChild(kauppaBg)
		}
	
		private function kauppaLiike(event:Event):void
		{
			if(kauppaBg.y > stage.stageHeight * 0.5 - kauppaBg.height * 0.5)
				kauppaBg.y -= kauppaAvausNopeus;
			else
				this.removeEventListener(Event.ENTER_FRAME, kauppaLiike);
			
			kauppaBtn.x += kauppaAvausNopeus * 0.1;
			kauppaBtn.alpha -= .05
			saavutusBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha -= .05
		}
		
		private function openSaavutus():void
		{
			this.addEventListener(Event.ENTER_FRAME, saavutusLiike);
			saavutusBg.y = stage.stageHeight;
			this.addChild(saavutusBg)
		}
		
		private function saavutusLiike(event:Event):void
		{
			if(saavutusBg.y > stage.stageHeight * 0.5 - saavutusBg.height * 0.5)
				saavutusBg.y -= kauppaAvausNopeus;
			else
				this.removeEventListener(Event.ENTER_FRAME, saavutusLiike);
			
			kauppaBtn.x += kauppaAvausNopeus * 0.1;
			kauppaBtn.alpha -= .05
			saavutusBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha -= .05
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