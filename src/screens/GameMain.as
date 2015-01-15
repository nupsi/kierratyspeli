package screens
{
	import events.GiveScore;
	import events.NavigationEvent;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import objects.Item;
	import objects.Roskakorit;
	import objects.hihna;
	
	import starling.display.*;
	import starling.events.*;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	//Tässä luokassa on pelin pää toiminnot
	public class GameMain extends Sprite
	{
		/*=====================================================================================================================*/
		//"isot" kuvat
		//peli taustat
		private var bg1:Image;
		private var bg2:Image;
		private var kiviBg:Image;
		private var vesiBg:Image;
		private var avaruusBg:Image;
		//muut
		private var kauppaBg:Image;
		private var saavutusBg:Image;
		private var kone:Image;
		private var kori:Image;
		private var diplomi:Image;
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
		private var dayEndContainer:Sprite = new Sprite();
		private var dayEndLayer1:Sprite = new Sprite();
		private var dayEndLayer2:Sprite = new Sprite();
		//Kaupan muuttujat (kt = lyhenne kaupan tavaroille)
		//Tässä teidot kaupan: Painikkeelle, Hinnalle, onko tavara ostettu.
		private var kt1			:Button;
		private var kt1Hinta	:int = 400;
		private var kt1Ostettu	:Boolean = false;
		
		private var kt2			:Button;
		private var kt2Hinta	:int = 800;
		private var kt2Ostettu	:Boolean = false;
		
		private var kt3			:Button;
		private var kt3Hinta	:int = 1200;
		private var kt3Ostettu	:Boolean = false;
		
		private var kt4			:Button;
		private var kt4Hinta	:int = 200;
		private var kt4Ostettu	:Boolean = false;
		
		private var kt5			:Button;
		private var kt5Hinta	:int = 1000;
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
		//päivän loppumisen muuttujat
		private var endButton1:Button;
		private var endButton2:Button;
		//diplomin sulkemisen painike
		private var closeDiplom:Button;
		//Roskakorien muuttujat
		private var kori1:int = Math.round(Math.random()*1) + 1;
		private var kori2:int = Math.round(Math.random()*5) + 1;
		private var kori3:int = Math.round(Math.random()*5) + 1;
		private var kori4:int = Math.round(Math.random()*5) + 1;
		private var kori5:int = Math.round(Math.random()*5) + 1;
		private var kori6:int = Math.round(Math.random()*5) + 1;
		//kauppa / saavutus välilehti painikkeet
		private var kauppaVL:Button 		= new Button(Assets.getAtlas().getTexture("playBtn"));
		private var saavutusVL:Button 		= new Button(Assets.getAtlas().getTexture("playBtn"));
		//teksti kentät
		private var gameScore:TextField 	= new TextField( 185, 25,pisteText,"embedFont",22,0xFFFFFF,false)
		private var timePlayedTxt:TextField = new TextField( 200, 25,"","embedFont",22,0xFFFFFF,false);
		private var saavutusInfo:TextField	= new TextField( 412, 105,saavutusText,"embedFont",13,0x000000,false);
		private var kauppaInfo:TextField	= new TextField( 412, 105,kauppaText,"embedFont",13,0x000000,false);
		private var diplomiText:TextField	= new TextField( 680, 480,"","embedFont",20,0x000000,false); 
		//valmiita tekstejä
		private var pisteText:String 	= "Pisteet: ";
		private var aikaText:String		= "Aika: ";
		private var viiva:String		= "========================"
		private var saavutusText:String = viiva + "\nTervetuloa saavutus valikkoon.\n" + viiva;
		private var kauppaText:String	= viiva + "\nTervetuloa kauppaan\n" + viiva;
		private var onnitteluText:String= "Tyekentelit tehtaalla "+day+" päivää.\nHyvin tehty!"
		//painikkeet
		private var kauppaBtn:Button;
		private var saavutusBtn:Button;
		private var ruksi:Button;
		private var nextDay:Button;
		//pelin toimintojen pysäytys/käynnistys
		private var gameRunning:Boolean	= false;
		private var dayEnded:Boolean	= false;
		//tavara
		private var newItem:Item
		//Satunnaisia numeroita eri asioiden säätämiseen
		private var kauppaAvausNopeus:int 	= 10;	//kaupan ja saavutusten avaus nopeus
		private var hihnaAnimSpeed:int 		= 40;	//hihnan fps
		private var hihnaMaara:int 			= 4;	//hihnojen määrä
		private var gTick:int 				= 0;	//game tick
		private var score:int				= 0;	//pisteet
		private var binAmmount:int			= 1;	//montako koria on näkyvissä
		private var tLaajuus:int			= 2;	//kuinka suurelta alueelta tavaroita luodaan (1-6)
		private var day:int					= 1;	//Monesko päivä pelissä on
		private var tavaroitaLajiteltu:int	= 0;	//montako tavaraa pelaaja on lajitellut (päivän kestoon vaikuttaa)
		private var luomisNopeus:int		= 70;	//tavaroiden luomisen tiheys (+ Math.random()*30) 		(normaali = 70)
		private var itemMovingSpeed:Number	= 1.8;	//tavaran sivuttainen liikkumisnopeus 					(normaali = 1.8)
		private var saavutuksiaYhteensa:int = 0;    //saavutuksien määrä yhteensä (kun tämä numero on 9, niin peli on läpäisty.)
		//pisteen laskennan muuttujat ( score = scoreBasic x scoreMultiplier ).
		private var scoreBasic:int			= 10;	//tavaran normaali pistemäärä
		private var scoreMultiplier:int		= 1;	//pisteiden kerroin
		//hiiren sijainti (kehitystä varten voi postaa valmiissa versiossa mouseListener() kanssa)
		private var devInfo:TextField = new TextField(300,200,"","embedFont",12,0xFF0000)
		private var mouseTarget:Object;
		private var mouseX:int;
		private var mouseY:int;
		//ajan laskennan muuttujat
		private var gameStartTime:uint;
		private var gameTime:uint;
		//tavaroiden säilytys
		private var itemVector:Vector.<Item>;
		private var vaaraType:Array = new Array();
		private var vaaraTexture:Array = new Array();
		//Taustan muuttuja (tämän muuttujan perusteella tausta luodaan
		private var taustaTyyli:String = "Normaali";
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
			bg2 		= new Image(Assets.getTextures("tausta4"));
			kauppaBg 	= new Image(Assets.getTextures("kaupanPohjaKuva"));
			kone 		= new Image(Assets.getTextures("kone"));
			saavutusBg 	= new Image(Assets.getTextures("saavutustenPohjaKuva"));
			saavutusBtn = new Button(Assets.getAtlas().getTexture("saavutus"));
			kauppaBtn 	= new Button(Assets.getAtlas().getTexture("kauppaKuvake"));
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
			gameScore.vAlign = VAlign.TOP;
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
			//dev()
		}
		
		private function dev():void
		{
			devInfo.x = 30; devInfo.y = 30;devInfo.touchable = false
			devInfo.hAlign = HAlign.LEFT;devInfo.vAlign = VAlign.TOP;
			devInfo.border = false;this.addChild(devInfo);
		}
		//luo taustan (tausta luodaan taustaTyyli muuttujan eprusteella jota voidaan muokata kaupan avulla
		//tätä toimintoa tarvitaan jotta pelin taustaa voidaan vaihtaa, kun pelaaja ostaa pisteillä uuden taustan)
		private function createBg():void
		{
			bgLayer.removeChildren();
			kori.x = 485;
			kori.y = stage.stageHeight * 0.5 + 30;
			kori.scaleX = 1.5; kori.scaleY = 1.5;
			
			if(bgLayer.numChildren > 0)
				bgLayer.removeChildren();
				
			switch(taustaTyyli)
			{
				case "Normaali":
					bg2.y = -bg2.height;
					bgLayer.addChild(bg1)
					bgLayer.addChild(bg2);
					break;
				case "Kivikausi":
					bgLayer.addChild(kiviBg)
					bgLayer.addChild(bg2);
					break;
				case "Vesi":
					bgLayer.addChild(vesiBg)
					bgLayer.addChild(bg2);
					break;
				case "Avaruus":
					bgLayer.addChild(avaruusBg)
					bgLayer.addChild(bg2);
					break;
			}
			bgLayer.addChild(kori)
		}
		
		//GAME TICK (toiminnot jotka toteutuu / tarkistetaan joka framella).
		private function gameTick(event:Event):void
		{
			gTick++
				tLaajuus = 2 + binAmmount;
			//päivittää tekstikentät
			gameScore.text = pisteText + score;
			
			devUpInfo();
			
			saavutusTarkistus();
			
			gameTime = getTimer()-gameStartTime;
			timePlayedTxt.text = aikaText + clockTime(gameTime);
			//pisteiden väri ("easter egg")
			if(score >= 0 && score <= 999)
				gameScore.color = 0xFFFFFF;
			else if(score >= 1000 && score <= 1999)
				gameScore.color = 0x99FF66;
			else if(score >= 2000 && score <= 2999)
				gameScore.color = 0x52CC52;
			else if(score >= 3000 && score <= 3999)
				gameScore.color = 0x33CC33;
			else if(score >= 4000 && score <= 4999)
				gameScore.color = 0xCCFF33;
			else if(score >= 5000 && score <= 9999)
				gameScore.color = 0xFFFF00;
			else if(score >= 10000)
				gameScore.color = 0xCCCC3E;
			else
				gameScore.color = 0xFF0000;
			//pelin häviäminen
			if(score <= -10)
			{
				gameOver()
			}
			if(saavutuksiaYhteensa == 9)
			{
				gameWin();			
			}
			
			//päivä
			if(tavaroitaLajiteltu < day * 10)
			{
				kauppaBtn.visible = false;
				saavutusBtn.visible = false;
			}
			else
			{
				gameRunning = false;
				if(dayEnded == false)
				{
					endOfDay();
					kauppaBtn.visible = true;
					saavutusBtn.visible = true;
				}	
			}
			
			//tavaran luomti ja liikuttaminen
			if(gameRunning == true)
			{
				itemLayer.visible = true;
				createItem();
			}
			else
			{
				itemLayer.visible = false;
				itemLayer.removeChildren(0,1000,true)
				var ajastin:Date = new Date;
				nextDay.y = stage.stageHeight * .8 + (Math.cos(ajastin.getTime()*0.002)*5);
			}
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
			if(gTick > luomisNopeus + Math.ceil(Math.random() * 30))
			{
				newItem = new Item(Math.ceil(Math.random() * tLaajuus), kori1, kori2, kori3, kori4, kori5, kori6, binAmmount, itemMovingSpeed);
				itemLayer.addChild(newItem);
				itemVector.push(newItem);
				gTick = 0;
			}
		}
		
		//roskakorien luonti
		private function createKorit():void
		{
			for(var a:int = 0; a < 40;a++)
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
			var korit:Roskakorit = new Roskakorit(binAmmount, kori1, kori2, kori3,kori4);
			hihnaLayer.addChild(korit);
		}
		
		private function sekoitaKorit():void
		{
			kori1 = Math.round(Math.random()*binAmmount) + 1;
			kori2 = Math.round(Math.random()*5) + 1;
			kori3 = Math.round(Math.random()*5) + 1;
			kori4 = Math.round(Math.random()*5) + 1;
			kori5 = Math.round(Math.random()*5) + 1;
			kori6 = Math.round(Math.random()*5) + 1;
		}
		//Pisteiden anto
		private function scoreGive(event:GiveScore):void
		{
			switch(event.params.id)
			{
				case "plus":
					score += scoreBasic * scoreMultiplier;
					var scoreFinal1:int = scoreBasic * scoreMultiplier;
					createScoreText(scoreFinal1);
					tavaroitaLajiteltu++;
					break;
				case "minus":
					score -= scoreBasic * scoreMultiplier * 0.5;;
					var scoreFinal2:int = -scoreBasic * scoreMultiplier * 0.5;
					createScoreText(scoreFinal2);
					//"tallentaa" väärin lajitellun tavaran tiedot (tyyli,texture) vaaarat muuttujaan
					//että ne voidaan myöhemmin näyttää pelaajalle
					vaaraType.push(event.params.object)
					vaaraTexture.push(event.params.texture)
					tavaroitaLajiteltu++;
					break;
				case "floor":
					score -= scoreBasic * scoreMultiplier;
					scoreFinal2 = -scoreBasic * scoreMultiplier;
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
			o.y += 0.5
			o.alpha -= .01
			if(o.alpha == 0)
			{
				removeChild(o as TextField);
				removeEventListener(Event.ENTER_FRAME, sTxtMovement)
			}
			
		}
		//päivän loppuminen
		private function endOfDay():void
		{
			dayEnded = true;
			endOfDayTausta();//taustan luonti
			dayEndContainer.x = 0;
			
			for(var im:int = 0;im < vaaraType.length;im++)
			{
				var tavara:Image = new Image(Assets.getItems().getTexture(vaaraType[im] + "_item_" + vaaraTexture[im]));
				var oikeaTapa:String = haeOikeaTapa(vaaraType[im]);
				tavara.y = 200;		tavara.x = 45 + ((20 + tavara.width) * im);
				var tavaraText:TextField = new TextField(77, 25,oikeaTapa,"embedFont",12,0xFFFFFF);
				tavaraText.x = tavara.x; tavaraText.y = tavara.y + tavara.height;
				dayEndLayer1.addChild(tavara);
				dayEndLayer1.addChild(tavaraText);
			}
			endButton1  = new Button(Assets.getAtlas().getTexture("scroll_button"));
			endButton2  = new Button(Assets.getAtlas().getTexture("scroll_button"));
			nextDay 	= new Button(Assets.getAtlas().getTexture("nuoli"));
			endButton1.scaleWhenDown = 1; endButton2.scaleWhenDown = 1; endButton2.scaleX = -1;
			endButton1.alpha = .5;
			
			if(dayEndLayer1.x + dayEndLayer1.width  <= stage.stageWidth)
			{
				endButton2.visible = false;	endButton1.visible = false;
			}else{
				endButton2.visible = true;	endButton1.visible = true;
			}
			
			endButton1.y = stage.stageHeight * 0.5 - endButton1.height * 0.5;
			endButton1.x = 0;
			endButton2.y = endButton1.y;
			endButton2.x = stage.stageWidth;
			dayEndLayer2.addChild(endButton1);
			dayEndLayer2.addChild(endButton2);
			dayEndLayer2.addEventListener(TouchEvent.TOUCH, endDayTouch)
			
			nextDay.x = stage.stageWidth * .5 - nextDay.width * .5;
			nextDay.y = stage.stageHeight * .8;
			dayEndLayer2.addChild(nextDay);
			
			dayEndContainer.addChild(dayEndLayer1);
			dayEndContainer.addChild(dayEndLayer2);
			this.addChild(dayEndContainer);
		}
		
		private function endOfDayTausta():void
		{
			for(var tm:uint = 0;tm < (vaaraType.length / 5);tm++)
			{
				var dayEndBg1:Image = new Image(Assets.getTextures("pv_end_bg_1"));
				dayEndBg1.y = stage.stageHeight * 0.5 - dayEndBg1.height * 0.5;
				dayEndBg1.x = dayEndBg1.width * tm;
				dayEndLayer1.addChild(dayEndBg1);
			}
		}
		
		private function endDayTouch(event:TouchEvent):void
		{
			var o:Button = event.target as Button;
			
			if (event.getTouch(this, TouchPhase.BEGAN))
			{
				if((o as Button) == endButton1){
					dayEndLayer1.addEventListener(Event.ENTER_FRAME, endDayMr);
				}else if((o as Button) == endButton2){
					dayEndLayer1.addEventListener(Event.ENTER_FRAME, endDayMl);
				}
			}else{
				dayEndLayer1.removeEventListener(Event.ENTER_FRAME, endDayMr);
				dayEndLayer1.removeEventListener(Event.ENTER_FRAME, endDayMl);
			}
			
			if(event.getTouch(this, TouchPhase.BEGAN))
			{
				if((o as Button) == nextDay)
				{
					startNextDay();
				}
			}
		}
		
		private function startNextDay():void
		{
			dayEndLayer1.removeChildren();
			dayEndLayer2.removeChildren();
			hihnaLayer.removeChildren();
			day++;
			itemMovingSpeed += 0.1
			hihnaAnimSpeed += 2;
			luomisNopeus -= 5;
			tavaroitaLajiteltu = 0;
			createHihna();
			sekoitaKorit();
			createKorit();
			dayEnded = false;
			gameRunning = true;
		}
		
		private function endDayMl():void
		{
			if(dayEndLayer1.x + dayEndLayer1.width  > stage.stageWidth)
			{
				dayEndLayer1.x -= 5
				endButton2.alpha = 1;
				endButton1.alpha = 1;
			}else{
				endButton2.alpha = .5;
			}
			
		}
		
		private function endDayMr(event:Event):void
		{
			if(dayEndLayer1.x < 0){
				dayEndLayer1.x += 5
				endButton1.alpha = 1;
				endButton2.alpha = 1;
			}else{
				endButton1.alpha = .5;
			}
			
		}
		
		//Hakee tavaran oikean kierrätys tavan jotta se voiaan näyttää pelaajalle
		private function haeOikeaTapa(params:Object):String
		{
			var text:String;
			switch(params)
			{
				case 1:
					text = "Pahvi";
					break;
				case 2:
					text = "Metalli";
					break;
				case 3:
					text = "Lasi";
					break;
				case 4:
					text = "Biojäte";
					break;
				case 5:
					text = "Vaarallinen jäte";
					break;
				case 6:
					text = "Paperi";
					break;
			}	
			return text;
		}
		//Pelin loppumiset
		private function gameOver():void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "gameOver"}, true));
		}
		
		private function gameWin():void
		{
			diplomi = new Image(Assets.getTextures("Diplomi"));
			diplomi.x = 10; 
			diplomi.y = stage.stageHeight;
			this.addChild(diplomi);
			gameRunning = false;
			saavutuksiaYhteensa = 10;
			diplomiText.x = diplomi.x;
			diplomiText.y = diplomi.y;
			diplomiText.text = onnitteluText;
			this.addChild(diplomiText);
			diplomi.addEventListener(Event.ENTER_FRAME, diplomiEnter);
		}
		
		private function diplomiEnter(event:Event):void
		{
			if(diplomi.y > 10)
			{
				diplomi.y -= kauppaAvausNopeus;
				diplomiText.y = diplomi.y;
			}
			else
			{
				diplomi.removeEventListener(Event.ENTER_FRAME, diplomiEnter);
				closeDiplom	= new Button(Assets.getAtlas().getTexture("nuoli"));
				closeDiplom.x  = stage.stageWidth * 0.5 - closeDiplom.width * 0.5;
				closeDiplom.y = stage.stageHeight - closeDiplom.height;
				this.addChild(closeDiplom);
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
					kauppaBtn.x = stage.stageWidth - 20;
					saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
					this.addEventListener(Event.ENTER_FRAME, suljeKauppa);
					this.addChild(kauppaBtn);
					this.addChild(saavutusBtn);
				}
				
				if(saavutusAuki == true)
				{
					kauppaBtn.x = stage.stageWidth - 20;
					saavutusBtn.x = kauppaBtn.x - (saavutusBtn.width * 1.1);
					this.removeChild(ruksi);
					this.addEventListener(Event.ENTER_FRAME, suljeSaavutus);
					this.addChild(kauppaBtn);
					this.addChild(saavutusBtn);
				}
			}
			//diplomin sulkeminen
			if((buttonC as Button) == closeDiplom)
			{
				endOfDay();
				this.removeChild(closeDiplom);
				this.removeChild(diplomi);
				this.removeChild(diplomiText);
			}
			//Kaupan painikkeet				
			if((buttonC as Button) == kt1)
				if(kt1Ostettu == false)
					if(score >= kt1Hinta)
					{
						score -= kt1Hinta;
						kt1.alpha = .5;
						kt1Ostettu = true;
						//laajennus1
						saavutus6Saatu = true;
						binAmmount++;
						scoreMultiplier++
							saavutuksiaYhteensa++;
					}
			if((buttonC as Button) == kt2)
				if(kt2Ostettu == false && kt1Ostettu == true)
					if(score >= kt2Hinta)
					{
						score -= kt2Hinta;
						kt2.alpha = .5;
						kt2Ostettu = true;
						//laajennus2
						saavutus7Saatu = true;
						binAmmount++;
						scoreMultiplier++
							saavutuksiaYhteensa++;
					}
			if((buttonC as Button) == kt3)
				if(kt3Ostettu == false && kt2Ostettu == true && kt1Ostettu == true)
					if(score >= kt3Hinta)
					{
						score -= kt3Hinta;
						kt3.alpha = .5;
						kt3Ostettu = true;
						//laajennus3
						saavutus8Saatu = true;
						binAmmount++;
						scoreMultiplier++
							saavutuksiaYhteensa++;
					}
			if((buttonC as Button) == kt4)
				if(kt4Ostettu == false)
					if(score >= kt4Hinta)
					{
						score -= kt4Hinta;
						kt4.alpha = .5;
						kt4Ostettu = true
						//työntekijä 1
						saavutus5Saatu = true;
						scoreMultiplier++;
						saavutuksiaYhteensa++;
					}
			if((buttonC as Button) == kt5)
				if(kt5Ostettu == false)
					if(score >= kt5Hinta)
					{
						score -= kt5Hinta;
						kt5.alpha = .5;
						kt5Ostettu = true
						//tausta 1
						taustaTyyli = "Avaruus";
					}
			if((buttonC as Button) == kt6)
				if(kt6Ostettu == false)
					if(score >= kt6Hinta)
					{
						score -= kt6Hinta;
						kt6.alpha = .5;
						kt6Ostettu = true
						//tausta 2
						taustaTyyli = "Vesi";
					}
			if((buttonC as Button) == kt7)
				if(kt7Ostettu == false)
					if(score >= kt7Hinta)
					{
						score -= kt7Hinta;
						kt7.alpha = .5;
						kt7Ostettu = true
						//tausta 3
						taustaTyyli = "Kivikausi";
					}
			if((buttonC as Button) == kt8)
				if(kt4Ostettu)
					if(kt8Ostettu == false)
						if(score >= kt8Hinta)
						{
							score -= kt8Hinta;
							kt8.alpha = .5;
							kt8Ostettu = true
							//työntekijä 2
							saavutus9Saatu = true
							scoreMultiplier++;
							saavutuksiaYhteensa++;
						}
			if((buttonC as Button) == kt9)
				if(kt9Ostettu == false)
					if(score >= kt9Hinta)
					{
						score -= kt6Hinta;
						kt9.alpha = .5;
						kt9Ostettu = true
						//uusi musiikki
						
					}
			if((buttonC as Button) == kauppaVL)
			{
				if(saavutusAuki == true)
				{
					saavutusSulkemisLopetus();
					this.addEventListener(Event.ENTER_FRAME, suljeSaavutus);
					openShop();
				}
			}
			
			if((buttonC as Button) == saavutusVL)
			{
				if(kauppaAuki == true)
				{
					kauppaSulkemisLopetus();
					this.addEventListener(Event.ENTER_FRAME, suljeKauppa);
					openSaavutus();
				}
			}
		}
		/*	=============-KAUPAN TOIMINNOT ALKAA-=============
		openShop() 				- lisää kuvakkeet ja siirtyy seuraavaan toimintoon
		kauppaLiike(event)		- liikuttaa ikkunan alhaalta ylös
		kauppaAvausLopetus()	- toiminnot mitä tapahtuu kun ikkuna on oikeassa sijainnissa 
		kauppaMouse(event)		- seuraa hiiren sijaintia
		suljeKauppa(event)		- liikuttaa ikkunan ylhäältä alas
		kauppaSulkemisLopetus()	- toiminnot mitä tapahtuu kun ikkuna on oikeassa sijainnissa
		kauppaKuvaLiike() 		- laskee kuvakkeiden uudestaan					
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
			this.addChild(saavutusVL);this.addChild(kauppaInfo);
			kauppaKuvakeLiike();
			saavutusVL.width = 175; saavutusVL.height = 25;	saavutusVL.alpha = 0;
		}
		
		private function kauppaLiike(event:Event):void
		{
			if(kauppaBg.y > stage.stageHeight * 0.5 - kauppaBg.height * 0.5)
			{
				kauppaBg.y -= kauppaAvausNopeus;
			}
			else
			{
				kauppaAvausLopetus();
			}
			
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
					kauppaInfo.text = viiva + "\nUusi roskakori 1\nHinta: " +kt1Hinta + "\n" + viiva;
				else if(kt == kt2)
					kauppaInfo.text = viiva + "\nUusi roskakori 2\nSinun täytyy omistaa roskakori 1\nHinta: " +kt2Hinta + "\n"+ viiva;
				else if(kt == kt3)
					kauppaInfo.text = viiva + "\nUusi roskakori 3\nSinun täytyy omistaa roskakori 1 ja 2\nHinta: "+kt3Hinta + "\n" + viiva;
				else if(kt == kt4)
					kauppaInfo.text = viiva + "\nTyöntekijä 1\nLisää saatujen pisteiden määrää\nHinta: "+kt4Hinta + "\n" + viiva;
				else if(kt == kt5)
					kauppaInfo.text = viiva + "\nTausta uudistus\nHinta: " +kt5Hinta + "\n"+ viiva;
				else if(kt == kt6)
					kauppaInfo.text = viiva + "\nTausta uudistus\nHinta: " +kt6Hinta + "\n"+ viiva;
				else if(kt == kt7)
					kauppaInfo.text = viiva + "\nTausta uudistus\nHinta: " +kt7Hinta + "\n"+ viiva;
				else if(kt == kt8)
					kauppaInfo.text = viiva + "\nTyöntekijä 2\nTarvitset ensimmäisen työntekijän\nLisää saatujen pisteiden määrää\nHinta: "+kt8Hinta + "\n" + viiva;
				else if(kt == kt9)
					kauppaInfo.text = viiva + "\nUusi musiikki\nHinta: " +kt9Hinta + "\n"+ viiva;
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
			saavutusVL.x = 128;
			saavutusVL.y = kauppaBg.y;
		}
		/*	==========-SAAVUTUSTEN TOIMINNOT ALKAA-==========
		openSaavutus()				- lisää kuvakkeet ja siirtyy seuraavaan toimintoon
		saavutusLiike(event)		- liikuttaa ikkunan alhaalta ylös
		saavutusAvausLopetus()		- tapahtumat mitä tapahtuu kun ikkuna on oikeassa sijainnissa
		saavutusMouse(event)		- seuraa hiiren sijaintia
		suljeSaavutus(event)		- liikuttaa ikkunan ylhäältä alas
		saavutusSulkemisLopetus()	- tapahtumat mitä tapahtuu kun ikkuna on oikeassa sijainnissa
		saavutusKuvaLiike() 		- laskee kuvakkeiden uudestaan
		saavutusTarkistus()			- tarkistaa onko jokin saavutus saatu
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
			this.addChild(saavutus9);	this.addChild(kauppaVL);	
			this.addChild(ruksi);		this.addChild(saavutusInfo);
			kauppaVL.width = 175;	kauppaVL.height = 25;	kauppaVL.alpha = 0;
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
					saavutusInfo.text = viiva + "\nAnsaitse 100 pistettä\n" + viiva;
				else if(saavutus == saavutus2)
					saavutusInfo.text = viiva + "\nAnsaitse 500 pistettä\n" + viiva;
				else if(saavutus == saavutus3)
					saavutusInfo.text = viiva + "\nAnsaitse 1000 pistettä\n" + viiva;
				else if(saavutus == saavutus4)
					saavutusInfo.text = viiva + "\nAnsaitse 2000 pistettä\n" + viiva;
				else if(saavutus == saavutus5)
					saavutusInfo.text = viiva + "\nOsta ensimmäinen työntekijä\n" + viiva;
				else if(saavutus == saavutus6)
					saavutusInfo.text = viiva + "\nOsta ensimmäinen laajennus\n" + viiva;
				else if(saavutus == saavutus7)
					saavutusInfo.text = viiva + "\nOsta toinen laajennus\n" + viiva;
				else if(saavutus == saavutus8)
					saavutusInfo.text = viiva + "\nOsta kolmas laajennus\n" + viiva;
				else if(saavutus == saavutus9)
					saavutusInfo.text = viiva + "\nOsta toinen työntekijä\n" + viiva;
				else if(saavutus == kauppaVL)
					saavutusInfo.text = viiva + "\nVaihda kauppaan\n" + viiva;
				else
					saavutusInfo.text = saavutusText;
			}
		}
		
		private function saavutusTarkistus():void
		{
			if(saavutus1Saatu == false)
			{
				saavutus1.alpha = .2;
				if(score >= 100)
				{
					saavutus1Saatu = true;
					saavutus1.alpha = 1;'' +
						saavutuksiaYhteensa++;
				}
			}
			if(saavutus2Saatu == false)
			{
				saavutus2.alpha = .2;
				if(score >= 500)
				{
					saavutus2Saatu = true;
					saavutus2.alpha = 1;
					saavutuksiaYhteensa++;
				}
			}
			if(saavutus3Saatu == false)
			{
				saavutus3.alpha = .2;
				if(score >= 1000)
				{
					saavutus3Saatu = true;
					saavutus3.alpha = 1;
					saavutuksiaYhteensa++;
				}
			}
			if(saavutus4Saatu == false)
			{
				saavutus4.alpha = .2;
				if(score >= 2000)
				{
					saavutus4Saatu = true;
					saavutus4.alpha = 1;
					saavutuksiaYhteensa++;
				}
			}
			
			if(saavutus5Saatu == false)
				saavutus5.alpha = .2;
			else if(saavutus5Saatu == true)
			{
				saavutus5.alpha = 1;
			}
			
			if(saavutus6Saatu == false)
				saavutus6.alpha = .2;
			else if(saavutus6Saatu == true)
			{
				saavutus6.alpha = 1;
			}
			
			if(saavutus7Saatu == false)
				saavutus7.alpha = .2;
			else if(saavutus7Saatu == true)
			{
				saavutus7.alpha = 1;
			}
			
			if(saavutus8Saatu == false)
				saavutus8.alpha = .2;
			else if(saavutus8Saatu == true)
			{
				saavutus8.alpha = 1;
			}
			
			if(saavutus9Saatu == false)
				saavutus9.alpha = .2;
			else if(saavutus9Saatu == true)
			{
				saavutus9.alpha = 1;
			}
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
			kauppaVL.x = saavutusBg.x;							kauppaVL.y = saavutusBg.y;
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
			mouseTarget = event.currentTarget
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
		
		private function devUpInfo():void
		{
			devInfo.text =  "\nMouse x: "+mouseX+"		Mouse y: "+mouseY
				+"\nTavarat: " + itemVector.length + "		Piste kerroin: " + scoreMultiplier
				+"\nRunning: "+gameRunning+"		Tick: "+gTick
				+"\nRawTime: "+gameTime+"	lajiteltu: "+	tavaroitaLajiteltu
				+"\nPäivä: " + day + "	tavaroita: " + (day * 10)
				+"\nH Fps: " + hihnaAnimSpeed + "	Nopeus: " + itemMovingSpeed + "	L n: " + luomisNopeus
				+"\n[ "+kori1+" ][ "+kori2+" ][ "+kori3+" ][ "+kori4+" ][ "+kori5+" ][ "+kori6+" ]"
				+"\nVäärin: [" + vaaraType.length + "],["+ vaaraType +"],[" + vaaraTexture.length +"],[" + vaaraTexture + "]"
				+"\nSaavutukset " + saavutuksiaYhteensa + " ";
		}
		
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}
		
		public function initialize():void
		{
			this.addEventListener(Event.ENTER_FRAME, gameTick);
			this.addEventListener(TouchEvent.TOUCH, mouseListener);
			gameStartTime = getTimer();
			gameTime = 0;
			itemVector = new Vector.<Item>();
			gameRunning = true;
		}
		
		public function disposeTemp():void
		{
			gameRunning = false;
			this.removeEventListeners();
			this.removeChildren();
		}
	}
}