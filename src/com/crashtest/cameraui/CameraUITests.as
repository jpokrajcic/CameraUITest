package com.crashtest.cameraui
{
	import flash.events.ErrorEvent;
	import flash.events.MediaEvent;
	import flash.events.PermissionEvent;
	import flash.media.CameraUI;
	import flash.media.MediaType;
	import flash.permissions.PermissionStatus;

	import starling.display.Sprite;
	import starling.events.Event;

	public class CameraUITests extends Sprite
	{
		private var _l : ILogger;

		private var counter:int;

		private var cameraUI:CameraUI;

		private function log( log:String ):void
		{
			_l.log(log);
		}

		public function CameraUITests( logger:ILogger )
		{
			_l = logger;
			try
			{
				if (CameraUI.isSupported)
				{
					cameraUI = new CameraUI();

					if (CameraUI.permissionStatus != PermissionStatus.GRANTED)
					{
						cameraUI.addEventListener(PermissionEvent.PERMISSION_STATUS, cameraPermissionHandler);

						try {
							cameraUI.requestPermission();
						} catch(e:Error)
						{
							log("requesting permission failed");
							cancelled();
						}
					}
					else
					{
						launchCameraUI();
					}
				}
				else
				{
					log("requesting permission failed");
					cancelled();
				}
			}
			catch (e:Error)
			{
				log("requesting permission failed");
			}
		}

		private function cameraPermissionHandler(e:PermissionEvent):void
		{
			if (e.status == PermissionStatus.GRANTED)
			{
				launchCameraUI();
			}
			else
			{
				log("camera permission denied");
				cancelled();
			}
		}

		public function launchCameraUI():void
		{
			cameraUI.addEventListener(MediaEvent.COMPLETE, onCameraUIComplete);
			cameraUI.addEventListener(Event.CANCEL, cancelCamera);
			cameraUI.addEventListener(ErrorEvent.ERROR, cancelCamera);
			cameraUI.launch(MediaType.IMAGE);
		}

		private function onCameraUIComplete(event:MediaEvent):void
		{
			counter++;

			log("Captured images: " + counter.toString());

			cameraUI.removeEventListener(MediaEvent.COMPLETE, onCameraUIComplete);
			cameraUI.removeEventListener(Event.CANCEL, cancelCamera);
			cameraUI.removeEventListener(ErrorEvent.ERROR, cancelCamera);
		}

		private function cancelCamera(event:Event):void
		{
			cancelled();
		}

		private function cancelled():void
		{
			cameraUI.removeEventListener(MediaEvent.COMPLETE, onCameraUIComplete);
			cameraUI.removeEventListener(Event.CANCEL, cancelCamera);
			cameraUI.removeEventListener(ErrorEvent.ERROR, cancelCamera);
		}

	}
}
