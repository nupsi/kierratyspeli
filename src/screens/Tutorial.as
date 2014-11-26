package screens
{
	import events.NavigationEvent;
	
	import feathers.controls.TextInput;
	
	import flash.text.Font;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;

	/*
		Tässä luokassa luodaan: Pelin tutorial
	*/
	public class Tutorial extends Sprite
	{		
		private var bgContainer:Sprite = new Sprite;
		
		private var bg1:Image;
		private var pk:Image;
		
		private var nextPart:Button
		
		private var tutTxt1:String = "Hei!\nTervetuloa kierrätyskeskukseemme.\nOlen pomosi. Olen lähdössä lomalle ja meillä on pulaa työvoimasta. Voisitko tulla meille töihin?\nTehtävä on vaativa, mutta ei mahdoton.";
		private var tutTxt2:String = "Tässä muutamia perusasioita:\nValitse esine klikkaamalla hiirtä ja painamalla pohjassa.\nSiirrä se sitten oikeaan roskakoriin, tai anna liukua jäteastiaan.";
		private var tutTxt3:String = "Jos uskot olevasi valmis tehtävään, paina vihreää nuolta niin peli alkaa.";
	
		private var tutText1:starling.text.TextField  = new starling.text.TextField(333 , 80, " ","embedFont",13,0x000000,false);
		private var input:TextInput = new TextInput();
		
		public function Tutorial()
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
			pk = new Image(Assets.getAtlas().getTexture("puhekupla"));
			nextPart = new Button(Assets.getAtlas().getTexture("nuoli"));
			
			bgContainer.alpha = 0;
			bgContainer.addChild(bg1);
			this.addChild(bgContainer);		
		}
		
		private function startTut():void
		{
			pk.x = (stage.stageWidth * 0.5) - (pk.width * 0.6);
			pk.y = 240;
			pk.alpha = 0;
			this.addChild(pk);
			
			tutText1.text = tutTxt1;
			tutText1.x = pk.x + 5;
			tutText1.y = pk.x + 5;
			tutText1.border = false;
			tutText1.alpha = 0;
			this.addChild(tutText1);
				
			nextPart.x = tutText1.x + (tutText1.width * 0.5) - (nextPart.width * 0.5);
			nextPart.y = tutText1.y + tutText1.height + 10;
			nextPart.alpha = 0;
			this.addChild(nextPart);
			
			this.addEventListener(Event.TRIGGERED, onTutorialClick);
			this.addEventListener(Event.ENTER_FRAME, pkMovement);
		}
		
		private function pkMovement(event:Event):void
		{
			var ajastin:Date = new Date;
			pk.y = 165 + (Math.cos(ajastin.getTime()*0.002)*5);
			
			tutText1.y = pk.y + 5;
			nextPart.y = tutText1.y + tutText1.height + 2;
			if(pk.alpha <= 1)
				pk.alpha += .02;
			if(tutText1.alpha <= 1)
				tutText1.alpha += .01;

			nextPart.alpha = tutText1.alpha;
		}
		
		private function prepareGame():void
		{
			this.removeChild(nextPart);
			this.removeEventListener(Event.TRIGGERED, onTutorialClick);
			this.removeEventListener(Event.ENTER_FRAME, pkMovement);
			this.addEventListener(Event.ENTER_FRAME, pkFadeOut);
		}
		
		private function pkFadeOut(event:Event):void
		{
			pk.alpha -= .008;
			tutText1.alpha -= .008;
			
			pk.y += 0.5;
			tutText1.y = pk.y;
			
			if(pk.alpha == 0)
				startGame();
		}
		
		private function startGame():void
		{
			this.removeEventListener(Event.ENTER_FRAME, pkFadeOut);
			this.removeChild(pk); this.removeChild(tutText1);
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "game"}, true));
		}
		
		private function onTutorialClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == nextPart)
			{
				if(tutText1.text == tutTxt1)
					tutText1.text = tutTxt2;
				else if(tutText1.text == tutTxt2)
					tutText1.text = tutTxt3;
				else if(tutText1.text == tutTxt3)
					prepareGame();
			}
		}
		
		public function tutFadeScreen():void
		{
			stage.addEventListener(Event.ENTER_FRAME, screenFadeIn);
		}
		
		private function screenFadeIn(event:Event):void
		{
			for(var i:int = 0; i < 120;i++)
			{
				bgContainer.alpha += .00008;
					
				if(bgContainer.alpha == 1)
				{
					stage.removeEventListener(Event.ENTER_FRAME, screenFadeIn);
					startTut();
				}
			}	
		}
		
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}	
	}
}