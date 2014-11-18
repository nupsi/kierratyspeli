package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Sounds extends Sprite
	{
		private var theme:Sound = new Assets.theme() as Sound;
		private var themeChannel:SoundChannel = new SoundChannel;
		
		private var sMixerBtn:Button = new Button(Assets.getAtlas().getTexture("musicBtn"));
		private var sRuksi:Button = new Button(Assets.getAtlas().getTexture("symbolX"));
		private var sPlayBtn:Button;
		private var sPauseBtn:Button;
		
		private var sMixerBg:Image = new Image(Assets.getAtlas().getTexture("musicMixerBg"));
		
		private var mSpeed:int = 1;
			
		public function Sounds()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			//playTheme();
			createButtons();
		}
		
		private function playTheme():void
		{
			themeChannel = theme.play()
		}
		
		private function stopTheme():void
		{
			themeChannel.stop();
		}
		
		private function createButtons():void
		{
			sMixerBtn.x = stage.stageWidth - sMixerBtn.width - 5;
			sMixerBtn.y = stage.stageHeight - sMixerBtn.height - 5;
			this.addChild(sMixerBtn)
				
			sRuksi.width = sRuksi.width * 0.5;
			sRuksi.height = sRuksi.width;
				
			this.addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
		private function onButtonClick(event:Event):void
		{
			var buttonC:Button = event.target as Button
				
			if((buttonC as Button) == sMixerBtn)
				openMixer();
			
			if((buttonC as Button) == sRuksi)
				this.addEventListener(Event.ENTER_FRAME,mixerMoveOut)
		}
		
		private function openMixer():void
		{
			sMixerBg.x = stage.stageWidth - sMixerBg.width - 5;
			sMixerBg.y = stage.stageHeight;
			sRuksi.x = sMixerBg.x + sMixerBg.width - sRuksi.width * 0.8;
			this.addChild(sMixerBg);
			this.addChild(sRuksi);
			this.addEventListener(Event.ENTER_FRAME,mixerMoveIn)
		}
		
		private function mixerMoveIn(event:Event):void
		{
			if(sMixerBg.y > stage.stageHeight - sMixerBg.height - 5)
			{
				sMixerBg.y -= mSpeed;
				sMixerBtn.x += mSpeed;
				sMixerBtn.alpha -= .05;
				sRuksi.y = sMixerBg.y - sRuksi.height * 0.4;
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME,mixerMoveIn);
				sMixerBtn.alpha = 0;
			}
		}
		
		private function mixerMoveOut(event:Event):void
		{
			if(sMixerBg.y < stage.stageHeight)
			{
				sMixerBg.y += mSpeed;
				sMixerBtn.x -= mSpeed;
				sMixerBtn.alpha += .008;
				sRuksi.y = sMixerBg.y - sRuksi.height * 0.4;
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, mixerMoveOut);
				sMixerBtn.x = stage.stageWidth - sMixerBtn.width - 5;
				sMixerBtn.alpha = 1;
				sRuksi.y += 30;
			}
		}
	}
}