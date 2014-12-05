package screens
{
	import events.GiveScore;
	import events.NavigationEvent;
	
	import flash.display.SpreadMethod;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import objects.Item;
	import objects.Roskakorit;
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
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.deg2rad;

	/*
		Tässä luokassa luodaan: Peli
	*/
	public class GameMain extends Sprite
	{
/*=====================================================================================================================*/
	//"isot" kuvat
		private var bg1:Image;
		private var kauppaBg:Image;
		private var saavutusBg:Image;
		private var kone:Image;
		public  var kori:Image;
	//muuttujia kaupa/saavutusten toimintoihin
		private var kauppaAuki:Boolean 			= false;	
		private var kauppaPainettu:Boolean 		= false;
		private var saavutusAuki:Boolean		= false;	
		private var saavutusPainettu:Boolean	= false;
	//muuttujat "tasoille" (näihin asiat lisätään jotta ne pysyy oikeassa "syvyydessä")
		private var bgLayer:Sprite = new Sprite();
		private var hihnaLayer:Sprite = new Sprite();
		private var itemLayer:Sprite = new Sprite();
		private var scoreLayer:Sprite = new Sprite();
	//Kaupan muuttujat (kt = lyhenne kaupan tavaroille)
	//Tässä teidot kaupan: Painikkeelle, Hinnalle, onko tavara ostettu.
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
		private var kt6Hinta	:int = 1000;
		private var kt6Ostettu	:Boolean = false;
		
		private var kt7			:Button;
		private var kt7Hinta	:int = 1000;
		private var kt7Ostettu	:Boolean = false;
		
		private var kt8			:Button;
		private var kt8Hinta	:int = 1000;
		private var kt8Ostettu	:Boolean = false;
		
		private var kt9			:Button;
		private var kt9Hinta	:int = 1000;
		private var kt9Ostettu	:Boolean = false;
	//Saavutusten tiedot
	//Tässä saavutusten tiedot: kuva, onko saavutus saaatu
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
	//Roskakorien muuttujat
		private var kori1:int = Math.round(Math.random()*5) + 1;
		private var kori2:int = Math.round(Math.random()*5) + 1;
		private var kori3:int = Math.round(Math.random()*5) + 1;
		private var kori4:int = Math.round(Math.random()*5) + 1;
		private var kori5:int = Math.round(Math.random()*5) + 1;
		private var kori6:int = Math.round(Math.random()*5) + 1;
	//kauppa / saavutus välilehti painikkeet
		private var kauppaVL:Button 		= new Button(Assets.getAtlas().getTexture("playBtn"));
		private var saavutusVL:Button 		= new Button(Assets.getAtlas().getTexture("playBtn"));
	//teksti kentät
		private var gameScore:TextField 	= new TextField( 185, 110,pisteText,"embedFont",22,0xFFFFFF,false)
		private var timePlayedTxt:TextField = new TextField( 200, 25,"","embedFont",22,0xFFFFFF,false);
		private var saavutusInfo:TextField	= new TextField( 412, 105,saavutusText,"embedFont",13,0x000000,false);
		private var kauppaInfo:TextField	= new TextField( 412, 105,kauppaText,"embedFont",13,0x000000,false); 
	//valmiita tekstejä
		private var pisteText:String 	= "Pisteet: ";
		private var aikaText:String		= "Aika: ";
		private var viiva:String		= "========================"
		private var saavutusText:String = viiva + "\nTervetuloa saavutus valikkoon.\n" + viiva;
		private var kauppaText:String	= viiva + "\nTervetuloa kauppaan\n" + viiva;
	//painikkeet
		private var kauppaBtn:Button;
		private var saavutusBtn:Button;
		private var ruksi:Button;
	//Satunnaisia numeroita eri asioiden säätämiseen
		private var kauppaAvausNopeus:int 	= 10;
		private var hihnaAnimSpeed:int 		= 40;
		private var hihnaMaara:int 			= 4;
		private var gTick:int 				= 0;
		private var score:int				= 0;
		private var binAmmount:int			= 4;
	//pisteen laskennan muuttujat ( score = scoreBasic x scoreMultiplier ).
		private var scoreBasic:int			= 10;
		private var scoreMultiplier:int		= 1;
	//hiiren sijainti (kehitystä varten voi postaa valmiissa versiossa mouseListener() kanssa)
		private var mouseX:int;
		private var mouseY:int;
	//ajan laskennan muuttujat
		private var gameStartTime:uint;
		private var gameTime:uint;
	//tavaroiden säilytys
		private var itemVector:Vector.<Item>;
/*=====================================================================================================================*/
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
			kori		= new Image(Assets.getAtlas().getTexture("hihnaKori"));
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
			timePlayedTxt.x = stage.stageWidth * .5 - 50;
			timePlayedTxt.y = gameScore.y;	timePlayedTxt.hAlign = HAlign.LEFT;
			
			kone.x = -180;		kone.y = 30;		kone.scaleY = 1.2;
			
			createBg();
			createHihna();
			
			this.addChild(bgLayer);
			this.addChild(hihnaLayer);
			this.addChild(itemLayer);
			this.addChild(kone);
			this.addChild(scoreLayer);
			this.addChild(kauppaBtn);
			this.addChild(saavutusBtn);
			this.addChild(gameScore);
			this.addChild(timePlayedTxt);
			
			this.addEventListener(events.GiveScore.GIVE_SCORE, scoreGive)
			this.addEventListener(Event.TRIGGERED, onButtonClick);
			
			createKorit()
		}
	//luo taustan [TODO tee toiminto joka muuttaa taustan teeman mukaan/lisää oikeat asiat]
		private function createBg():void
		{
			
			kori.x = 485;
			kori.y = stage.stageHeight * 0.5 + 30;
			kori.scaleX = 1.5; kori.scaleY = 1.5;
			bgLayer.addChild(bg1)
			bgLayer.addChild(kori)
		}
		
//GAME TICK (toiminnot jotka toteutuu / tarkistetaan joka framella).
		
		private function gameTick(event:Event):void
		{
			gTick++
		//päivittää tekstikentät
			gameScore.text = pisteText + score+ "\nMouse x: "+mouseX+"\nMouse y: "+mouseY+"\nItems: " + itemVector.length;//+ "\nMouse x: "+mouseX+"\nMouse y: "+mouseY+"\nItems: " + itemVector.length
			gameTime = getTimer()-gameStartTime;
			timePlayedTxt.text = aikaText + clockTime(gameTime);
			if(gTick % 25 == 0)
			{
				saavutusTarkistus();
			}
			
			if(gTick >= 1000)
			{
				gTick = 0;
			}
			//tavaran luomti ja liikuttaminen
			createItem();
			moveItems();
		}
	//Ajan laskenta alkaa kun initialize toiminto kutsutaan.
		public function clockTime(rawGameTime:int):String
		{
			var sekunnit:int = Math.floor(rawGameTime/1000);
			var minuutit:int = Math.floor(sekunnit/60);
			sekunnit -= minuutit*60;
			var oikeaAika:String = minuutit+":"+String(sekunnit+100).substr(1,2);
			return oikeaAika;
		}
	//Tavaran luominen
		private function createItem():void
		{
			if(gTick > 70 + Math.ceil(Math.random() * 30))
			{
				var newItem:Item = new Item(Math.ceil(Math.random() * 2), kori1, kori2, kori3, kori4, kori5, kori6);
				itemLayer.addChild(newItem);
				itemVector.push(newItem);
				gTick = 0;
			}
		}
		
		private function moveItems():void
		{
			var currentItem:Item;
			
			for(var i:uint; i < itemVector.length; i++)
			{
				var itemContainer:Sprite = new Sprite();
				currentItem = itemVector[i];
			}
		}
	//roskakorien luonti
		private function createKorit():void
		{
			
			for(var a:int = 0; a < 20;a++)
			{
				if(kori2 == kori1)
					kori2 = Math.round(Math.random()*5) + 1;
				if(kori3 == kori1 || kori3 == kori2)
					kori3 = Math.round(Math.random()*5) + 1;
				if(kori4 == kori1 || kori4 == kori2 || kori4 == kori3)
					kori4 = Math.round(Math.random()*5) + 1;
				if(kori5 == kori1 || kori5 == kori2 || kori5 == kori3 || kori5 == kori4 )
					kori5 = Math.round(Math.random()*5) + 1;
				if(kori6 == kori1 || kori6 == kori2 || kori6 == kori3 || kori6 == kori4  || kori6 == kori5)
					kori6 = Math.round(Math.random()*5) + 1;
			}
			
			//var koriText:TextField = new TextField(200,400,"k1: "+kori1+"\nk2: "+kori2+"\nk3: "+kori3+"\nk4: "+kori4+"\nk5: "+kori5+"\nk6: "+kori6+"","embedFont",20,0xFFFFFF);
			//this.addChild(koriText);
			var korit:Roskakorit = new Roskakorit(binAmmount, kori1, kori2, kori3,kori4);
			hihnaLayer.addChild(korit);
		}
	//Tavaroiden pisteiden anto (onko tavara lajiteltu oikein/väärin)
		private function scoreGive(event:GiveScore):void
		{
			switch(event.params.id)
			{
				case "plus":
					score += scoreBasic * scoreMultiplier;
					var scoreFinal1:int = scoreBasic * scoreMultiplier;
					createScoreText(scoreFinal1)
					break;
				case "minus":
					score -= scoreBasic * scoreMultiplier * 0.5;
					var scoreFinal2:int = -scoreBasic * scoreMultiplier * 0.5;
					createScoreText(scoreFinal2)
					break;
			}
		}
	//Luo tekstin joka näyttää saatujen pisteiden määrän tavaran lajittelun yhteydessä
		private function createScoreText(scoreFinal:int):void
		{
			var sTxt:TextField = new TextField(80,25," ","embedFont",24,0x0,true);
			sTxt.hAlign = HAlign.LEFT;
			sTxt.x = gameScore.x + gameScore.width;
			sTxt.y = gameScore.y;
			sTxt.touchable = false;
		//Jos numero on positiivinen se on vihreä ja punainen jos se on negatiivinen
			if(scoreFinal > 0){
				sTxt.color = 0x4CFF37;
				sTxt.text = "+" + scoreFinal;
			}else if(scoreFinal < 0){
				sTxt.color = 0xFF0000;
				sTxt.text = String(scoreFinal);
			}
			sTxt.addEventListener(Event.ENTER_FRAME, sTxtMovement)
			scoreLayer.addChild(sTxt);
		}
	//Liikutta ylemmän toiminnon tekstikenttää ja poistaa sen
		private function sTxtMovement(event:Event):void
		{
			var o:Object = event.currentTarget
				o.y -= 0.5
				o.alpha -= .01
				if(o.alpha == 0)
				{
					removeChild(o as TextField);
					removeEventListener(Event.ENTER_FRAME, sTxtMovement)
				}
					
		}
//BUTTONS
		private function onButtonClick(event:Event):void
		{
			var buttonC:Button = event.target as Button
		//"Kauppa" painikkeen painaminen
			if((buttonC as Button) == kauppaBtn)
				if(kauppaPainettu == false)
					if(saavutusPainettu == false)
					{
						kauppaPainettu 		= true;
						saavutusPainettu 	= true;
						openShop();
					}
		//"Saavutus" painikkeen painaminen
			if((buttonC as Button) == saavutusBtn)
				if(saavutusPainettu == false)
					if(kauppaPainettu == false)
					{
						saavutusPainettu 	= true;
						kauppaPainettu 		= true;
						openSaavutus();
					}
		//"Ruksi" painikkeen painaminen
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
		//Kaupan painikkeet				
			if((buttonC as Button) == kt1)
				if(kt1Ostettu == false)
					if(score >= kt1Hinta)
					{
						score -= kt1Hinta;
						kt1.alpha = .5;
						kt1Ostettu = true
						//kaupan painike1 tapahtuma
						
					}
			if((buttonC as Button) == kt2)
				if(kt2Ostettu == false)
					if(score >= kt2Hinta)
					{
						score -= kt2Hinta;
						kt2.alpha = .5;
						kt2Ostettu = true
						//kaupan painike2 tapahtuma
						
					}
			if((buttonC as Button) == kt3)
				if(kt3Ostettu == false)
					if(score >= kt3Hinta)
					{
						score -= kt3Hinta;
						kt3.alpha = .5;
						kt3Ostettu = true
						//kaupan painike3 tapahtuma
						
					}
			if((buttonC as Button) == kt4)
				if(kt4Ostettu == false)
					if(score >= kt4Hinta)
					{
						score -= kt4Hinta;
						kt4.alpha = .5;
						kt4Ostettu = true
						//kaupan painike4 tapahtuma
						
					}
			if((buttonC as Button) == kt5)
				if(kt5Ostettu == false)
					if(score >= kt5Hinta)
					{
						score -= kt5Hinta;
						kt5.alpha = .5;
						kt5Ostettu = true
						//kaupan painike5 tapahtuma
						
					}
			if((buttonC as Button) == kt6)
				if(kt6Ostettu == false)
					if(score >= kt6Hinta)
					{
						score -= kt6Hinta;
						kt6.alpha = .5;
						kt6Ostettu = true
						//kaupan painike6 tapahtuma
						
					}
			if((buttonC as Button) == kt7)
				if(kt7Ostettu == false)
					if(score >= kt7Hinta)
					{
						score -= kt7Hinta;
						kt7.alpha = .5;
						kt7Ostettu = true
						//kaupan painike7 tapahtuma
						
					}
			if((buttonC as Button) == kt8)
				if(kt8Ostettu == false)
					if(score >= kt8Hinta)
					{
						score -= kt8Hinta;
						kt8.alpha = .5;
						kt8Ostettu = true
						//kaupan painike8 tapahtuma
						
					}
			if((buttonC as Button) == kt9)
				if(kt9Ostettu == false)
					if(score >= kt9Hinta)
					{
						score -= kt6Hinta;
						kt9.alpha = .5;
						kt9Ostettu = true
						//kaupan painike9 tapahtuma
							
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
					kauppaInfo.text = viiva + "\nTavara\nHinta: " +kt1Hinta + "\n" + viiva;
				else if(kt == kt2)
					kauppaInfo.text = viiva + "\nTavara\nHinta: " +kt2Hinta + "\n"+ viiva;
				else if(kt == kt3)
					kauppaInfo.text = viiva + "\nTavara\nHinta: "+kt3Hinta + "\n" + viiva;
				else if(kt == kt4)
					kauppaInfo.text = viiva + "\nTavara\nHinta: "+kt4Hinta + "\n" + viiva;
				else if(kt == kt5)
					kauppaInfo.text = viiva + "\nTavara\nHinta: " +kt5Hinta + "\n"+ viiva;
				else if(kt == kt6)
					kauppaInfo.text = viiva + "\nTavara\nHinta: " +kt6Hinta + "\n"+ viiva;
				else if(kt == kt7)
					kauppaInfo.text = viiva + "\nTavara\nHinta: " +kt7Hinta + "\n"+ viiva;
				else if(kt == kt8)
					kauppaInfo.text = viiva + "\nTavara\nHinta: "+kt8Hinta + "\n" + viiva;
				else if(kt == kt9)
					kauppaInfo.text = viiva + "\nTavara\nHinta: " +kt9Hinta + "\n"+ viiva;
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
				
				hihnaLayer.addChild(s);
				if(i == o)
				{
					o += 2;
					var j:Image = new Image(Assets.getAtlas().getTexture("jalat"));
					j.x = h.x
					j.y = h.y + 78;
					hihnaLayer.addChild(j);
				}
				hihnaLayer.addChild(h);
			}
			hihnaLayer.addChild(hp)
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