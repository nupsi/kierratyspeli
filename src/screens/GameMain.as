package screens
{
	import flash.utils.getTimer;
	
	import objects.hihna;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;

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
	//Kaupan tavaroiden tiedot [tyyppi(ÄLÄ MUUTA), hinta, tiedot]
	//kt on lyhenne kauppaan liittyville asioille.
		private var kt1			:Button;
		private var kt1Hinta	:int = 100;
		private var kt1Info		:String = "";
		private var kt1Ostettu	:Boolean = false;
			
		private var kt2			:Button;
		private var kt2Hinta	:int = 300;
		private var kt2Info		:String = "";
		private var kt2Ostettu	:Boolean = false;
			
		private var kt3			:Button;
		private var kt3Hinta	:int = 600;
		private var kt3Info		:String = "";
		private var kt3Ostettu	:Boolean = false;
			
		private var kt4			:Button;
		private var kt4Hinta	:int = 800;
		private var kt4Info		:String = "";
		private var kt4Ostettu	:Boolean = false;
			
		private var kt5			:Button;
		private var kt5Hinta	:int = 900;
		private var kt5Info		:String = "";
		private var kt5Ostettu	:Boolean = false;
			
		private var kt6			:Button;
		private var kt6Hinta	:int = 190;
		private var kt6Info		:String = "";
		private var kt6Ostettu	:Boolean = false;
	//Saavutusten tiedot	
		private var saavutus1		:Image;
		private var saavutus1Saatu	:Boolean = false;			
		private var saavutus2		:Image;
		private var saavutus2Saatu	:Boolean = false;
		private var saavutus3		:Image;
		private var saavutus3Saatu	:Boolean = false;
		private var saavutus4		:Image;
		private var saavutus4Saatu	:Boolean = false;	
		private var saavutus5		:Image;
		private var saavutus5Saatu	:Boolean = false;
		private var saavutus6		:Image;
		private var saavutus6Saatu	:Boolean = false;
		private var saavutus7		:Image;
		private var saavutus7Saatu	:Boolean = false;
		private var saavutus8		:Image;
		private var saavutus8Saatu	:Boolean = false;
		private var saavutus9		:Image;
		private var saavutus9Saatu	:Boolean = false;
		
		private var kauppaContainer:Sprite;
		
		private var kauppaVL:Button;
		private var saavutusVL:Button;
		
		private var gameScore:TextField 	= new TextField( 285, 25,pisteText,"embedFont",22,0xFFFFFF,false)
		private var timePlayedTxt:TextField = new TextField( 200, 25,"","embedFont",22,0xFFFFFF,false);
		private var saavutusInfo:TextField	= new TextField( 412, 105,saavutusText,"embedFont",13,0x000000,false);
		
		private var pisteText:String 	= "Kierrätys-pisteet: ";
		private var aikaText:String		= "Aika: ";
		private var saavutusText:String = "========================\nTervetuloa saavutus valikkoon.\n========================";
		
		private var kauppaBtn:Button;
		private var saavutusBtn:Button;
		private var ruksi:Button;
		
		private var kauppaAvausNopeus:int 	= 10;
		private var hihnaAnimSpeed:int 		= 25;
		private var hihnaMaara:int 			= 4;
		private var gTick:int 				= 0;
		private var score:int				= 1500;
		private var ScoreMultiplier:int 	= 0;
		
		private var gameStartTime:uint;
		private var gameTime:uint;
		
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
			kt1				= new Button(Assets.getAtlas().getTexture("kauppa_1"));
			kt2 			= new Button(Assets.getAtlas().getTexture("kauppa_2"));
			kt3 			= new Button(Assets.getAtlas().getTexture("kauppa_3"));
			kt4				= new Button(Assets.getAtlas().getTexture("kauppa_4"));
			kt5 			= new Button(Assets.getAtlas().getTexture("kauppa_5"));
			kt6 			= new Button(Assets.getAtlas().getTexture("kauppa_6"));
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
			
			gameScore.x = 5;	gameScore.y = 5;	gameScore.hAlign = HAlign.LEFT;
			timePlayedTxt.x = gameScore.x + gameScore.width + 5;
			timePlayedTxt.y = gameScore.y;	timePlayedTxt.hAlign = HAlign.LEFT;
			
			kone.x = -155;		kone.y = 30;		kone.scaleY = 1.2;
			
			this.addChild(bg1);
			createHihna();
			this.addChild(kauppaBtn);
			this.addChild(saavutusBtn);
			this.addChild(kone);
			this.addChild(gameScore);
			this.addChild(timePlayedTxt);
			
			this.addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
//GAME TICK (toiminnot jotka toteutuu / tarkistetaan joka framella).
		
		private function gameTick(event:Event):void
		{
			gTick++
			
		//uptading textfields
			gameScore.text = pisteText + score;
				//counts raw time 
				gameTime = getTimer()-gameStartTime;
				timePlayedTxt.text = aikaText + clockTime(gameTime);
			
			if(gTick == 1000)
				gTick = 0;
		}
		
		public function clockTime(rawGameTime:int):String	//Ajan laskenta alkaa kun initialize toiminto kutsutaan.
		{
			var sekunnit:int = Math.floor(rawGameTime/1000);
			var minuutit:int = Math.floor(sekunnit/60);
			sekunnit -= minuutit*60;
			var oikeaAika:String = minuutit+":"+String(sekunnit+100).substr(1,2);
			return oikeaAika;
		}
		
//BUTTONS
		
		private function onButtonClick(event:Event):void
		{
			var buttonC:Button = event.target as Button
				
			if((buttonC as Button) == kauppaBtn)
				if(kauppaPainettu == false)
					if(saavutusPainettu == false)
					{
						kauppaPainettu 		= true;
						saavutusPainettu 	= true;
						openShop();
					}
			
			if((buttonC as Button) == saavutusBtn)
				if(saavutusPainettu == false)
					if(kauppaPainettu == false)
					{
						saavutusPainettu 	= true;
						kauppaPainettu 		= true;
						openSaavutus();
					}
			
			if((buttonC as Button) == ruksi)
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
		//loop tälle?
							
			if((buttonC as Button) == kt1)
				if(kt1Ostettu == false)
					if(score >= kt1Hinta)
					{
						score -= kt1Hinta;
						kt1.alpha = .5;
						kt1Ostettu = true
					}
			if((buttonC as Button) == kt2)
				if(kt2Ostettu == false)
					if(score >= kt2Hinta)
					{
						score -= kt2Hinta;
						kt2.alpha = .5;
						kt2Ostettu = true
					}
			if((buttonC as Button) == kt3)
				if(kt3Ostettu == false)
					if(score >= kt3Hinta)
					{
						score -= kt3Hinta;
						kt3.alpha = .5;
						kt3Ostettu = true
					}
			if((buttonC as Button) == kt4)
				if(kt4Ostettu == false)
					if(score >= kt4Hinta)
					{
						score -= kt4Hinta;
						kt4.alpha = .5;
						kt4Ostettu = true
					}
			if((buttonC as Button) == kt5)
				if(kt5Ostettu == false)
					if(score >= kt5Hinta)
					{
						score -= kt5Hinta;
						kt5.alpha = .5;
						kt5Ostettu = true
					}
			if((buttonC as Button) == kt6)
				if(kt6Ostettu == false)
					if(score >= kt6Hinta)
					{
						score -= kt6Hinta;
						kt6.alpha = .5;
						kt6Ostettu = true
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
			this.addChild(kt1);	this.addChild(kt2);
			this.addChild(kt3);	this.addChild(kt4);
			this.addChild(kt5);	this.addChild(kt6);
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
	//Tämä toiminto uudistaa kaupan kuvakkeiden sijainnin
		private function kauppaKuvakeLiike():void
		{
			kt1.x = kauppaBg.x + 30;
			kt2.x = kt1.x + kt1.width + 49;
			kt3.x = kt2.x + kt2.width + 34;
			kt4.x = kt1.x;
			kt5.x = kt2.x;
			kt6.x = kt3.x;
			
			kt1.y = kauppaBg.y + 45;	
			kt2.y = kt1.y
			kt3.y = kt1.y;
			kt4.y = kauppaBg.y + kt1.height + 45 + 26;
			kt5.y = kt4.y;	
			kt6.y = kt4.y;
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
			saavutusTarkistus();
		}
		
		private function saavutusLiike(event:Event):void
		{
			if(saavutusBg.y > stage.stageHeight * 0.5 - saavutusBg.height * 0.5)
				saavutusBg.y -= kauppaAvausNopeus;
			else
			{
				saavutusAuki = true;
				kauppaPainettu = true;
				saavutusPainettu = false;
				this.removeChild(saavutusBtn);
				this.removeChild(kauppaBtn);
				this.removeEventListener(Event.ENTER_FRAME, saavutusLiike);
				this.addEventListener(TouchEvent.TOUCH, saavutusMouse);
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
				kauppaPainettu = false;
				saavutusPainettu = false;
				saavutusAuki = false;
				this.removeEventListener(Event.ENTER_FRAME, suljeSaavutus);
				this.removeEventListener(TouchEvent.TOUCH, saavutusMouse);
			}
			saavutusKuvakeLiike()
			kauppaBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha += .05;
			kauppaBtn.alpha += .05;
		}
	//saavutus mouse over info
		private function saavutusMouse(event:TouchEvent):void
		{
			var saavutus = event.target;
			if (event.getTouch(this, TouchPhase.HOVER))
			{
				if(saavutus == saavutus1)
					saavutusInfo.text = "========================\nOsta ensimmäinen laajennus\n========================";
				else if(saavutus == saavutus2)
					saavutusInfo.text = "========================\nOsta toinen laajennus\n========================";
				else if(saavutus == saavutus3)
					saavutusInfo.text = "========================\nOsta kolmas laajennus\n========================";
				else if(saavutus == saavutus4)
					saavutusInfo.text = "========================\nOsta ensimmäinen työntekijä\n========================";
				else if(saavutus == saavutus5)
					saavutusInfo.text = "========================\nAnsaitse 100 rahaa\n========================";
				else if(saavutus == saavutus6)
					saavutusInfo.text = "========================\nAnsaitse 500 rahaa\n========================";
				else if(saavutus == saavutus7)
					saavutusInfo.text = "========================\nAnsaitse 1000 rahaa\n========================";
				else if(saavutus == saavutus8)
					saavutusInfo.text = "========================\nAnsaitse 2000 rahaa\n========================";
				else if(saavutus == saavutus9)
					saavutusInfo.text = "========================\nOsta toinen työntekijä\n========================";
				else
					saavutusInfo.text = saavutusText;
			}
		}
		
	//onko saavutus saatu  SAAVUTUKSET 1 - 3 MÄÄRITELLÄÄN TAVARAN OSTON YHTEYDESSÄ 
		
		private function saavutusTarkistus():void
		{
			if(saavutus1Saatu == false)
				saavutus1.alpha = .2;
			else if(saavutus1Saatu == true)
				saavutus1.alpha = 1;
			
			if(saavutus2Saatu == false)
				saavutus2.alpha = .2;
			else if(saavutus2Saatu == true)
				saavutus2.alpha = 1;
			
			if(saavutus3Saatu == false)
				saavutus3.alpha = .2;
			else if(saavutus3Saatu == true)
				saavutus3.alpha = 1;
			
			if(saavutus4Saatu == false)
				saavutus4.alpha = .2;
			else if(saavutus4Saatu == true)
				saavutus4.alpha = 1;
			
			 if(saavutus5Saatu == false)
			 {
				 saavutus5.alpha = .2;
				 if(score >= 100)
				 {
					 saavutus5Saatu = true;
					 saavutus5.alpha = 1;
				 }
			 }
			 if(saavutus6Saatu == false)
			 {
				 saavutus6.alpha = .2;
				 if(score >= 500)
				 {
					 saavutus6Saatu = true;
					 saavutus6.alpha = 1;
				 }
			 }
			 if(saavutus7Saatu == false)
			 {
				 saavutus7.alpha = .2;
				 if(score >= 1000)
				 {
					 saavutus7Saatu = true;
					 saavutus7.alpha = 1;
				 }
			 }
			 if(saavutus8Saatu == false)
			 {
				 saavutus8.alpha = .2;
				 if(score >= 2000)
				 {
					 saavutus8Saatu = true;
					 saavutus8.alpha = 1;
				 }
			 }
			 if(saavutus9Saatu == false)
				 saavutus9.alpha = .2;
			 else if(saavutus9Saatu == true)
				 saavutus9.alpha = 1;
		}
		
	//Tämä toiminto uudistaa saavutusten kuvakkeiden sijainnin
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
			for(var i:int = 0; i < hihnaMaara;i++)
			{
				var h:hihna = new hihna(hihnaAnimSpeed);
				h.x = i * 118;
				h.y = (stage.stageHeight * 0.45);
				this.addChild(h)
			}
		}
		
//MUUT
		
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}
		
		public function initialize():void
		{
			this.addEventListener(Event.ENTER_FRAME, gameTick)
			gameStartTime = getTimer();
			gameTime = 0;
		}
		
		public function disposeTemp():void
		{
			this.removeEventListener(Event.ENTER_FRAME, gameTick)
		}
	}
}