package screens
{
	import objects.hihna;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/*
		Tässä luokassa luodaan: Peli
	*/
	public class GameMain extends Sprite
	{
		private var bg1:Image;
		private var kauppaBg:Image;
		private var saavutusBg:Image;
		private var kone:Image;
		
		private var kauppaAuki:Boolean 			= false;	
		private var kauppaPainettu:Boolean 		= false;
		private var saavutusAuki:Boolean		= false;	
		private var saavutusPainettu:Boolean	= false;
		
		private var kauppaTavara1:Button;	
		private var kauppaTavara2:Button;
		private var kauppaTavara3:Button;	
		private var kauppaTavara4:Button;
		private var kauppaTavara5:Button;	
		private var kauppaTavara6:Button;
		
		private var saavutus1:Image;		
		private var saavutus2:Image;
		private var saavutus3:Image;		
		private var saavutus4:Image;
		private var saavutus5:Image;		
		private var saavutus6:Image;
		private var saavutus7:Image;		
		private var saavutus8:Image;
		private var saavutus9:Image;
		
		private var kauppaContainer:Sprite
		
		private var kauppaVL:Button;
		private var saavutusVL:Button;
		
		private var saavutusInfo:TextField = new TextField(412,105,saavutusText,"embedFont",13,0x000000,false);
		private var saavutusText:String = "Tervetuloa saavutus valikkoon.";
		
		private var kauppaBtn:Button;
		private var saavutusBtn:Button;
		private var ruksi:Button;
		
		private var kauppaAvausNopeus:int = 10;
		
		private var hihnaa:hihna 	= new hihna();		
		private var hihnaa2:hihna 	= new hihna();
		private var hihnaa3:hihna 	= new hihna();	
		private var hihnaa4:hihna 	= new hihna();
		
		public function GameMain()
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			setTextures();
			createScreen();
		}
//TEXTURET
		private function setTextures():void
		{
			bg1 			= new Image(Assets.getTextures("tausta3"));
			kauppaBg 		= new Image(Assets.getTextures("kaupanPohjaKuva"));
			saavutusBg 		= new Image(Assets.getTextures("saavutustenPohjaKuva"));
			kauppaBtn 		= new Button(Assets.getAtlas().getTexture("kauppaKuvake"));
			saavutusBtn 	= new Button(Assets.getAtlas().getTexture("saavutus"));
			kone 			= new Image(Assets.getTextures("kone"));
			ruksi 			= new Button(Assets.getAtlas().getTexture("symbolX"));
			kauppaTavara1	= new Button(Assets.getAtlas().getTexture("kauppa_1"));
			kauppaTavara2 	= new Button(Assets.getAtlas().getTexture("kauppa_2"));
			kauppaTavara3 	= new Button(Assets.getAtlas().getTexture("kauppa_3"));
			kauppaTavara4	= new Button(Assets.getAtlas().getTexture("kauppa_4"));
			kauppaTavara5 	= new Button(Assets.getAtlas().getTexture("kauppa_5"));
			kauppaTavara6 	= new Button(Assets.getAtlas().getTexture("kauppa_6"));
			saavutus1 		= new Image(Assets.getAtlas().getTexture("saavutus1"));
			saavutus2 		= new Image(Assets.getAtlas().getTexture("saavutus2"));
			saavutus3 		= new Image(Assets.getAtlas().getTexture("saavutus3"));
			saavutus4 		= new Image(Assets.getAtlas().getTexture("saavutus4"));
			saavutus5 		= new Image(Assets.getAtlas().getTexture("saavutus5"));
			saavutus6		= new Image(Assets.getAtlas().getTexture("saavutus6"));
			saavutus7 		= new Image(Assets.getAtlas().getTexture("saavutus7"));
			saavutus8 		= new Image(Assets.getAtlas().getTexture("saavutus8"));
			saavutus9 		= new Image(Assets.getAtlas().getTexture("saavutus9"));
		}
//TEKEE NÄKYMÄN
		private function createScreen():void
		{
			kauppaBg.x = stage.stageWidth * 0.5 - kauppaBg.width * 0.5;
			kauppaBg.y = stage.stageHeight * 0.5 - kauppaBg.height * 0.5;
			
			saavutusBg.x = stage.stageWidth * 0.5 - saavutusBg.width * 0.5;
			saavutusBg.y = stage.stageHeight * 0.5 - saavutusBg.height * 0.5;
			
			kauppaBtn.x = stage.stageWidth - kauppaBtn.width * 1.2;
			kauppaBtn.y = kauppaBtn.height * 0.2;
			
			saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
			saavutusBtn.y = kauppaBtn.y;
			
			kone.x = -155;		kone.y = 30;		kone.scaleY = 1.2;
			
			this.addChild(bg1);
			createHihna();
			this.addChild(kauppaBtn);
			this.addChild(saavutusBtn);
			this.addChild(kone);
			
			this.addEventListener(Event.TRIGGERED, onButtonClick);
		}
//BUTTONS
		private function onButtonClick(event:Event):void
		{
			var buttonC:Button = event.target as Button
			if((buttonC as Button) == kauppaBtn)
			{
				if(kauppaPainettu == false)
				{
					kauppaPainettu 		= true;
					saavutusPainettu 	= true;
					openShop();
				}
			}
			
			if((buttonC as Button) == saavutusBtn)
			{
				if(saavutusPainettu == false)
				{
					saavutusPainettu 	= true;
					kauppaPainettu 		= true;
					openSaavutus();
				}
			}
			
			if((buttonC as Button) == ruksi)
			{
				if(kauppaAuki == true)
				{
					this.removeChild(ruksi);
					this.addEventListener(Event.ENTER_FRAME, suljeKauppa);
					this.addChild(kauppaBtn);
					this.addChild(saavutusBtn);
				}
				
				if(saavutusAuki == true)
				{
					this.removeChild(ruksi);
					this.addEventListener(Event.ENTER_FRAME, suljeSaavutus);
					this.addChild(kauppaBtn);
					this.addChild(saavutusBtn);
				}
			}
		}
//KAUPAN TOIMINNOT ALKAA
		private function openShop():void
		{
			if(saavutusAuki == false)
				this.addEventListener(Event.ENTER_FRAME, kauppaLiike);
			
			kauppaBg.y = stage.stageHeight;
			this.addChild(kauppaBg);
			ruksi.x = kauppaBg.x + kauppaBg.width - ruksi.width * 0.5;
			this.addChild(kauppaTavara1);	this.addChild(kauppaTavara2);
			this.addChild(kauppaTavara3);	this.addChild(kauppaTavara4);
			this.addChild(kauppaTavara5);	this.addChild(kauppaTavara6);
			this.addChild(ruksi);
		}
	
		private function kauppaLiike(event:Event):void
		{
			if(kauppaBg.y > stage.stageHeight * 0.5 - kauppaBg.height * 0.5)
				kauppaBg.y -= kauppaAvausNopeus;
			else
			{
				kauppaAuki = true;
				this.removeChild(saavutusBtn);
				this.removeChild(kauppaBtn);
				this.removeEventListener(Event.ENTER_FRAME, kauppaLiike);
			}
			kauppaKuvakeLiike();
			ruksi.y = kauppaBg.y + 10;
			kauppaBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha -= .05;
			kauppaBtn.alpha -= .05;
		}
		
		private function suljeKauppa(event:Event):void
		{
			if(kauppaBg.y < stage.stageHeight)
				kauppaBg.y += kauppaAvausNopeus;
			else
			{
				kauppaAuki = false;
				kauppaPainettu = false;
				saavutusPainettu = false;
				kauppaBtn.x = stage.stageWidth - kauppaBtn.width * 1.2;
				saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
				this.removeEventListener(Event.ENTER_FRAME, suljeKauppa);
			}
			kauppaKuvakeLiike();
			kauppaBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha += .05;
			kauppaBtn.alpha += .05;
		}
		
		private function kauppaKuvakeLiike():void
		{
			kauppaTavara1.x = kauppaBg.x + 30;
			kauppaTavara2.x = kauppaTavara1.x + kauppaTavara1.width + 49;
			kauppaTavara3.x = kauppaTavara2.x + kauppaTavara2.width + 34;
			kauppaTavara4.x = kauppaTavara1.x;
			kauppaTavara5.x = kauppaTavara2.x;
			kauppaTavara6.x = kauppaTavara3.x;
			
			kauppaTavara1.y = kauppaBg.y + 45;	
			kauppaTavara2.y = kauppaTavara1.y
			kauppaTavara3.y = kauppaTavara1.y;
			kauppaTavara4.y = kauppaBg.y + kauppaTavara1.height + 45 + 26;
			kauppaTavara5.y = kauppaTavara4.y;	
			kauppaTavara6.y = kauppaTavara4.y;
		}
//SAAVUTUKSEN TOIMINNOT ALKAA
		private function openSaavutus():void
		{
			if(kauppaAuki == false)
				this.addEventListener(Event.ENTER_FRAME, saavutusLiike);
			
			saavutusBg.y = stage.stageHeight;
			this.addChild(saavutusBg);
			ruksi.x = saavutusBg.x + saavutusBg.width - ruksi.width * 0.5;
			this.addChild(saavutus1);	this.addChild(saavutus2);
			this.addChild(saavutus3);	this.addChild(saavutus4);
			this.addChild(saavutus5);	this.addChild(saavutus6);
			this.addChild(saavutus7);	this.addChild(saavutus8);
			this.addChild(saavutus9);
			this.addChild(ruksi);		this.addChild(saavutusInfo);
		}
		
		private function saavutusLiike(event:Event):void
		{
			if(saavutusBg.y > stage.stageHeight * 0.5 - saavutusBg.height * 0.5)
				saavutusBg.y -= kauppaAvausNopeus;
			else
			{
				saavutusAuki = true;
				kauppaPainettu = false;
				saavutusPainettu = false;
				this.removeChild(saavutusBtn);
				this.removeChild(kauppaBtn);
				this.removeEventListener(Event.ENTER_FRAME, saavutusLiike);
			}
			saavutusKuvakeLiike()
			ruksi.y = saavutusBg.y + 10;
			kauppaBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha -= .05
			kauppaBtn.alpha -= .05
		}
		
		private function suljeSaavutus(event:Event):void
		{
			if(saavutusBg.y < stage.stageHeight)
				saavutusBg.y += kauppaAvausNopeus;
			else
			{
				kauppaBtn.x = stage.stageWidth - kauppaBtn.width * 1.2;
				saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
				saavutusAuki = false;
				kauppaPainettu = false;
				saavutusPainettu = false;
				this.removeEventListener(Event.ENTER_FRAME, suljeSaavutus);
			}
			saavutusKuvakeLiike()
			kauppaBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha += .05;
			kauppaBtn.alpha += .05;
		}
		
		private function saavutusKuvakeLiike():void
		{
			saavutus1.x = saavutusBg.x + 16;					saavutus1.y = saavutusBg.y + 43;
			saavutus2.x = saavutus1.x + saavutus1.width + 56;	saavutus2.y = saavutus1.y;
			saavutus3.x = saavutus2.x + saavutus2.width + 56;	saavutus3.y = saavutus1.y;
			saavutus4.x = saavutus3.x + saavutus3.width + 53;	saavutus4.y = saavutus1.y;
			saavutus5.x = saavutus1.x;							saavutus5.y = saavutus1.y + saavutus1.width +23;
			saavutus6.x = saavutus2.x;							saavutus6.y = saavutus5.y;
			saavutus7.x = saavutus3.x;							saavutus7.y = saavutus5.y;
			saavutus8.x = saavutus4.x;							saavutus8.y = saavutus5.y;
			saavutus9.x = saavutus1.x;							saavutus9.y = saavutus5.y + saavutus5.height + 28;
			saavutusInfo.x = saavutus2.x;						saavutusInfo.y = saavutus9.y;
		}
//HIHNAN LUONTI
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
				
				this.addChild(hihnaa);		this.addChild(hihnaa2);
				this.addChild(hihnaa3);		this.addChild(hihnaa4);
			}
		}
//MUUT
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}	
	}
}