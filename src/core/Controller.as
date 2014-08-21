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
			fuelDrainRate = 0.005;
			fuelDrainMultiplier = 1;
			fuelDrainMultiplierLimit = 5;
			
			// setup shutters
			shutters = [false, false];
			
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
			shutters[e.target.shutterInd] = !shutters[e.target.shutterInd];
			
			var recolor:ColorTransform = new ColorTransform();
			
			if (shutters[e.target.shutterInd])
			{
				recolor.color = 0x44CC44;
				fuelDrainMultiplier++;
			}
			else
			{
				recolor.color = 0xCC4444;
				fuelDrainMultiplier--;
			}
			
			cg.shutters[e.target.shutterInd].transform.colorTransform = recolor;
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