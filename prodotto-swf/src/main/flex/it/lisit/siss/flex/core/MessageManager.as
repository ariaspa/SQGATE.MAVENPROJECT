package it.lisit.siss.flex.core
{
	import it.lisit.siss.flex.sebwebsiss;
	import it.lisit.siss.flex.utility.Queue;
	use namespace sebwebsiss;
	//
	 
	public class MessageManager 
	{
		 
		/////////////////////////////////////////////////
		private static var instance:MessageManager;
		/**
		 * 
		 * @return Il riferimento Singleton al MessageManager
		 * 
		 */		
		public static function getInstance():MessageManager
		{
			if(instance==null)
			{
				instance = new MessageManager();
			}
			return instance;
		}
		//////////////////////////////////////////////
		public var reader:TransformerObjects;
		private var defaultReader:TransformerObjects;
		private var queue:Queue;
		private var listUser:Array;
		private var busy:Boolean;
		private var currBlock:Object;
		public function MessageManager( )
		{
			if(instance!=null)
			{
				throw new Error("Only one instance");
			}
			busy			= false;
			listUser 		= new Array();
			queue 			= new Queue();
			defaultReader 	= new TransformerObjects();
		}
		/**
		 * Cancella la lista di tutti gli user dei messaggi
		 *   
		 * @return void
		 */		
		public function clearUsers( ):void
		{
			listUser 		= new Array();
		}
		/**
		 * Aggiunge un'utente al manager in coda a quelli esistenti
		 * @param user IUserMessage, l'utente interessato ai messaggi
		 * @return void
		 * @see it.lisit.siss.flex.core.IUserMessage;
		 */		
		public function addUser(user:IUserMessage):void
		{
			internalAddUser( user );
		}
		/**
		 * Rimuove dal manager l'utente specificato
		 * @param user IUserMessage, l'utente interessato ai messaggi
		 * @return void
		 * 
		 */		
		public function removeUser(user:IUserMessage):void
		{
			 for(var i:uint = 0;i<listUser.length;i++)
			 {
			 	var envelopeUser:Object = listUser[i];
			 	if(envelopeUser.user == user)
			 	{
			 		listUser.splice(i,1);
			 		break;
			 	}
			 }
		}
		/**
		 * La visibiltà di questo metodo è assicurata  dal namespace sebwebsiss
		 * 
		 * Aggiunge un'utente al manager in una posizione di priorità 
		 * @param user IUserMessage, l'utente interessato ai messaggi
		 * @param priority uint, la priorità dell'utente all'interno del manager
		 * in caso non venisse passato nessuna priorità il valore di default è 1000 
		 * 
		 */		
		sebwebsiss function internalAddUser(user:IUserMessage,priority:uint=1000):void
		{
			removeUser(user);
			var envelopeUser:Object = {user:user,priority:priority};
			listUser.push( envelopeUser );
			listUser = listUser.sortOn("priority",Array.NUMERIC);
		}
		/**
		 * Aggiunge alla coda del Manager i messaggi da passare agli user IUserMessage 
		 * Quando un oggetto messaggio viene aggiunto, esso viene trasformato
		 * in un object MessageObject dalla proprietà reader del manager quando essa è valorizzata, .
		 *  
		 * @param vo Object, un oggetto che rappresenta un messaggio
		 * @see it.lisit.siss.flex.core.IUserMessage;
		 * @see it.lisit.siss.flex.core.TransformerObjects;
		 * @see it.lisit.siss.flex.core.MessageObject;
		 */		
		public function addMessage(vo:Object):void
		{
			var read:TransformerObjects 	= (reader==null) ? defaultReader : reader;
			var currMessage:MessageObject	= read.readMessage( vo );
			analyze( currMessage );
		}
		//////////////////////////////////////////////////////////////////////////
		private function analyze( currMessage:MessageObject ):void
		{
			var list:Array = new Array();
			for(var i:uint = 0;i<listUser.length;i++)
			{
				var envelopeUser:Object = listUser[i];
				var user:IUserMessage	= envelopeUser.user;
				var result:Boolean 		= user.analyze( currMessage.type );
				if(result)
				{
					list.push( {user:user,message:currMessage} );
				}
			}
			if(list.length>0)
			{
				queue.offer( {index:0,list:list} );
			}
			startBlock();
		}
		//////////////////////////////////////////////////////////////////////////
		private function startBlock():void
		{
			if(!queue.empity() && !busy)
			{
				busy = true;
				currBlock = queue.poll();
				playUser();
			}
		}
		//////////////////////////////////////////////////////////////////////////
		private function playUser():void
		{
			var user:IUserMessage 		= currBlock.list[currBlock.index].user;
			var message:MessageObject 	= currBlock.list[currBlock.index].message;
			user.useMessage( new EnvelopeMessage(message,completeUse,clearMessages) );
		} 
		//////////////////////////////////////////////////////////////////////////
		private function completeUse():void
		{
			if(currBlock!=null)
			{
				currBlock.index++;
				if(currBlock.index<currBlock.list.length)
				{
					 playUser();
				}else
				{
					busy = false;
					startBlock();
				}
			}
		}
		//////////////////////////////////////////////////////////////////////////
		public function clearMessages():void
		{
			busy 		= false;
			currBlock	= null;
			queue.clear();
		} 
	}
}
	import it.lisit.siss.flex.core.MessageObject;
	import it.lisit.siss.flex.core.IEnvelopeMessage;
	

class EnvelopeMessage implements IEnvelopeMessage
{
	private var  stopUse:Function;
	private var  propagation:Function;
	private var  message:MessageObject;
	public function EnvelopeMessage(message:MessageObject,stopUse:Function,propagation:Function)
	{
		this.message			= message;
		this.stopUse			= stopUse;
		this.propagation		= propagation;
	}
	public function getMessage():MessageObject{return this.message;}
	public function completeUse():void
	{
		stopUse();
	}
	public function stopPropagation():void
	{
		propagation();
	}
}