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
			itemImage.scaleWhenDown = 1;
			itemImage.x = -itemImage.width;
			itemImage.y = 180
			itemImage.addEventListener(Event.ENTER_FRAME,onEnter)
			this.addChild(itemImage);
		}
		
		private function onEnter(event:Event):void
		{
			var o:Object = event.currentTarget
			//tavara on hihnan kohdalla
			if(o.y > 180 && o.y < 180 + 30 && o.x < 490)
			{
				o.x += 1.1111;
			}
			//jos tavara ei ole hihnalla
			else
			{
				//jos tavara on alaraunan yläpuolella
				if(o.y < stage.stageHeight - o.height + 20)
				{
					//jos tavara on hihnan päädyssä
					if(o.x > 480)
					{
						if(o.y < 250)
						{
							o.y += 4;
						}
						else if(o.y < 260)
						{
							o.alpha -= .05
							if(o.alpha == 0)
								this.removeChild(o as Button)	
						}
					}
					//jos tavara on hihnan ylä tai ala puolella
					else
					{
						o.y += 4;
					}
				}
			}
		}
		
	}
}