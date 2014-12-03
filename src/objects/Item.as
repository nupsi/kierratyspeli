package objects
{
	import events.GiveScore;
	
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
		private var position:Point;
		
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
			position = touch.getLocation(stage);
			
			if (event.getTouch(this, TouchPhase.BEGAN))
				if(o == itemImage)
				{
					o.removeEventListener(Event.ENTER_FRAME,onItemEnter);
					o.addEventListener(Event.ENTER_FRAME, itemDrag);
				}
			if (event.getTouch(this, TouchPhase.ENDED))
				if(o == itemImage)
				{
					o.addEventListener(Event.ENTER_FRAME,onItemEnter);
					o.removeEventListener(Event.ENTER_FRAME, itemDrag);
				}
		}
		
		private function itemDrag(event:Event):void
		{
			var o:Object = event.currentTarget
			o.x = position.x - o.width * .5;
			o.y = position.y - o.height * .5;
			if(o.x < 0)
				o.x = 0;
			if(o.y < 0)
				o.y = 0;
			if(o.x > stage.stageWidth - o.width)
				o.x = stage.stageWidth - o.width;
			if(o.y > stage.stageHeight - o.height)
				o.y = stage.stageHeight - o.height;
		}
		
		
		private function onItemEnter(event:Event):void
		{
			var o:Object = event.currentTarget
				//tavara on hihnan kohdalla
			if(o.y > 180 && o.y < 180 + 30 && o.x < 490)
			{
				o.x += 1.8;
			}	//jos tavara ei ole hihnalla
			else
			{	//jos tavara on alaraunan yläpuolella
				if(o.y < stage.stageHeight - o.height + 20)
				{//jos tavara on hihnan päädyssä
					if(o.x > 480)
					{
						if(o.y < 250)
						{
							o.y += 2;
						}
						else if(o.y > 249)
						{
							o.alpha -= .05
							if(o.alpha == 0)
							{
								if(_itemType == 1)
								{
									this.removeChild(o as Button)
									this.dispatchEvent(new GiveScore(GiveScore.GIVE_SCORE,{id: "plus"},true));
								}else
								{
									this.removeChild(o as Button)
									this.dispatchEvent(new GiveScore(GiveScore.GIVE_SCORE,{id: "minus"},true));
								}
							}
						}
					}//jos tavara on hihnan ylä tai ala puolella
					else
					{
						o.y += 2;
					}
				}
				else
				{
					o.alpha -= .05;
					if(o.alpha == 0)
					{
						if(_itemType == 2){
							this.dispatchEvent(new GiveScore(GiveScore.GIVE_SCORE,{id: "plus"},true));
							this.removeChild(o as Button)
						}else{
							this.dispatchEvent(new GiveScore(GiveScore.GIVE_SCORE,{id: "minus"},true));
							this.removeChild(o as Button)			
						}
					}
				}
			}
		}
		
	}
}