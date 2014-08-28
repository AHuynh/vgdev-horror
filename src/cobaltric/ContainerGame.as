package cobaltric
{	
	import core.Controller;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Alexander Huynh
	 */
	public class ContainerGame extends ABST_Container
	{
		private var controller:Controller;
		
		// base MovieClips
		public var office:Office;					// primary view
		public var overlayCamera:OverlayCamera;		// cameras
		public var overlayDark:OverlayDark;
		
		// actual MovieClip instances
		public var doors:Array;			// door buttons
		public var shutters:Array;		// shutters
		public var lights:Array;		// light buttons
		public var cameras:Array;		// camera buttons
		public var camerasMap:Object;	// string -> camera MC
		
		public function ContainerGame()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			controller = new Controller(this);
			
			office = new Office();
			addChild(office);
			office.x = 400;
			office.y = 300;
			
			overlayDark = new OverlayDark();
			addChild(overlayDark);
			overlayDark.x = 400;
			overlayDark.y = 300;
			overlayDark.buttonMode = false;
			overlayDark.mouseEnabled = false;
			
			overlayCamera = new OverlayCamera();
			addChild(overlayCamera);
			overlayCamera.x = 400;
			overlayCamera.y = 300;
			overlayCamera.visible = false;
			overlayCamera.cam_1a.gotoAndStop("1a_main");
			
			var maskAll:MaskAll = new MaskAll();
			addChild(maskAll);
			maskAll.x = 400;
			maskAll.y = 300;
			
			var mc:MovieClip;
			var i:uint;
			
			doors = [office.btn_doorL, office.btn_doorR];
			for (i = 0; i < 2; i++)
			{
				mc = doors[i];	
				mc.ind = i;			
				doors.push(mc);				
				mc.addEventListener(MouseEvent.CLICK, controller.onShutter);
			}
			
			lights = [office.btn_lightL, office.btn_lightR];
			for (i = 0; i < 2; i++)
			{
				mc = lights[i];
				mc.ind = i;
				lights.push(mc);
				mc.addEventListener(MouseEvent.MOUSE_DOWN, controller.onLight);
			}
			
			cameras = [overlayCamera.cam_1a, overlayCamera.cam_1b, overlayCamera.cam_2, overlayCamera.cam_3,
					   overlayCamera.cam_4, overlayCamera.cam_5, overlayCamera.cam_6, overlayCamera.cam_7a,
					   overlayCamera.cam_7b, overlayCamera.cam_8a, overlayCamera.cam_8b, overlayCamera.cam_9,
					   overlayCamera.cam_10];
			camerasMap = new Object();
			var keys:Array = ["1a", "1b", "2", "3", "4", "5", "6", "7a", "7b", "8a", "8b", "9", "10"];
			for (i = 0; i < cameras.length; i++)
			{
				cameras[i].addEventListener(MouseEvent.MOUSE_DOWN, controller.onCamera);
				camerasMap[keys[i]] = cameras[i];
			}
			
			shutters = [office.shutterL, office.shutterR];
			
			overlayCamera.btn_camOff.addEventListener(MouseEvent.MOUSE_DOWN, controller.onCameraOff);
			office.mc_camera.addEventListener(MouseEvent.CLICK, controller.onCameraMain);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, controller.mouseUp);
		}
		
		override public function step():Boolean
		{
			controller.step();
			
			office.mc_displayPower.tf_fuel.text = "Fuel: " + controller.fuel.toFixed(0) + "%";
			office.mc_displayPower.tf_usage.text = "Load: " + controller.fuelDrainMultiplier + "x";
			return false;
		}
	}
}
