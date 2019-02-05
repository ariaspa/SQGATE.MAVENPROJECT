package it.lisit.siss.agent
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	///////////////////////////////////////////////////////////////////
	//[Event(name="status", type="flash.events.StatusEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	[Event(name="asyncError", type="flash.events.AsyncErrorEvent")]
	
	[Event(name="send", type="it.lispa.siss.sebc.flex.agent.AgentStateEvent")]
	[Event(name="busy", type="it.lispa.siss.sebc.flex.agent.AgentStateEvent")]
	[Event(name="free", type="it.lispa.siss.sebc.flex.agent.AgentStateEvent")]
	[Event(name="synchronousEvent", type="it.lispa.siss.sebc.flex.agent.AgentSynchronousEvent")]
	
	[Event(name="agentReceptionComplete", type="it.lispa.siss.sebc.flex.agent.AgentReceptionEvent")]
	[Event(name="agentReceptionData", type="it.lispa.siss.sebc.flex.agent.AgentReceptionEvent")]
	
	public class Agent extends EventDispatcher
	{
		// 38 per avere un margine di sicurezza  AgentStateEvent
		private static const MAXKB:uint	= 38;
		private static const KILOBYTE:uint	= 1024;
		public function get name():String{return _name;}
		public function get isConnect():Boolean{return _isConnect;}
		////////////////////////////////////
		private var _name:String;
		private var _connection:LocalConnection;
		private var _isConnect:Boolean;
		private var _isBusy:Boolean;
		private var _queueBusy:Array;
		private var listSender:Dictionary;
		
		public function Agent(nameConnection:String)
		{
			super( this );
			_name = nameConnection;
			listSender  			= new Dictionary();
			_connection 			= new LocalConnection();
			_connection.client 		= new PrivateReceive(callBackReceiveData); 
			_isConnect 				= false;
			_isBusy 				= false;
		}
		
		public function allowInsecureDomain(domain:String):void
		{
			_connection.allowInsecureDomain(domain)
		}
		
		public function allowDomain(domain:String):void
		{
			_connection.allowDomain(domain);
		}
		
		public function startConnection():void
		{
			try{
				_isConnect = true;
				_connection.connect( name );
			}catch(e:Error)
			{
				_isConnect 	= false;
				throw e;
			}
		}
		// silent error
		public function closeConnection():void
		{
			_isConnect 	= false;
			try{
				//if(_isBusy)
				_connection.close();
			}catch(e:Error){}
		}
		public function send(target:String,parameters:Array=null):void
		{
			if(!_isBusy)
			{
				prepareToInternalSend(target,parameters);	
				/* dispacciato ogni volta che viene fatto un send esplicito o un implicito dopo che lo stato di busy è finito*/				
				dispatchEvent(new AgentStateEvent(AgentStateEvent.SEND,target));
			}else
			{
				if(_queueBusy==null)
				{
					_queueBusy	= new Array();
				}
				_queueBusy.push( {target:target,parameters:parameters} );
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////
		private function callBackReceiveData(sender:String,info:String,bytes:ByteArray = null):void
		{
			if(info=="null")
			{
				// ping mode 
			}else
			{
				if(listSender[sender] == null)
				{
					listSender[sender] = {listData:new Array(),part:0,tot:0,inReception:false};
				}
				var splitInfo:Array	= info.split(":"); 
				var part:uint		= Number(splitInfo[0]);
				var total:uint		= Number(splitInfo[1]);
				listSender[sender].part = part;
				listSender[sender].tot 	= total;
				listSender[sender].listData.push( bytes );
				//
				if(!listSender[sender].inReception && total>1)
				{
					listSender[sender].inReception = true;
					dispatchEvent(new AgentReceptionEvent(AgentReceptionEvent.AGENT_RECEPTION_DATA,sender));
				}
				if(listSender[sender].part == listSender[sender].tot)
				{
					var parameters:Array 	= decodeParameters(createReceiveData(listSender[sender].listData));
					listSender[sender] 		= null;
					delete listSender[sender];
					sendEventReceive(sender,parameters);
				} 
			}
		}
		private function createReceiveData(listData:Array):ByteArray
		{
			var result:ByteArray = new ByteArray();
			for(var i:uint = 0; i<listData.length;i++)
			{
				var part:ByteArray = listData[i];
				part.position      = 0;
				result.writeBytes(part,0,part.length);
			}
			return result;
		}
		private function sendEventReceive(sender:String,parameters:Array=null):void
		{
			dispatchEvent(new AgentReceptionEvent(AgentReceptionEvent.AGENT_RECEPTION_COMPLETE,sender,parameters));
		}
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			if(type == AsyncErrorEvent.ASYNC_ERROR 
			|| type == SecurityErrorEvent.SECURITY_ERROR)
			{
				_connection.addEventListener( type , redirectListener ,useCapture , priority, useWeakReference);
			} 
			super.addEventListener( type , listener ,useCapture , priority, useWeakReference);
		} 
		private function redirectListener(e:Event):void
		{
			e.stopImmediatePropagation();
			dispatchEvent( e );
		}
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			super.removeEventListener( type , listener ,useCapture ); 
			if(type == AsyncErrorEvent.ASYNC_ERROR 
			|| type == SecurityErrorEvent.SECURITY_ERROR)
			{
				if(!super.hasEventListener(type))
				{
					_connection.removeEventListener( type , redirectListener ,useCapture );
				}
			} 
		}
		private function prepareToInternalSend(target:String,parameters:Array=null):void
		{
			var byte:ByteArray; 
			if(parameters!=null)
			{
				byte = encodeParameters(parameters);
			}
			prepareMultipleSends(target,byte);
		}
		private function prepareMultipleSends(target:String,bytes:ByteArray=null):void
		{
			var listPackage:Array;
			var nameConnection:String	= getNameConnection(target);
			if(bytes!=null)
			{
				var kb:uint	= Math.ceil(getKiloBytes(bytes)); 
				if(kb > MAXKB)
				{
					_isBusy						= true;
					dispatchEvent(new AgentStateEvent(AgentStateEvent.BUSY,nameConnection));
					listPackage 			= getListPackage(bytes);
				}else
				{
					listPackage = [bytes];
				}	
			}else
			{
				listPackage = new Array();
			}
			var multiple:MultipleSender = new MultipleSender(_connection,listPackage,name,nameConnection);
			multiple.addEventListener("endSend",onEndSend);
			multiple.send(); 
		}
		private function onEndSend(e:Event):void
		{
			var multiple:MultipleSender = e.target as MultipleSender;
			multiple.removeEventListener("endSend",onEndSend);
			//
			// status AgentSynchronousEvent
			var type:String 				= AgentSynchronousEvent.SYNCHRONOUS_EVENT;
			var target:String				= multiple._target;
			var lev:uint					= (multiple.error != null && multiple.error.length>0) ? 0 : ((multiple.warning!=null && multiple.warning.length>0)? 1 : 2);
			var level:String				= (lev==0) ? "error" : ((lev==1)? "warning" : "status");
			var code:String					= (lev==0) ? multiple.error : ((lev==1)? multiple.warning : "null");
			var event:AgentSynchronousEvent = new AgentSynchronousEvent(type,target,level,code);
			this.dispatchEvent(event);
			//
			if(_isBusy)
			{
				_isBusy						= false;
				/* a conclusione del multiple send */
				dispatchEvent(new AgentStateEvent(AgentStateEvent.FREE,multiple._target));
			}
			if(_queueBusy!= null && _queueBusy.length > 0)
			{
				var object:Object = _queueBusy.shift();
				send(object.target,object.parameters); 
			}
		}
		private function getListPackage(bytes:ByteArray):Array
		{
			bytes.position			= 0;
			var startPosition:uint	= 0;
			var copiati:uint		= 0;
			var lenBytes:uint		= bytes.length;
			var list:Array			= new Array();
			var maxForPackage:uint 	= KILOBYTE*MAXKB;
			var _do:Boolean			= true;
			while(_do)
			{
				var _package:ByteArray	= new ByteArray();
				var start:uint			= startPosition;
				var maxpack:uint		= maxForPackage;
				if((copiati+maxForPackage) >= lenBytes)
				{
					maxpack = lenBytes-copiati;
					_do		= false;
				}			
				_package.writeBytes(bytes,start,maxpack);
				copiati += maxpack; 
				startPosition = copiati;
				list.push( _package );	
			}
			return list;
		}
		private function getKiloBytes(bytes:ByteArray):Number
		{
			if(bytes.length>0)
			{
				//  1 B = byte = 8 bit, 1024 B = 1 kB = 1 kilobyte
				return bytes.length/KILOBYTE;
			}
			return 0;
		}
		
		protected function decodeParameters(bytes:ByteArray):Array
		{
			bytes.position			= 0;
			var parameters:Array 	= bytes.readObject() as Array;
			return parameters;
		}
		protected function encodeParameters(parameters:Array):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject( parameters );
			return bytes;
		}
		protected function getNameConnection(target:String):String
		{
			//var targetNotUnder:Boolean	= (target.indexOf("_") != 0);
			//return targetNotUnder ? "_" + target : target;
			return target;
		} 
	}
}
	import it.lispa.siss.sebc.flex.agent.Agent
	import flash.events.Event;
	import it.lispa.siss.sebc.flex.agent.AgentReceptionEvent;
	import flash.utils.ByteArray;
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.events.StatusEvent;
	
class PrivateReceive
{
	private var _callback:Function;
	public function PrivateReceive(callback:Function)
	{
		_callback = callback;
	}
	public function receiveData(sender:String,info:String,zipParameters:ByteArray = null):void
	{
		_callback(sender,info,zipParameters);
	}
}

class MultipleSender extends EventDispatcher
{
	private var listPackage:Array;
	
	public var _name:String;
	public var _conn:LocalConnection;
	private var index:uint;
	private var total:uint;
	private var wait:Boolean;
	private var _s:Sprite;
	public function get error():String{return _err;}
	public function get warning():String{return _warn;}
	private var _warn:String;
	private var _err:String;
	public var _target:String;
	// new MultipleSender(_connection,listPackage,name,target);
	public function MultipleSender(connection:LocalConnection,listPackage:Array,name:String,target:String)
	{
		super(this);
		this._conn			= connection;
		this._target 		= target;
		this._name 			= name;
		this.listPackage 	= listPackage;
		total				= this.listPackage.length;
		index				= 0;
		wait				= false;
		_s					= new Sprite();
		_warn				= "";
		this._conn.addEventListener(StatusEvent.STATUS,onStatusEvent);
	}
	public function send():void
	{
		_s.addEventListener(Event.ENTER_FRAME,onEnterFrame);
	}
	private function onStatusEvent(e:StatusEvent):void
	{	
		try{
			if(e.level=="error")
			{
				// mi fermo scarico tutto e mando l'evento
				clearListener();
				_err = ""+e.code;
				this.dispatchEvent( new Event("endSend") );
			}else if(e.level=="warning")
			{
				// ne tengo traccia ma vado avanti a spedire
				var cd:String = "|package:"+index+",code:";
				if(e.code !=null)
				{
					cd += e.code;
				}else
				{
					cd +="null";
				}
				_warn += cd;
				wait = false;
			}else
			{
				if(index<total)
				{
					wait = false;
				}else
				{
					// stop tutto è andato tutto a buon fine
					clearListener();
					// setta le variabili pubbliche e manda l'evento
					this.dispatchEvent( new Event("endSend") );
				}	
			}
		}catch(e:Error)
		{
			clearListener();
			_err = ""+e.message;
			this.dispatchEvent( new Event("endSend") );
		}
	} 
	private function clearListener():void
	{
		_s.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		//this._conn.removeEventListener(StatusEvent.STATUS,onStatusEvent);
	}
	private function partialSend():void
	{
		var _package:ByteArray;
		if(total>0)
		{
			_package	= listPackage[index];
		}
		var info:String	= getInfo(index,total);
		index++;
		if(_package==null)
		{
			_conn.send(this._target ,"receiveData",this._name, info);
		}else
		{
			_conn.send(this._target ,"receiveData",this._name, info, _package);
		}
	}
	private function onEnterFrame(e:Event):void
	{
		if(!wait)
		{
			wait = true;
			partialSend();
		}
	}
	private function getInfo(index:uint,total:uint):String
	{
		if(total==0)return "null";
		var tot:String	= ":"+total;
		var part:String	= ""+(index+1);
		return part+tot;
	}
}