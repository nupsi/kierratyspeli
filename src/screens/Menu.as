package screens
{
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Menu extends Sprite
	{
		private var bg1:Image;
		private var bg2:Image;
		
		private var playBtn:Button;
		
		public function Menu()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			createScreen();
		}
		
		private function createScreen():void
		{
			bg1 = new Image(Assets.getTextures("tausta1"))
			this.addChild(bg1)
			playBtn = new Button(Assets.getTextures("playBtn"))
			playBtn.x = 220;
			playBtn.y = 206;
			playBtn.alpha = 0;
			this.addChild(playBtn)
			bg2 = new Image(Assets.getTextures("tausta2"))
			bg2.x = bg1.x + bg1.width;
			this.addChild(bg2)
			
				
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
			
		}
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button
			if((buttonClicked as Button) == playBtn)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true))
			}
		}
		
		public function cutscene():void
		{
			this.addEventListener(Event.ENTER_FRAME, moveBg);
		}
		
		private function moveBg():void
		{
			this.removeChild(playBtn)
			for(var i:int = 0; i < 120; i++)
			{
				if(bg2.x >= 0)
				{
					bg1.x -= 0.05;
					bg2.x = bg1.x + bg1.width;
				}
				else
				{
					this.removeEventListener(Event.ENTER_FRAME, moveBg);
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