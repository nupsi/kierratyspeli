package screens
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Tutorial extends Sprite
	{
		public var playerName:String;
		
		private var bgContainer:Sprite = new Sprite;
		
		private var bg1:Image;
		private var pk:Image;
		
		private var tutTxt1:String = "Hei! Minä olen kierrätys tehtaan omistaja.\nOlen lähdössä lomalle voitko pitää tehtaasta huolta sillävälin?";
		private var tutTxt2:String = "";
		private var tutTxt3:String = "";
		
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
			bgContainer.alpha = 0;
			bgContainer.addChild(bg1)
			this.addChild(bgContainer)
		}
		
		private function startTut():void
		{
			pk.x = (stage.stageWidth * 0.5) - (pk.width * 0.6)
			pk.y = (stage.stageHeight * 0.5) - (pk.height * 0.5)
			bgContainer.addChild(pk)
			
			var tutText1:TextField = new TextField(pk.width - 40 , pk.height - 40, tutTxt1)
				tutText1.x = pk.x + 5;
				tutText1.y = pk.y + 5;
			bgContainer.addChild(tutText1)
		}
		
		public function tutFadeScreen():void
		{
			this.addEventListener(Event.ENTER_FRAME, screenFadeIn);
		}
		
		private function screenFadeIn(event:Event):void
		{
			for(var i:int = 0; i < 120;i++)
			{
				bgContainer.alpha += .00008;
					
				if(bgContainer.alpha == 1)
				{
					this.removeEventListener(Event.ENTER_FRAME, screenFadeIn);
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