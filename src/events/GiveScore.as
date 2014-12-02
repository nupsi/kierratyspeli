package events
{
	import starling.events.Event;
	
	public class GiveScore extends Event
	{
		public static const GIVE_SCORE:String = "giveScore";
		
		public var params:Object;
		
		public function GiveScore(type:String, _params:Object = null, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
			this.params = _params;
		}
	}
}