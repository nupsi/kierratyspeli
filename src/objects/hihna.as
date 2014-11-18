package objects
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	/*
		Tässä luokassa luodaan: hihnan animaatio
	*/
	public class hihna extends Sprite
	{
		private var hihnaAnim:MovieClip
		private var speed:int;
		
		public function hihna(mySpeed:int)
		{
			speed = mySpeed;	
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage)
		}
			
		private function onAddedToStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			createHihnaAnim();
		}
			
		private function createHihnaAnim():void
		{
			hihnaAnim = new MovieClip(Assets.getAtlas().getTextures("hihna_"),speed)
			hihnaAnim.scaleY = .8;
			hihnaAnim.scaleX = .8;
			starling.core.Starling.juggler.add(hihnaAnim);
			this.addChild(hihnaAnim);
		}
	}
}