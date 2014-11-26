package screens
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import objects.Item;
	import objects.hihna;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.deg2rad;

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
	//kt on lyhenne kauppaan liittyville asioille.
		private var kt1			:Button;
		private var kt1Hinta	:int = 100;
		private var kt1Ostettu	:Boolean = false;
			
		private var kt2			:Button;
		private var kt2Hinta	:int = 300;
		private var kt2Ostettu	:Boolean = false;
			
		private var kt3			:Button;
		private var kt3Hinta	:int = 600;
		private var kt3Ostettu	:Boolean = false;
			
		private var kt4			:Button;
		private var kt4Hinta	:int = 800;
		private var kt4Ostettu	:Boolean = false;
			
		private var kt5			:Button;
		private var kt5Hinta	:int = 900;
		private var kt5Ostettu	:Boolean = false;
			
		private var kt6			:Button;
		private var kt6Hinta	:int = 190;
		private var kt6Ostettu	:Boolean = false;
		
		private var kt7			:Button;
		private var kt7Hinta	:int = 190;
		private var kt7Ostettu	:Boolean = false;
		
		private var kt8			:Button;
		private var kt8Hinta	:int = 190;
		private var kt8Ostettu	:Boolean = false;
		
		private var kt9			:Button;
		private var kt9Hinta	:int = 190;
		private var kt9Ostettu	:Boolean = false;
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
		
		private var kauppaVL:Button 		= new Button(Assets.getAtlas().getTexture("playBtn"));
		private var saavutusVL:Button 		= new Button(Assets.getAtlas().getTexture("playBtn"));
		
		private var gameScore:TextField 	= new TextField( 285, 100,pisteText,"embedFont",22,0xFFFFFF,false)
		private var timePlayedTxt:TextField = new TextField( 200, 25,"","embedFont",22,0xFFFFFF,false);
		private var saavutusInfo:TextField	= new TextField( 412, 105,saavutusText,"embedFont",13,0x000000,false);
		private var kauppaInfo:TextField	= new TextField( 412, 105,kauppaText,"embedFont",13,0x000000,false); 
		
		private var pisteText:String 	= "Pisteet: ";
		private var aikaText:String		= "Aika: ";
		private var viiva:String		= "========================"
		private var saavutusText:String = viiva + "\nTervetuloa saavutus valikkoon.\n" + viiva;
		private var kauppaText:String	= viiva + "\nTervetuloa kauppaan\n" + viiva;
		
		private var kauppaBtn:Button;
		private var saavutusBtn:Button;
		private var ruksi:Button;
		
		private var kauppaAvausNopeus:int 	= 10;
		private var hihnaAnimSpeed:int 		= 25;
		private var hihnaMaara:int 			= 4;
		private var gTick:int 				= 0;
		private var score:int				= 9522355;
		
		private var mouseX:int;
		private var mouseY:int;
		
		private var gameStartTime:uint;
		private var gameTime:uint;
		
		private var itemVector:Vector.<Item>;
		
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
			bg1 		= new Image(Assets.getTextures("tausta3"));
			kauppaBg 	= new Image(Assets.getTextures("kaupanPohjaKuva"));
			saavutusBg 	= new Image(Assets.getTextures("saavutustenPohjaKuva"));
			kauppaBtn 	= new Button(Assets.getAtlas().getTexture("kauppaKuvake"));
			saavutusBtn = new Button(Assets.getAtlas().getTexture("saavutus"));
			kone 		= new Image(Assets.getTextures("kone"));
			ruksi 		= new Button(Assets.getAtlas().getTexture("symbolX"));
			kt1			= new Button(Assets.getAtlas().getTexture("kauppa_1"));
			kt2 		= new Button(Assets.getAtlas().getTexture("kauppa_2"));
			kt3 		= new Button(Assets.getAtlas().getTexture("kauppa_3"));
			kt4			= new Button(Assets.getAtlas().getTexture("kauppa_4"));
			kt5 		= new Button(Assets.getAtlas().getTexture("kauppa_5"));
			kt6 		= new Button(Assets.getAtlas().getTexture("kauppa_6"));
			kt7			= new Button(Assets.getAtlas().getTexture("kauppa_7"));
			kt8 		= new Button(Assets.getAtlas().getTexture("kauppa_8"));
			kt9 		= new Button(Assets.getAtlas().getTexture("kauppa_9"));
			saavutus1 	= new Image(Assets.getAtlas().getTexture("saavutus1"));
			saavutus2 	= new Image(Assets.getAtlas().getTexture("saavutus2"));
			saavutus3 	= new Image(Assets.getAtlas().getTexture("saavutus3"));
			saavutus4 	= new Image(Assets.getAtlas().getTexture("saavutus4"));
			saavutus5 	= new Image(Assets.getAtlas().getTexture("saavutus5"));
			saavutus6	= new Image(Assets.getAtlas().getTexture("saavutus6"));
			saavutus7 	= new Image(Assets.getAtlas().getTexture("saavutus7"));
			saavutus8 	= new Image(Assets.getAtlas().getTexture("saavutus8"));
			saavutus9 	= new Image(Assets.getAtlas().getTexture("saavutus9"));
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
			gameScore.text = pisteText + score + "\nmouse x: "+mouseX+"\nmouse y: "+mouseY/*pisteText + score*/;
				//counts raw time 
				gameTime = getTimer()-gameStartTime;
			timePlayedTxt.text = aikaText + clockTime(gameTime);
			if(gTick % 25 == 0)
			{
				score += 10
				saavutusTarkistus();
			}
			
			if(gTick >= 1000)
			{
				gTick = 0;
			}
			//this is the function that makes items move
			createItem();
			moveItems();
		}
		
		public function clockTime(rawGameTime:int):String	//Ajan laskenta alkaa kun initialize toiminto kutsutaan.
		{
			var sekunnit:int = Math.floor(rawGameTime/1000);
			var minuutit:int = Math.floor(sekunnit/60);
			sekunnit -= minuutit*60;
			var oikeaAika:String = minuutit+":"+String(sekunnit+100).substr(1,2);
			return oikeaAika;
		}
		
		private function createItem():void
		{
			if(gTick > 200)
			{
				var newItem:Item = new Item(Math.ceil(Math.random() * 2));
				this.addChild(newItem);
				itemVector.push(newItem);
				gTick = 0;
			}
			
		}
		
		private function moveItems():void
		{
			var currentItem:Item;
			
			for(var i:uint; i < itemVector.length; i++)
			{
				currentItem = itemVector[i];
				currentItem.addEventListener(TouchEvent.TOUCH, itemMove);
				currentItem.x = 0
			}
		}
		
		private function itemMove(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var position:Point = touch.getLocation(stage);
			var o:Object = event.target
			if (event.getTouch(this, TouchPhase.MOVED))
			{
				o.x = mouseX - o.width * 0.5;
				o.y = mouseY - o.height * 0.5;
			}
			if (event.getTouch(this, TouchPhase.BEGAN))
			{
				o.x = mouseX - 38.5;
				o.y = mouseY - 38.5;
			}
			if (event.getTouch(this, TouchPhase.STATIONARY))
			{
				o.x = mouseX - 38.5;
				o.y = mouseY - 38.5;
			}
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
			if((buttonC as Button) == kt7)
				if(kt7Ostettu == false)
					if(score >= kt7Hinta)
					{
						score -= kt7Hinta;
						kt7.alpha = .5;
						kt7Ostettu = true
					}
			if((buttonC as Button) == kt8)
				if(kt8Ostettu == false)
					if(score >= kt8Hinta)
					{
						score -= kt8Hinta;
						kt8.alpha = .5;
						kt8Ostettu = true
					}
			if((buttonC as Button) == kt9)
				if(kt9Ostettu == false)
					if(score >= kt9Hinta)
					{
						score -= kt6Hinta;
						kt9.alpha = .5;
						kt9Ostettu = true
					}
		}
		
/*	=============-KAUPAN TOIMINNOT ALKAA-=============
	openShop() 			- lisää kuvakkeet ja siirtyy seuraavaan toimintoon
	kauppaLiike(event)	- liikuttaa ikkunan alhaalta ylös
	kauppaAvausLopetus()- toiminnot mitä tapahtuu kun ikkuna on oikeassa sijainnissa 
	kauppaMouse(event)	- seuraa hiiren sijaintia
	suljeKauppa(event)	- liikuttaa ikkunan ylhäältä alas
	kauppaSulkemisLopetus()- toiminnot mitä tapahtuu kun ikkuna on oikeassa sijainnissa
	kauppaKuvaLiike() 	- laskee kuvakkeiden uudestaan					
	==================================================*/
		
		private function openShop():void
		{
			if(saavutusAuki == false)
			{
				kauppaBg.y = stage.stageHeight;
				this.addEventListener(Event.ENTER_FRAME, kauppaLiike);
			}
			else
				kauppaBg.y = stage.stageHeight * 0.5 - kauppaBg.height * 0.5
			
			this.addChild(kauppaBg);
			ruksi.x = kauppaBg.x + kauppaBg.width - ruksi.width * 0.5;
			this.addChild(kt1);	this.addChild(kt2);
			this.addChild(kt3);	this.addChild(kt4);
			this.addChild(kt5);	this.addChild(kt6);
			this.addChild(kt7); this.addChild(kt8);
			this.addChild(kt9);	this.addChild(ruksi);
			this.addChild(kauppaVL);	this.addChild(saavutusVL);
			this.addChild(kauppaInfo);
			kauppaKuvakeLiike();
			kauppaVL.width = 175;	kauppaVL.height = 25;	kauppaVL.alpha = 0;
			saavutusVL.width = 175; saavutusVL.height = 25;	saavutusVL.alpha = 0;
		}
	
		private function kauppaLiike(event:Event):void
		{
			if(kauppaBg.y > stage.stageHeight * 0.5 - kauppaBg.height * 0.5)
				kauppaBg.y -= kauppaAvausNopeus;
			else
				kauppaAvausLopetus();
			
			kauppaKuvakeLiike();
			ruksi.y = kauppaBg.y + 10;
			kauppaBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha -= .05;
			kauppaBtn.alpha -= .05;
		}
		
		private function kauppaAvausLopetus():void
		{
			kauppaAuki = true;
			this.removeChild(saavutusBtn);
			this.removeChild(kauppaBtn);
			this.removeEventListener(Event.ENTER_FRAME, kauppaLiike);
			this.addEventListener(TouchEvent.TOUCH, kauppaMouse);
		}
		
		private function kauppaMouse(event:TouchEvent):void
		{
			var kt:Object = event.target;
			if (event.getTouch(this, TouchPhase.HOVER))
			{
				if(kt == kt1)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt2)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt3)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt4)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt5)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt6)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt7)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt8)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kt9)
					kauppaInfo.text = viiva + "\nTavara\n" + viiva;
				else if(kt == kauppaVL)
					kauppaInfo.text = viiva + "\nVaihda kauppaan\n" + viiva;
				else if(kt == saavutusVL)
					kauppaInfo.text = viiva + "\nVaihda saavutuksiin\n" + viiva;
				else
					kauppaInfo.text = kauppaText;
			}
		}
		
		private function suljeKauppa(event:Event):void
		{
			if(kauppaBg.y < stage.stageHeight)
				kauppaBg.y += kauppaAvausNopeus;
			else
				kauppaSulkemisLopetus()
			
			kauppaKuvakeLiike();
			kauppaBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha += .05;
			kauppaBtn.alpha += .05;
		}
		
		private function kauppaSulkemisLopetus():void
		{
			kauppaAuki = false;
			kauppaPainettu = false;
			saavutusPainettu = false;
			kauppaBtn.x = stage.stageWidth - kauppaBtn.width * 1.2;
			saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
			this.removeEventListener(TouchEvent.TOUCH, kauppaMouse);
			this.removeEventListener(Event.ENTER_FRAME, suljeKauppa);
		}

		private function kauppaKuvakeLiike():void
		{
			kt1.x = kauppaBg.x + 16;		kt1.y = kauppaBg.y + 43;
			kt2.x = kt1.x + kt1.width + 56;	kt2.y = kt1.y;
			kt3.x = kt2.x + kt2.width + 56;	kt3.y = kt1.y;
			kt4.x = kt3.x + kt3.width + 53;	kt4.y = kt1.y;
			kt5.x = kt1.x;					kt5.y = kt1.y + kt1.width +23;
			kt6.x = kt2.x;					kt6.y = kt5.y;
			kt7.x = kt3.x;					kt7.y = kt5.y;
			kt8.x = kt4.x;					kt8.y = kt5.y;
			kt9.x = kt1.x;					kt9.y = kt5.y + kt5.height + 28;
			kauppaInfo.x = kt2.x;			kauppaInfo.y = kt9.y;
			kauppaVL.x = kauppaBg.x;		kauppaVL.y = kauppaBg.y;
			saavutusVL.x = kauppaVL.x + kauppaVL.width;
			saavutusVL.y = kauppaVL.y;
		}
		
/*	==========-SAAVUTUSTEN TOIMINNOT ALKAA-==========
	openSaavutus()			- lisää kuvakkeet ja siirtyy seuraavaan toimintoon
	saavutusLiike(event)	- liikuttaa ikkunan alhaalta ylös
	saavutusAvausLopetus()	- tapahtumat mitä tapahtuu kun ikkuna on oikeassa sijainnissa
	saavutusMouse(event)	- seuraa hiiren sijaintia
	suljeSaavutus(event)	- liikuttaa ikkunan ylhäältä alas
	saavutusSulkemisLopetus()- tapahtumat mitä tapahtuu kun ikkuna on oikeassa sijainnissa
	saavutusKuvaLiike() 	- laskee kuvakkeiden uudestaan
	saavutusTarkistus()		- tarkistaa onko jokin saavutus saatu
	==================================================*/
				
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
			saavutusKuvakeLiike();
		}
		
		private function saavutusLiike(event:Event):void
		{
			if(saavutusBg.y > stage.stageHeight * 0.5 - saavutusBg.height * 0.5)
				saavutusBg.y -= kauppaAvausNopeus;
			else
				saavutusAvausLopetus();
			
			saavutusKuvakeLiike()
			ruksi.y = saavutusBg.y + 10;
			kauppaBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.x += kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha -= .05;
			kauppaBtn.alpha -= .05;
		}
		
		private function saavutusAvausLopetus():void
		{
			saavutusAuki = true;
			kauppaPainettu = true;
			saavutusPainettu = false;
			this.removeChild(saavutusBtn);
			this.removeChild(kauppaBtn);
			this.removeEventListener(Event.ENTER_FRAME, saavutusLiike);
			this.addEventListener(TouchEvent.TOUCH, saavutusMouse);
		}
		
		private function suljeSaavutus(event:Event):void
		{
			if(saavutusBg.y < stage.stageHeight)
				saavutusBg.y += kauppaAvausNopeus;
			else
				saavutusSulkemisLopetus();
				
			saavutusKuvakeLiike()
			kauppaBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.x -= kauppaAvausNopeus * 0.1;
			saavutusBtn.alpha += .05;
			kauppaBtn.alpha += .05;
		}
		
		private function saavutusSulkemisLopetus():void
		{
			kauppaBtn.x = stage.stageWidth - kauppaBtn.width * 1.2;
			saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
			kauppaPainettu = false;
			saavutusPainettu = false;
			saavutusAuki = false;
			this.removeEventListener(Event.ENTER_FRAME, suljeSaavutus);
			this.removeEventListener(TouchEvent.TOUCH, saavutusMouse);
		}
		
		private function saavutusMouse(event:TouchEvent):void
		{
			var saavutus:Object = event.target;
			if (event.getTouch(this, TouchPhase.HOVER))
			{
				if(saavutus == saavutus1)
					saavutusInfo.text = viiva + "\nOsta ensimmäinen laajennus\n" + viiva;
				else if(saavutus == saavutus2)
					saavutusInfo.text = viiva + "\nOsta toinen laajennus\n" + viiva;
				else if(saavutus == saavutus3)
					saavutusInfo.text = viiva + "\nOsta kolmas laajennus\n" + viiva;
				else if(saavutus == saavutus4)
					saavutusInfo.text = viiva + "\nOsta ensimmäinen työntekijä\n" + viiva;
				else if(saavutus == saavutus5)
					saavutusInfo.text = viiva + "\nAnsaitse 100 rahaa\n" + viiva;
				else if(saavutus == saavutus6)
					saavutusInfo.text = viiva + "\nAnsaitse 500 rahaa\n" + viiva;
				else if(saavutus == saavutus7)
					saavutusInfo.text = viiva + "\nAnsaitse 1000 rahaa\n" + viiva;
				else if(saavutus == saavutus8)
					saavutusInfo.text = viiva + "\nAnsaitse 2000 rahaa\n" + viiva;
				else if(saavutus == saavutus9)
					saavutusInfo.text = viiva + "\nOsta toinen työntekijä\n" + viiva;
				else
					saavutusInfo.text = saavutusText;
			}
		}
		
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
		
//HIHNAN LUONTI [h = hihna, s = "varjo", j = jalat, o = määrittää jalkojen laiton]
		
		private function createHihna():void
		{
			var hp:Image = new Image(Assets.getAtlas().getTexture("hihnapaaty"))
			hp.scaleX = .8; hp.scaleY = hp.scaleX;
			var o:int = 1;
			for(var i:int = 0; i < hihnaMaara;i++)
			{
				var h:hihna = new hihna(hihnaAnimSpeed);
				var s:Quad = new Quad( 118, 60, 0x000000);
				s.alpha = .2;
				h.x = i * 118;
				s.x = h.x
				h.y = (stage.stageHeight * 0.45);
				s.y = h.y + 138;
				
				hp.x = h.x + 118;
				hp.y = h.y;
				
				this.addChild(s);
				if(i == o)
				{
					o += 2;
					var j:Image = new Image(Assets.getAtlas().getTexture("jalat"));
					j.x = h.x
					j.y = h.y + 78;
					this.addChild(j);
				}
				this.addChild(h);
			}
			this.addChild(hp)
		}
		
//MUUT
		private function mouseListener(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var position:Point = touch.getLocation(stage);
			if (event.getTouch(this, TouchPhase.HOVER))
			{
				mouseX = position.x
				mouseY = position.y
			}
			if (event.getTouch(this, TouchPhase.MOVED))
			{
				mouseX = position.x
				mouseY = position.y
			}
		}
		
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}
		
		public function initialize():void
		{
			this.addEventListener(Event.ENTER_FRAME, gameTick)
			this.addEventListener(TouchEvent.TOUCH, mouseListener);
			gameStartTime = getTimer();
			gameTime = 0;
			itemVector = new Vector.<Item>();
		}
		
		public function disposeTemp():void
		{
			this.removeEventListener(Event.ENTER_FRAME, gameTick)
		}
	}
}