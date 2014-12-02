package objects
{
	import flash.geom.Point;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Item extends Sprite
	{
		private var _itemType:int;
		private var itemImage:Button;
		
		private var mouseX:int;
		private var mouseY:int;
		
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
			itemImage.x = -itemImage.width;
			itemImage.y = 180
			itemImage.addEventListener(Event.ENTER_FRAME,onItemEnter)
			itemImage.addEventListener(TouchEvent.TOUCH, onItemTouch)
			this.addChild(itemImage);
		}
		
		private function onItemTouch(event:TouchEvent):void
		{
			var o:Object = event.currentTarget
			var touch:Touch = event.getTouch(stage);
			var position:Point = touch.getLocation(stage);
			
			if (event.getTouch(this, TouchPhase.MOVED))
			{
				if(o == itemImage)
				{
					o.x = position.x - o.width * 0.5;
					o.y = position.y - o.height * 0.5;
				}
				else
				{
					
				}
			}
		}
		
		
		private function onItemEnter(event:Event):void
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
		
		private function mouseListener(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var position:Point = touch.getLocation(stage);
			if (event.getTouch(this, TouchPhase.HOVER))
			{
				mouseX = position.x
				mouseY = position.y
			}
			if (event.getTouch(this, TouchPhase.MOVED))
			{
				mouseX = position.x
				mouseY = position.y
			}
		}
		
	}
}