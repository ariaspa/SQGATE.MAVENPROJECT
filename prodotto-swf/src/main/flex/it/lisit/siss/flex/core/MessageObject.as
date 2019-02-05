package it.lisit.siss.flex.core
{
	public class MessageObject  
	{
		private var _type:String;
		public function get type():String{return _type;}
		private var _title:String;
		public function get title():String{return _title;}
		private var _message:String;
		public function get message():String{return _message;}
		private static var counterId:uint = 0;
		private var _id:uint;
		public function get id():uint{return _id;}
		public function MessageObject(title:String,message:String,type:String)
		{
			_id 			= createId();
			this._title		= title;
			this._message	= message;	
			this._type		= type;	
		}
		private function createId():uint
		{
			return counterId++;
		}
	}
}