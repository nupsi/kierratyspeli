package
{
	import events.NavigationEvent;
	
	import screens.Menu;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var mainMenu:Menu;
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			mainMenu = new Menu;
			this.addChild(mainMenu);
			mainMenu.initialize();
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{
				case "play":
					mainMenu.cutscene();
					break;
			}
			
		}
		
	}
}