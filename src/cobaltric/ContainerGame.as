package cobaltric
{	
	import core.Controller;
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
		
		// temporary output values
		private var tf_fuel:TextField;
		private var tf_load:TextField;
		
		// temporary status values
		public var shutters:Array;
		
		public function ContainerGame()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			controller = new Controller(this);
			
			var tf_main:TextField = new TextField();
			tf_main.text = "Hello!";
			
			addChild(tf_main);
			tf_main.x = 350;
			tf_main.y = 50;
			
			tf_fuel = new TextField();
			tf_fuel.text = "100%";
			addChild(tf_fuel);
			tf_fuel.x = 10;
			tf_fuel.y = 425;
			
			tf_load = new TextField();
			tf_load.text = "1x";
			addChild(tf_load);
			tf_load.x = 10;
			tf_load.y = 450;
			
			shutters = [];
			for (var i:uint = 0; i < 2; i++)
			{
				var mc:MovieClip = new MovieClip();
				mc.shutterInd = i;
				mc.graphics.beginFill(0xCC4444);
				mc.graphics.drawRect(100 + i * 350, 170, 50, 100);
				mc.graphics.endFill();
				shutters.push(mc);
				addChild(mc);
				
				mc.addEventListener(MouseEvent.CLICK, controller.onShutter);
			}
		}
		
		override public function step():Boolean
		{
			controller.step();
			
			tf_fuel.text = "Fuel: " + controller.fuel.toFixed(2) + "%";
			tf_load.text = "Load: " + controller.fuelDrainMultiplier + "x";
			return false;
		}
	}
}
