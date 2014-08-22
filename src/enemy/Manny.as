package enemy 
{
	import core.Controller;
	
	/**
	 * ...
	 * @author Alexander Huynh
	 */
	public class Manny extends ABST_Actor 
	{
		
		public function Manny(_controller:Controller, _index:uint,  _difficulty:uint) 
		{
			super(_controller, _index, _difficulty);
		}
		
		override public function step():void
		{
			if (activityTimer > 0)
			{
				activityTimer--;
				if (activityTimer % 30 == 0)
					trace("Enemy " + index + " is waiting with " + (activityTimer / 30) + " second(s) left.");
			}
			else
			{
				var moved:Boolean = false;
				
				switch (room)
				{
					case "1a":
						moved = moveRoom(getRand() > .5 ? "10" : "2");
					break;
				/*	case "1b":
					break;
					case "2":
					break;
					case "3":
					break;
					case "4":
					break;
					case "5":
					break;
					case "6":
					break;
					case "7a":
					break;
					case "7b":
					break;
					case "8a":
					break;
					case "8b":
					break;
					case "9":
					break;
					case "10":
					break;*/
					default: moved = moveRoom("1a");
				}
				if (moved)
					resetTimer();
			}
		}
	}
}