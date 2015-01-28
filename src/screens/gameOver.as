package screens
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class gameOver extends Sprite
	{
		private var bg6:Image;
		private var gameOverText:TextField;
		private var backToMainMenu:Button;
		
		public function gameOver()
		{
			
		}
		
		public function initialize():void
		{
			//Tähän tulee se mitä tapahtuu kun peli hävitää
			createScreen();
		}
		
		private function createScreen():void
		{
			bg6 = new Image(Assets.getTextures("tausta"));
			this.addChild(bg6)
			
			gameOverText = new TextField(200,40,"Hävisit Pelin","embedFont",30);
			gameOverText.y = -gameOverText.height;
			gameOverText.x = (stage.stageWidth * 0.5) - (gameOverText.width * 0.5);
			gameOverText.addEventListener(Event.ENTER_FRAME, _textMove);
			this.addChild(gameOverText);
			
			backToMainMenu = new Button(Assets.getAtlas().getTexture("nuoli"));
			backToMainMenu.scaleX -= 1;
			backToMainMenu.x = stage.stageWidth * 0.5 - backToMainMenu.width * 0.5;
			backToMainMenu.y = stage.stageHeight * 0.8;
			this.addChild(backToMainMenu)
		}
		
		private function _textMove(event:Event):void
		{
			if(gameOverText.y <= stage.stageHeight * 0.5)
				gameOverText.y++;
			else
				gameOverText.removeEventListener(Event.ENTER_FRAME, _textMove);
		}
		
		public function visibleState(value:Boolean):void
		{
			this.visible = value;
		}
		
		public function dips():void
		{
			this.removeChildren();
		}
	}
}