package com.crashtest.cameraui
{
	import feathers.controls.Button;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;

	public class Main extends Sprite implements ILogger
	{
		private var _tests:CameraUITests;
		private var _captureImageBtn:Button;
		private var _text:TextField;


		public function Main()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		
		public function log(message:String ):void
		{
			trace(message );
			if (_text)
				_text.text = message;
		}

		private function init():void
		{
			_tests = new CameraUITests( this );
			addChild( _tests );
		}

		private function createUI():void
		{
			_text = new TextField( stage.stageWidth, 50, "", "_typewriter", 28, Color.WHITE );
			_text.y = 250;
			_text.x = 50;
			_text.width = stage.stageWidth - 100;
			_text.touchable = false;

			_captureImageBtn = new Button();
			_captureImageBtn.label = "Capture image";
			_captureImageBtn.addEventListener( starling.events.Event.TRIGGERED, _tests.launchCameraUI );
			_captureImageBtn.width = stage.stageWidth - 100;
			_captureImageBtn.height = 80;
			_captureImageBtn.x = 50;
			_captureImageBtn.y = 150;

			addChild( _text );
			addChild( _captureImageBtn );
		}

		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );
			new MetalWorksMobileTheme();
			init();
			createUI();
		}
		
		
	}
}