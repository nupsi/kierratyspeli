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
			bg1 = new Image(Assets.getTextures("Bg1"))
			this.addChild(bg1)
			playBtn = new Button(Assets.getTextures("playBtn"))
			playBtn.x = 220;
			playBtn.y = 206;
			playBtn.alpha = 0;
			this.addChild(playBtn)
			//bg2 = new Image(Assets.getTextures("Bg2"))
			//this.addChild(bg2)
				
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
		
		public function initialize():void
		{
			this.visible = true;
		}
		
	}
}