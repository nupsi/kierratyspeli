package screens
{
	import events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	/*
		Tässä luokassa luodaan: Pelin main menu
	*/
	public class Menu extends Sprite
	{
		private var bg1:Image;
		private var bg2:Image;
		private var bg3:Image;
		
		private var playBtn:Button;
		
		public function Menu()
		{
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
				
			playBtn = new Button(Assets.getAtlas().getTexture("playBtn"))
			playBtn.x = 220;
			playBtn.y = 206;
			playBtn.alpha = 0;
			this.addChild(playBtn)
				
			bg2 = new Image(Assets.getTextures("tausta2"))
			bg2.x = bg1.x + bg1.width;
			this.addChild(bg2)
				
			bg3 = new Image(Assets.getTextures("tausta3"))
			bg3.x = bg2.x + bg2.width;
			this.addChild(bg3)
			
				
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
				if(bg3.x > stage.stageWidth * 0.2)
				{
					bg1.x -= 0.05;
					
					bg2.x = bg1.x + bg1.width;
					bg3.x = bg2.x + bg2.width;
					
					bg2.alpha = bg1.alpha;
					bg3.alpha = bg2.alpha;
					
					if(bg1.x < 0 - bg1.width * 0.5)
					{
						bg1.alpha -= .00008;
					}
					
					if(bg1.alpha == 0)
					{
						goToGame()
						this.removeEventListener(Event.ENTER_FRAME, moveBg);
					}
				} else {
					goToGame()
					this.removeEventListener(Event.ENTER_FRAME, moveBg);
				}					
			}	
		}
		
		private function goToGame():void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "tutorial"}, true))
		}
		
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}		
	}
}