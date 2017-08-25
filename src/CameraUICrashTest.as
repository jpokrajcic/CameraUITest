package
{
	import com.crashtest.cameraui.Main;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;

	public class CameraUICrashTest extends Sprite
	{

		private var _starling:Starling;

		public function CameraUICrashTest()
		{
			super();
			stage.align 	= StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}

		private function loaderInfo_completeHandler(event:Event):void
		{
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			this._starling = new Starling( Main, this.stage );
			this._starling.enableErrorChecking = false;
			this._starling.start();
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
		}
		
		
		private function stage_resizeHandler( event:Event ):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width  = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}
		}
		
		
		private function activateHandler( event:Event ):void
		{
			removeEventListener( Event.ACTIVATE, activateHandler );
			this._starling.start();
		}
		
		
		private function deactivateHandler( event:Event ):void
		{
			addEventListener( Event.ACTIVATE, activateHandler, false, 0, true );
			this._starling.stop();
		}

	}
}

