package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Sounds extends Sprite
	{
		private var theme:Sound = new Assets.theme() as Sound;
		private var themeChannel:SoundChannel = new SoundChannel;
		private var myVolume:SoundTransform = new SoundTransform(sVolume);
		
		private var sMixerBtn	:Button = new Button(Assets.getAtlas().getTexture("musicBtn"));
		private var sRuksi		:Button = new Button(Assets.getAtlas().getTexture("symbolX"));
		private var sPlayBtn	:Button = new Button(Assets.getAtlas().getTexture("soundPlayBtn"));
		private var sPauseBtn	:Button = new Button(Assets.getAtlas().getTexture("soundPauseBtn"));
		private var sStopBtn	:Button = new Button(Assets.getAtlas().getTexture("soundStopBtn"));
		private var sSliderBtn	:Button = new Button(Assets.getAtlas().getTexture("sliderButton"))
		
		private var sMixerBg	:Image = new Image(Assets.getAtlas().getTexture("musicMixerBg"));
		private var sSliderBg	:Image = new Image(Assets.getAtlas().getTexture("sliderBg"));
		
		private var mSpeed		:int = 1;
		private var sVolume		:Number = 1;
		
		private var songPlaying	:Boolean = false;
			
		public function Sounds()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			createButtons();
			playTheme();
		}
		
		private function createButtons():void
		{
			sMixerBtn.x = stage.stageWidth - sMixerBtn.width - 5;
			sMixerBtn.y = stage.stageHeight - sMixerBtn.height - 5;
			this.addChild(sMixerBtn)
				
			sRuksi.width = sRuksi.width * 0.5;
			sRuksi.height = sRuksi.width;
			
			sMixerBg.x = stage.stageWidth - sMixerBg.width - 5;
			sSliderBg.x = sMixerBg.x + 5;
			sSliderBtn.x = (sSliderBg.x + 1) + 45;
			
			this.addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
		private function createSlider():void
		{
			sSliderBg.x = sMixerBg.x + 5;
			sSliderBg.y = sMixerBg.y + 5;
			sSliderBtn.y = sSliderBg.y + 1;
			sSliderBtn.scaleWhenDown = 1;
			sSliderBtn.addEventListener(TouchEvent.TOUCH, onSliderTouch);
			
			this.addChild(sSliderBg);
			this.addChild(sSliderBtn);
		}
		
		private function playTheme():void
		{
			if(songPlaying == false)
			{
				themeChannel = theme.play();
				volumeChange();
				songPlaying = true;
			}
		}
		
		private function pauseTheme():void
		{
			//Tähän pitäisi tehdä jotain. (PauseBtn toiminto)
		}
		
		private function stopTheme():void
		{
			if(songPlaying == true)
			{
				themeChannel.stop();
				songPlaying = false;
			}
		}
		
		private function onButtonClick(event:Event):void
		{
			var buttonC:Button = event.target as Button
				
			if((buttonC as Button) == sMixerBtn)
				openMixer();
			
			if((buttonC as Button) == sRuksi)
				this.addEventListener(Event.ENTER_FRAME,mixerMoveOut)
			
			if((buttonC as Button) == sPlayBtn)
				playTheme();
			else if((buttonC as Button) == sPauseBtn)
				pauseTheme();
			else if((buttonC as Button) == sStopBtn)
				stopTheme();
		}
		
		private function onSliderTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				if(touch.phase == TouchPhase.ENDED)
					volumeChange()
				else if(touch.phase == TouchPhase.MOVED)
				{
					sSliderBtn.x = touch.globalX - sSliderBtn.width * 0.5;
					
					if(sSliderBtn.x < sSliderBg.x + 1)
						sSliderBtn.x = sSliderBg.x + 2;
					else if(sSliderBtn.x > sSliderBg.x + 75)
						sSliderBtn.x = sSliderBg.x + 74;
				}
			}

		}
		
		private function volumeChange():void
		{
			sVolume = ((sSliderBg.x + 1) - sSliderBtn.x) * 0.0142857142857143;	
			themeChannel.soundTransform  = new SoundTransform(sVolume);
		}
		
		private function openMixer():void
		{
			sMixerBg.x = stage.stageWidth - sMixerBg.width - 5;
			sMixerBg.y = stage.stageHeight;
			sRuksi.x = sMixerBg.x + sMixerBg.width - sRuksi.width * 0.8;
			sSliderBg.x = sMixerBg.x + 5;
			sPlayBtn.x = sSliderBg.x;
			sPauseBtn.x = sPlayBtn.x + sPlayBtn.height + 5;
			sStopBtn.x = sPauseBtn.x + sPauseBtn.height + 5;
			
			this.addChild(sMixerBg);
			createSlider();
			this.addChild(sRuksi);
			this.addChild(sPlayBtn);
			this.addChild(sPauseBtn);
			this.addChild(sStopBtn);
			this.addEventListener(Event.ENTER_FRAME,mixerMoveIn)
		}
		
		private function mixerMoveIn(event:Event):void
		{
			if(sMixerBg.y > stage.stageHeight - sMixerBg.height - 5)
			{
				sMixerBg.y -= mSpeed;
				sMixerBtn.x += mSpeed;
				sMixerBtn.alpha -= .05;
				moveMixerButtons()
				sSliderBtn.y = sSliderBg.y + 2;
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
				moveMixerButtons()
				sSliderBtn.y = sSliderBg.y + 2;
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, mixerMoveOut);
				sMixerBtn.x = stage.stageWidth - sMixerBtn.width - 5;
				sMixerBtn.alpha = 1;
				sRuksi.y += 30;
			}
		}
		
		private function moveMixerButtons():void
		{
			sRuksi.y = sMixerBg.y - sRuksi.height * 0.4;
			sSliderBg.y = sMixerBg.y + 5;
			sPlayBtn.y = sSliderBg.y + sSliderBg.height + 5
			sPauseBtn.y = sPlayBtn.y;
			sStopBtn.y = sPlayBtn.y;
		}
	}
}