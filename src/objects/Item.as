package objects
{
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Item extends Sprite
	{
		private var _itemType:int;
		private var itemImage:Button;
		
		public function Item(_iItemType:int)
		{
			this.itemType = _iItemType;
		}
		
		public function get itemType():int
		{
			return _itemType;
		}
		
		public function set itemType(value:int):void
		{
			_itemType = value;
			var texture:int = Math.ceil(Math.random() * 5);
			
			itemImage = new Button(Assets.getItems().getTexture(_itemType + "_item_" + texture));
			itemImage.scaleWhenDown = 1.01;
			//itemImage.x = -itemImage.width;
			//itemImage.y = 180
			//itemImage.addEventListener(Event.ENTER_FRAME,onEnter)
			this.addChild(itemImage);
		}
		
	}
}