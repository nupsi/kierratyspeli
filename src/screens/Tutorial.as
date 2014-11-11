package screens
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Tutorial extends Sprite
	{
		public var playerName:String;
		
		private var bgContainer:Sprite = new Sprite;
		
		private var bg1:Image
		
		private var tutTxt1:String = "";
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
			bg1 = new Image(Assets.getTextures("tausta3"))
			bgContainer.alpha = 0;
			bgContainer.addChild(bg1)
			this.addChild(bgContainer)
		}
		
		private function startTut():void
		{
			
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