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
		
		// temporary output
		public var outputter:DebugOutputter;
		
		// actual MovieClips instances
		public var shutters:Array;
		public var lights:Array;
		public var cameras:Array;
		public var camerasMap:Object;
		
		public function ContainerGame()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			controller = new Controller(this);
			
			outputter = new DebugOutputter();
			addChild(outputter);
			outputter.x = 320;
			outputter.y = 240;
			
			var mc:MovieClip;
			var i:uint;
			
			shutters = [outputter.btn_doorL, outputter.btn_doorR];
			for (i = 0; i < 2; i++)
			{
				mc = shutters[i];	
				mc.ind = i;			
				shutters.push(mc);				
				mc.addEventListener(MouseEvent.CLICK, controller.onShutter);
			}
			
			lights = [outputter.btn_lightL, outputter.btn_lightR];
			for (i = 0; i < 2; i++)
			{
				mc = lights[i];
				mc.ind = i;
				lights.push(mc);
				mc.addEventListener(MouseEvent.MOUSE_DOWN, controller.onLight);
			}
			
			cameras = [outputter.cam_1a, outputter.cam_1b, outputter.cam_2, outputter.cam_3,
					   outputter.cam_4, outputter.cam_5, outputter.cam_6, outputter.cam_7a,
					   outputter.cam_7b, outputter.cam_8a, outputter.cam_8b, outputter.cam_9,
					   outputter.cam_10];
			camerasMap = new Object();
			var keys:Array = ["1a", "1b", "2", "3", "4", "5", "6", "7a", "7b", "8a", "8b", "9", "10"];
			for (i = 0; i < cameras.length; i++)
			{
				cameras[i].addEventListener(MouseEvent.MOUSE_DOWN, controller.onCamera);
				camerasMap[keys[i]] = cameras[i];
			}
			
			outputter.monitor.visible = false;
			
			outputter.btn_camOff.addEventListener(MouseEvent.MOUSE_DOWN, controller.onCameraOff);
			stage.addEventListener(MouseEvent.MOUSE_UP, controller.mouseUp);
		}
		
		override public function step():Boolean
		{
			controller.step();
			
			outputter.tf_fuel.text = "Fuel: " + controller.fuel.toFixed(01) + "%";
			outputter.tf_usage.text = "Load: " + controller.fuelDrainMultiplier + "x";
			return false;
		}
	}
}
