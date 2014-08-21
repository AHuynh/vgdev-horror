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
		private var outputter:DebugOutputter;
		
		// actual MovieClips instances
		public var shutters:Array;
		public var lights:Array;
		
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
