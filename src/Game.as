package
{
	import events.NavigationEvent;
	
	import screens.GameMain;
	import screens.gameOver;
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
		private var mySound:Sounds;
		private var newGameOver:gameOver;
		
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
			
			newGameOver = new gameOver;
			this.addChild(newGameOver);
			newGameOver.visibleState(false);
			
			mainGame = new GameMain;
			this.addChild(mainGame);
			mainGame.visibleState(false);
			
			mySound = new Sounds;
			this.addChild(mySound);
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen)
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch(event.params.id)
			{
				case "menu":
					this.removeChildren();
					this.removeEventListeners();
					onAddedToStage(null);
					break;
				case "play":
					tutorial.visibleState(false);
					mainMenu.cutscene();
					break;
				case "tutorial":
					tutorial.tutFadeScreen();
					tutorial.visibleState(true);
					mainMenu.visibleState(false);
					break;
				case "game":
					mainGame.visibleState(true);
					mainGame.initialize();
					mainMenu.visibleState(false);
					tutorial.visibleState(false);
					break;
				case "gameOver":
					newGameOver.initialize();
					newGameOver.visibleState(true);
					mainGame.visibleState(false);
					break;
			}
			
		}
		
	}
}