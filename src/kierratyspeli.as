package
{
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(width = "640", height="480", frameRate="60", backgroundColor = "0x000000")]
	public class kierratyspeli extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling
		
		public function kierratyspeli()
		{
			stats = new Stats();
			this.addChild(stats)
			
			myStarling = new Starling(Game, stage)
			myStarling.antiAliasing = 1;
			myStarling.start()
		}
	}
}