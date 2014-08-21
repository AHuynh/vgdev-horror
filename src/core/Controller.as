package core 
{
	import cobaltric.ABST_Container;
	import cobaltric.ContainerGame;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * Controls core mechanics
	 * @author Alexander Huynh
	 */
	public class Controller 
	{
		private var cg:ContainerGame;
		
		// fuel usage
		public var fuel:Number;						// current generator fuel level
		public var fuelDrainRate:Number;			// base drain per step
		public var fuelDrainMultiplier:int;			// usage multiplier
		public var fuelDrainMultiplierLimit:int;	// max usage multiplier (min is 1)
		
		// shutter
		public var shutters:Array;					// boolean array indicating shutter state (T:closed, F:open)
		//public var shuttersStatus:Array;			// ??? array indicating shutter abnormalities
		
		public var lights:Array;
		
		/**
		 * Game controller requires reference to containing ContainerGame
		 *
		 * @param	_cg		The containing ContainerGame
		 */
		public function Controller(_cg:ContainerGame) 
		{
			cg = _cg;
			
			// setup fuel
			fuel = 100;
			fuelDrainRate = 0.007;
			fuelDrainMultiplier = 1;
			fuelDrainMultiplierLimit = 5;
			
			// setup shutters
			shutters = [false, false];
			
			// setup lights
			lights = [false, false];
			
			//cg.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
		}
		
		public function step():void
		{
			updateFuel();
		}
		
		private function onWheel(e:MouseEvent):void
		{
			if (e.delta > 0 && fuelDrainMultiplier < fuelDrainMultiplierLimit)
			{
				fuelDrainMultiplier++;
			}
			else if (e.delta < 0 && fuelDrainMultiplier > 1)
			{
				fuelDrainMultiplier--;
			}
		}
		
		public function onShutter(e:MouseEvent):void
		{
			shutters[e.target.ind] = !shutters[e.target.ind];
			
			if (shutters[e.target.ind])
			{
				e.target.gotoAndStop("greenNorm");
				fuelDrainMultiplier++;
			}
			else
			{
				e.target.gotoAndStop("redNorm");
				fuelDrainMultiplier--;
			}
		}
		
		public function onLight(e:MouseEvent):void
		{
			lights[e.target.ind] = true;
			fuelDrainMultiplier++;
			
			e.target.gotoAndStop("lightOn");
		}
		
		public function mouseUp(e:MouseEvent):void
		{
			var len:uint = lights.length;
			
			for (var i:uint = 0; i < len; i++)
			{
				if (lights[i])
					fuelDrainMultiplier--;
				lights[i] = false;
				cg.lights[i].gotoAndStop("lightOff");
			}
		}
		
		/**
		 * Reduces the fuel by the drain rate * the drain multiplier
		 * 
		 * Returns true if out of fuel; false otherwise
		 */
		private function updateFuel():Boolean
		{
			fuel -= fuelDrainRate * fuelDrainMultiplier;
			if (fuel <= 0)
			{
				fuel = 0
				return true;
			}
			return false;
		}
	}
}