package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.welcome;

	public class kierratyspeli extends Sprite
	{
		public function kierratyspeli()
		{
			trace("+ + FLASH BUILDER + +")
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			var startGame:welcome = new welcome;
			this.addChild(startGame);
		}
	}
}