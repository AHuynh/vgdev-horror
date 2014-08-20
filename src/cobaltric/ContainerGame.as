package cobaltric
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Alexander Huynh
	 */
	public class ContainerGame extends ABST_Container
	{
		
		public function ContainerGame()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("init!");
			
			/*var format:TextFormat = new TextFormat();
			format.font = "Calibri";
			format.color = 0x000000;
			format.size = 16;*/
			
			var tf_main:TextField = new TextField();
			//tf_main.setTextFormat(format);
			//tf_main.embedFonts = true;
			tf_main.text = "Hello!";
			
			addChild(tf_main);
			tf_main.x = 50;
			tf_main.y = 50;
		}
		
		override public function step():Boolean
		{
			return false;
		}
	}
}
