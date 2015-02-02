package
{
	/*
		Tapio on pelottava mies .-__-. 
					-Johanna 2014
	 */
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(width = "640", height="480", frameRate="60", backgroundColor = "0x000000")]
	public class kierratyspeli extends Sprite
	{
		private var _stats:Stats;
		private var _starling:Starling
		
		public function kierratyspeli()
		{
			_stats = new Stats();
			_stats.y = 350;
			//this.addChild(_stats);
			
			_starling = new Starling(Game, stage);
			_starling.antiAliasing = 1;
			_starling.supportHighResolutions = true;
			_starling.start();
		}
	}
}