package game
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/*
		This class prepares the stage:
			- create the maghine
			- call GUI
			- start the game
	*/
	
	public class Class1 extends Sprite
	{
		private var roskakorit:int;
		private var hihnaAmmount:int = 4; // this is 1 less than the real ammount
		
		public function Class1()
		{
			super();
			trace("+ + Game Start + +");
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			setUpGame()
		}
		
		private function setUpGame():void
		{
			
			for(var i:int = 0; i <= hihnaAmmount; i++)
			{
				var hihna:MovieClip = new Assets.hihnaAnim() as MovieClip
				hihna.scaleX = 0.5;
				hihna.scaleY = hihna.scaleX;
				hihna.name = "nh_" + i
				hihna.y = stage.stageHeight * 0.5 - hihna.height * 0.1;
				hihna.x = i * hihna.width * hihna.scaleX;
				this.addChild(hihna)
				if(i == hihnaAmmount)
				{
					break;
				}
			}
		}
	}
}