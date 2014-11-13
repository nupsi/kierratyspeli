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
		
		public function hihna()
		{
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage)
		}
			
		private function onAddedToStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			createHeroArt();
		}
			
		private function createHeroArt():void
		{
			hihnaAnim = new MovieClip(Assets.getAtlas().getTextures("hihna_"),25)
			hihnaAnim.scaleY = .8;
			hihnaAnim.scaleX = .8;
			starling.core.Starling.juggler.add(hihnaAnim);
			this.addChild(hihnaAnim);
		}
	}
}