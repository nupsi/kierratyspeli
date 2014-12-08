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
	import starling.textures.Texture;
	
	public class Item extends Sprite
	{
		private var _itemType:int;
		private var itemImage:Button;
		private var itemTexture:Texture;
		
		private var mouseX:int;
		private var mouseY:int;
		private var position:Point;
		
		private var k1:int;
		private var k2:int;
		private var k3:int;
		private var k4:int;
		private var k5:int;
		private var k6:int;
		
		private var fSpeed:int = 2;
		
		public function Item(_iItemType:int, kori1:int, kori2:int, kori3:int, kori4:int, kori5:int, kori6:int)
		{
			this.itemType = _iItemType;
			k1 = kori1;
			k2 = kori2;
			k3 = kori3;
			k4 = kori4;
			k5 = kori5;
			k6 = kori6;
		}
		
		public function get itemType():int
		{
			return _itemType;
		}
		//Assets.getItems().getTexture(_itemType + "_item_" + texture)
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
			o.scaleX = 1.05;
			o.scaleY = o.scaleX;
			o.rotation = 0.1
			
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
			o.scaleX = 1;
			o.scaleY = o.scaleX;
			o.rotation = 0;
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
							o.y += fSpeed;
						}
						else if(o.y > 0)
						{
							o.alpha -= .05
							if(o.alpha == 0)
							{
								if(_itemType == k5 || _itemType == k6)
									itemEvent(o,"+");
								else
									itemEvent(o,"-");
							}
						}
					}//jos tavara on hihnan ylä tai ala puolella
					else
					{
						o.y += fSpeed;
						if(o.y > 310 && o.y < 320)
						{
							//kori 1
							if(o.x < 140 && o.x > 20)
							{
								o.alpha -= .05;
								o.y -= fSpeed;
								if(o.alpha == 0)
								{
									if(_itemType == k1)
										itemEvent(o,"+");
									else
										itemEvent(o,"-");
								}
							}
							//kori 2
							else if (o.x > 145 && o.x < 240)
							{
								o.alpha -= .05;
								o.y -= fSpeed;
								if(o.alpha == 0)
								{
									if(_itemType == k2)
										itemEvent(o,"+")
									else
										itemEvent(o,"-")
								}
							}
							//kori 3
							else if (o.x > 265 && o.x < 380)
							{
								o.alpha -= .05;
								o.y -= fSpeed;
								if(o.alpha == 0)
								{
									if(_itemType == k3)
										itemEvent(o,"+")
									else
										itemEvent(o,"-")
								}
							}
							//kori 4
							else if (o.x > 390 && o.x < 500)
							{
								o.alpha -= .05;
								o.y -= fSpeed;
								if(o.alpha == 0)
								{
									if(_itemType == k4)
										itemEvent(o,"+")
									else
										itemEvent(o,"-")
								}
							}
						}
					}
				}
				else
				{
					o.alpha -= .05;
					if(o.alpha == 0)
						itemEvent(o,"-");
				}
			}
		}
		
		private function itemEvent(o:Object,statement:String):void
		{
			switch (statement)
			{
				case "+":
					this.removeChild(o as Button)
					this.dispatchEvent(new GiveScore(GiveScore.GIVE_SCORE,{id: "plus"},true));
					o.removeEventListener(Event.ENTER_FRAME, itemDrag);
					o.removeEventListener(Event.ENTER_FRAME,onItemEnter);
					break;
				case "-":
					this.removeChild(o as Button)
					this.dispatchEvent(new GiveScore(GiveScore.GIVE_SCORE,{id: "minus"},true));
					o.removeEventListener(Event.ENTER_FRAME, itemDrag);
					o.removeEventListener(Event.ENTER_FRAME,onItemEnter);
					break;
			}
		}		
	}
}