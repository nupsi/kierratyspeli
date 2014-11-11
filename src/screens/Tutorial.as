package screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Tutorial extends Sprite
	{
		private var bgContainer:Sprite = new Sprite;
		private var textContainer1:Sprite = new Sprite;
		private var textContainer2:Sprite = new Sprite;
		
		private var bg1:Image;
		private var pk:Image;
		
		private var nextPart:Button
		
		private var tutTxt1:String = "Hei! Minä olen kierrätys tehtaan omistaja.\nOlen lähdössä lomalle voitko pitää tehtaasta huolta sillävälin?";
		private var tutTxt2:String = "Jaa.";
		
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
			pk = new Image(Assets.getTextures("puhekupla"));
			nextPart = new Button(Assets.getTextures("nuoli"))
			
			bgContainer.alpha = 0;
			bgContainer.addChild(bg1)
			this.addChild(bgContainer)
		}
		
		private function startTut():void
		{
			pk.x = (stage.stageWidth * 0.5) - (pk.width * 0.6)
			pk.y = (stage.stageHeight * 0.5) - (pk.height * 0.5)
			this.addChild(pk)
			
			var tutText1:TextField = new TextField(pk.width - 40 , pk.height - 100, tutTxt1,"Arial")
				tutText1.x = pk.x + 5;
				tutText1.y = pk.y + 5;
				tutText1.border = true
			textContainer1.addChild(tutText1)
			this.addChild(textContainer1)
				
			nextPart.x = tutText1.x + (tutText1.width * 0.5) - (nextPart.width * 0.5);
			nextPart.y = tutText1.y + tutText1.height + 10;
			this.addChild(nextPart)
			
			this.addEventListener(Event.TRIGGERED, onTutorialClick);
		}
		
		private function tutPart2():void
		{
			this.removeChild(textContainer1);
			this.removeChild(nextPart)
			
			var tutText2:TextField = new TextField(pk.width - 40 , pk.height - 100, tutTxt2)
			tutText2.x = pk.x + 5;
			tutText2.y = pk.y + 5;
			tutText2.border = true
			textContainer2.addChild(tutText2)
			
			this.addChild(textContainer2)
		}
		
		private function startGame():void
		{
			
		}
		
		private function onTutorialClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button
			if((buttonClicked as Button) == nextPart)
			{
				tutPart2();
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
		
		public function initialize():void
		{
			this.visible = true;
		}
		
		public function disposeTemp():void
		{
			this.visible = false;
		}
	}
}