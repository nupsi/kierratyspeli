package game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	public class welcome extends Sprite
	{
		private var tutTxt_1:String = "Kirjoita nimesi:"; // Pyytää Pelaajaa antamaan nimensä.
		private var tutTxt_2:String = " Seuraavaksi opastamme sinua pelaamaan peliä.\nVoit siirtyä seuraavaan kohtaan painamalla\nSeuraava-painiketta."; // Tervetuloa pelaaja tekstin jälkeen
		
		private var tutTxt:TextField = new TextField;
		private var tutTxt2:TextField = new TextField;
		private var tutTxt3:TextField = new TextField;
		private var tutTxt4:TextField = new TextField;
		private var nextTxt:TextField = new TextField;
		
		private var tutBg:Sprite = new Sprite;
		private var nextBtn:Sprite = new Sprite;
		
		private var kauppa:Bitmap = new Assets.shopImage() as Bitmap;
		private var kauppaTausta:Bitmap = new Assets.shopBg() as Bitmap;
		private var saavutus:Bitmap = new Assets.shopImage() as Bitmap;
		
		private var delayCount:int;
		
		public function welcome()
		{
			super();
			trace("+ + Tutorial Start + +")
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			tutorial()
		}
		
		private function tutorial():void
		{
			trace("+ Tutorial part 1.")
			var format1:TextFormat = new TextFormat;
			format1.align = TextFormatAlign.CENTER;
			format1.size = 15;
			var format2:TextFormat = new TextFormat;
			format2.align = TextFormatAlign.LEFT;
			format2.bold = true;
			format2.size = 15;
			
			tutBg.graphics.lineStyle(1, 0x000000);
			tutBg.graphics.beginFill(0xA9A9A9);
			tutBg.graphics.drawRect(0,0,100,100);
			tutBg.graphics.endFill();
			
			nextBtn.graphics.lineStyle(1, 0x000000);
			nextBtn.graphics.beginFill(0xD5D5CB);
			nextBtn.graphics.drawRect(0,0,80,20);
			nextBtn.graphics.endFill();
			
			tutBg.x = stage.stageWidth * 0.5 - tutTxt.width * 0.6;
			tutBg.y = stage.stageHeight * 0.5 - tutTxt.height * 0.6;
			tutBg.width = tutTxt2.width * 1.3;
			tutBg.height = tutTxt2.height;
			
			nextBtn.x = tutBg.x + 20;
			nextBtn.y = tutBg.y + 65;
			
			addChild(tutBg);
			addChild(nextBtn);
			
			tutTxt.defaultTextFormat = format2;
			tutTxt2.defaultTextFormat = format1;
			nextTxt.defaultTextFormat = format1;
			
			tutTxt.x = stage.stageWidth * 0.5 - tutTxt.width * 0.5;
			tutTxt.y = stage.stageHeight * 0.5 - tutTxt.height * 0.5;
			tutTxt2.x = tutTxt.x;
			tutTxt2.y = tutTxt.y + 25;
			tutTxt2.width = tutTxt.width;
			tutTxt2.height = 20;
			
			nextTxt.x = nextBtn.x;
			nextTxt.y = nextBtn.y;
			nextTxt.width = nextBtn.width;
			nextTxt.height = nextBtn.height;
			
			tutTxt2.border = true;
			tutTxt.border = false;
			tutTxt.selectable = false;
			tutTxt2.selectable = true;
			nextTxt.selectable = false;
			tutTxt2.background = true;
			tutTxt2.backgroundColor = 0xFFFFFF;
			tutTxt2.maxChars = 16;
			tutTxt.autoSize = TextFieldAutoSize.LEFT;
			tutTxt2.type = TextFieldType.INPUT;
			
			nextTxt.addEventListener(MouseEvent.MOUSE_DOWN, goToNextPart)
				
			tutTxt.text = tutTxt_1;
			tutTxt2.text = "";
			nextTxt.text = "Seuraava";
			
			this.addChild(tutTxt)
			this.addChild(tutTxt2)
			this.addChild(nextTxt)
				
			trace("+ box location: " + tutBg.x); trace("+ box location: " + tutBg.y);
		}
	
		private function goToNextPart(Event:MouseEvent):void
		{
			nextTxt.removeEventListener(MouseEvent.MOUSE_DOWN, goToNextPart)
			var pName:String
			pName = tutTxt2.text;
			trace("+ Name [" + pName + "]")
			tutorial2(pName);
			this.removeChild(tutTxt)
			this.removeChild(tutTxt2)
		}
		
		private function tutorial2(pName:String):void
		{
			trace("+ Tutorial part 2."); 
			if(pName == "nimesi") { trace("VOITIT PELIN!") } else { }
			var format1:TextFormat = new TextFormat;
				format1.align = TextFormatAlign.CENTER;
				format1.size = 15;
			
			tutBg.x = stage.stageWidth * 0.2;
			tutBg.y = stage.stageHeight * 0.2;
			tutBg.width = stage.stageWidth * 0.6;
			tutBg.height = stage.stageHeight * 0.6;
			
			tutTxt3.x = 138;
			tutTxt3.y = 105;
			tutTxt3.width = tutBg.width - 20;
			tutTxt3.height = tutBg.height - 20;
			
			tutTxt3.defaultTextFormat = format1;
			tutTxt3.border = false;
			tutTxt3.wordWrap = true;
			tutTxt3.selectable = false;
			
			nextBtn.x = tutBg.x + tutBg.width - nextBtn.width - 20;
			nextBtn.y = tutBg.y + tutBg.height - nextBtn.height - 20;
			nextTxt.x = nextBtn.x;
			nextTxt.y = nextBtn.y;
			
			nextTxt.addEventListener(MouseEvent.MOUSE_DOWN, goToNextPart2)
				
			tutTxt3.text = "Tervetuloa "+ pName + ".\n\n" + tutTxt_2;
			
			this.addChild(tutBg);
			this.addChild(nextBtn);
			this.addChild(tutTxt3);
			this.addChild(nextTxt);
		}
		
		private function goToNextPart2(Event:MouseEvent):void
		{
			nextTxt.removeEventListener(MouseEvent.MOUSE_DOWN, goToNextPart2);
			tutorial3();
			this.removeChild(tutTxt3);
		}
		
		private function tutorial3():void
		{
			trace("+ Tutorial part 3")
			var format1:TextFormat = new TextFormat;
			format1.align = TextFormatAlign.LEFT;
			format1.size = 15;
			
			tutTxt4.defaultTextFormat = format1;			
			
			tutTxt4.text = "\n- Kauppa painike. \n\n	Kauppa painiketta painamalla pääset kauppaan.\n	Kaupasta voit ostaa erilaisia tavaroita\n	jotka auttavat sinua etenemään pelissä\n\n- Tavoitteet painike.\n\n	Tavoite painiketta painamalla pääset\n	katsomaan Pelin tavoitteita.\n	Saatuasi kaikki tavoitteet peli on läpäisty";
			tutTxt4.x = 200;
			tutTxt4.y = 105;
			tutTxt4.width = tutBg.width - 80;
			tutTxt4.height = tutBg.height - 20;
			tutTxt4.selectable = false;
			tutTxt4.border = false;
			
			kauppa.x = tutBg.x + 10;
			kauppa.y = tutBg.y + 10;
			saavutus.x = kauppa.x;
			saavutus.y = tutBg.y + 115;
			
			nextBtn.x = tutBg.x + tutBg.width - nextBtn.width - 20;
			nextBtn.y = tutBg.y + tutBg.height - nextBtn.height - 20;
			nextTxt.x = nextBtn.x;
			nextTxt.y = nextBtn.y;
			delay();
			
			
			this.addChild(tutTxt4);
			this.addChild(kauppa);
			this.addChild(saavutus);
			this.addChild(nextBtn);
			this.addChild(nextTxt);
		}
		
		private function delay():void
		{
			stage.addEventListener(Event.ENTER_FRAME, startDelay);
		}
		
		private function startDelay(event:Event):void
		{
			delayCount++
			if(delayCount == 10)
			{
				nextTxt.addEventListener(MouseEvent.MOUSE_DOWN, finishTut)
				stage.removeEventListener(Event.ENTER_FRAME, startDelay);
				delayCount = 0;
			}
		}
		
		private function finishTut(event:MouseEvent):void
		{
			toGame()
			nextTxt.removeEventListener(MouseEvent.CLICK, finishTut)
			this.removeChild(tutBg);
			this.removeChild(tutTxt4);
			this.removeChild(kauppa);
			this.removeChild(saavutus);
			this.removeChild(nextBtn);
			this.removeChild(nextTxt);
		}
		
		private function toGame():void
		{
			trace("+ + Tutorial End + +")
			var goToGame:Class1 = new Class1;
			this.addChild(goToGame)
		}
	}
}