package it.lisit.siss.flex.core
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import it.lisit.siss.flex.utility.HashTable;
	
	public class ManagerSound
	{
		private static var instance:ManagerSound;
		public static function getInstance():ManagerSound
		{
			if(instance==null)
			{
				instance = new ManagerSound();
			}
			return instance;
		}
		//
		[Embed(source="message_2.mp3")]
		private var mSoundWarning:Class;
		[Embed(source="message_2.mp3")]
		private var mSoundInfo:Class;
		[Embed(source="message_1.mp3")]
		private var mSoundError:Class;
		
		private const WARNING:Sound = new mSoundWarning() as Sound;
		private const INFO:Sound 	= new mSoundInfo() as Sound;
		private const ERROR:Sound 	= new mSoundError() as Sound;
		
		public var warning:Sound;		 
		public var info:Sound;		 
		public var error:Sound;		 
		//
		private var table:HashTable;		 
		//
		public function ManagerSound()
		{
			if(instance!=null)
			{
				throw new Error("Only one instance");
			}
			table = new HashTable();
		}
		
		public function playStatusBarMessage(type:String,volume:Number = 0.5):void
		{
			var tr:SoundTransform = new SoundTransform(volume);
			var sound:Sound;
			switch(type)
			{
				case ConstStatusBar.INFO:
					sound = (info!=null) ? info : INFO;
					break;
				case ConstStatusBar.ERROR:
					sound = (error!=null) ? error : ERROR;
					break;
				case ConstStatusBar.WARNING:
					sound = (warning!=null) ? warning : WARNING;
					break;
				default :
					sound = (info!=null) ? info : INFO;
					break;
			}
			sound.play(0,0,tr);
		}
		public function addSound(name:String,sound:Sound):void
		{
			table.put(name,sound);
		}
		public function removeSound(name:String):void
		{
			table.removeFromKey(name);
		}
		public function containsSound(name:String):Boolean
		{
			return table.containsKey( name );
		} 
		public function playSound(name:String,volume:Number = 0.5,pan:Number = 0.5,startTime:Number = 0,loops:int = 0):void
		{
			var sound:Sound = table.getValue(name);
			var tr:SoundTransform = new SoundTransform(volume,pan);
			sound.play(startTime,loops,tr);
		}
	}
}