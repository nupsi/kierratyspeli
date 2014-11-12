package
{
	import events.NavigationEvent;
	
	import screens.GameMain;
	import screens.Menu;
	import screens.Tutorial;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var mainMenu:Menu;
		private var tutorial:Tutorial;
		private var mainGame:GameMain;
		
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
			
			tutorial = new Tutorial;
			this.addChild(tutorial);
			tutorial.disposeTemp();
			
			mainGame = new GameMain;
			this.addChild(mainGame);
			mainGame.disposeTemp();
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{
				case "play":
					tutorial.disposeTemp()
					mainMenu.cutscene();
					break;
				case "tutorial":
					tutorial.tutFadeScreen()
					tutorial.initialize()
					mainMenu.disposeTemp()
					break;
				case "game":
					mainGame.initialize()
					mainMenu.disposeTemp()
					tutorial.disposeTemp()
					break;
			}
			
		}
		
	}
}