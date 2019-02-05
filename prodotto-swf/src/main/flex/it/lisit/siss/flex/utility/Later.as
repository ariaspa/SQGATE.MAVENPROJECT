package it.lisit.siss.flex.utility
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Later
	{
		 private static var sprite:Sprite = new Sprite();
		 private static var queueLater:Queue = new Queue();
		 public static function doLater(funLater:Function,prior:uint = 0,...arguments):void
		 {
		 	if(funLater== doLater)throw new Error();
			if(queueLater.size()==0)
				sprite.addEventListener(Event.ENTER_FRAME,int_enterFrame);
			//////////////////////////	
			var delegate:CommandDelegate= new CommandDelegate(funLater,arguments);
			queueLater.offer(delegate,prior);
		 } 
		private static function int_enterFrame(e:Event):void
		{
			sprite.removeEventListener(Event.ENTER_FRAME,int_enterFrame);
			if(queueLater.size()>0)
			{
				var cloneQ:Queue = queueLater.clone();
				queueLater.clear();
				while(!cloneQ.empity())
				{
					CommandDelegate(cloneQ.poll()).execute( );
				}
			}
		}
	}
}