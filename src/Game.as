package
{
	import events.NavigationEvent;
	
	import screens.GameMain;
	import screens.Menu;
	import screens.Tutorial;
	
	import starling.display.Sprite;
	import starling.events.Event;
	/*
		Tässä luokassa yhdistetään ja kutsutaan eri luokkien toimintoja
	*/
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
			mainMenu.visibleState(true);
			
			tutorial = new Tutorial;
			this.addChild(tutorial);
			tutorial.visibleState(false);
			
			mainGame = new GameMain;
			this.addChild(mainGame);
			mainGame.visibleState(false);
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{
				case "play":
					tutorial.visibleState(false)
					mainMenu.cutscene();
					break;
				case "tutorial":
					tutorial.tutFadeScreen()
					tutorial.visibleState(true)
					mainMenu.visibleState(false)
					break;
				case "game":
					mainGame.visibleState(true)
					mainMenu.visibleState(false)
					tutorial.visibleState(false)
					break;
			}
			
		}
		
	}
}