package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.ConstStatus;
	import it.lispa.siss.sebc.flex.messages.Message;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.smartCard.IManagerObserverCittadino;
	import it.lispa.siss.sebc.flex.smartCard.IManagerObserverOperatore;
	import it.lispa.siss.sebc.flex.smartCard.IManagerObserverTutore;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;

	public class ObserverSmartCard implements IManagerObserverCittadino, IManagerObserverOperatore, IManagerObserverTutore
	{
		public function ObserverSmartCard()
		{
			Debug.logDebug( "ObserverSmartCard instance" );
		}

		public function smartCardCittadinoReading():void
		{
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.SMARTCARD_CIT).update( false );
		}
		public function smartCardCittadinoReady(cittadino:Cittadino):void
		{
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.SMARTCARD_CIT).update( false );
			Controller.getInstance().executeCommand(ConstCommand.SMART_CARD_CITT_READY,cittadino);
		}
		public function smartCardCittadinoError(error:Object):void
		{
			var model:FSEModel		= FSEModel.getInstance();
			if(model.retrieveProxy( ConstDataProxy.DATA_OPERATORE ).getData() !=null)
			{
				MessageManager.getInstance().addMessage( new Message(ConstStatus.WARNING,"C'è un errore nella lettura della smart card cittadino",ConstStatus.WARNING) );
			}
			var msg:String = MessageManager.getInstance().reader.createMessage(error).message;
			Debug.logDebug( "ObserverSmartCard C'è un errore nella lettura della smart card cittadino " +msg);
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.SMARTCARD_CIT).update( true );
		}
		
		public function smartCardCittadinoEject():void
		{
			var model:FSEModel		= FSEModel.getInstance();
			var citt:Cittadino 		= model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			if(citt!=null)
			{
				Debug.logDebug( "TOLTO LE INFORMAZIONI DI PRESENZA CARTA SUL CITTADINO ");
				citt.smartCard = null;
			} 
			model.retrieveProxy(ConstDataProxy.SMARTCARD_CIT).update( true );
		}
		
		
		// OPERATORE //
		
		public function smartCardOperatoreReading():void
		{
			
		}
		
		public function smartCardOperatoreReady(operatore:Operatore):void
		{
			//FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).update( operatore );
			//FSEModel.getInstance().retrieveProxy(ConstDataProxy.STATE_STACK).update( "visualizza" );
		}
		
		public function smartCardOperatoreError(error:Object):void
		{
			 var model:FSEModel		= FSEModel.getInstance();
			 
			 var msg:String = MessageManager.getInstance().reader.createMessage(error).message;
			 Debug.logDebug( "ObserverSmartCard C'è un errore nella lettura della smart card Operatore " +msg);
			 
			 model.retrieveProxy( ConstDataProxy.DATA_OPERATORE ).update( null );
			 model.retrieveProxy( ConstDataProxy.DATA_MESSAGE ).update("Carta operatore non leggibile");
			 model.retrieveProxy( ConstDataProxy.STATE_STACK ).update( "attesa" );
		}
		
		public function smartCardOperatoreEject():void
		{
			var model:FSEModel		= FSEModel.getInstance();
			model.retrieveProxy( ConstDataProxy.DATA_MESSAGE ).update("carta operatore disinserita");
			model.retrieveProxy( ConstDataProxy.STATE_STACK ).update( "attesa" );
			model.retrieveProxy( ConstDataProxy.DATA_OPERATORE ).update( null );
			model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).update( null );
		}
		
		
		
		
		
		
		
		
		public function smartCardGenitoreTutoreReading():void
		{
		}
		
		public function smartCardGenitoreTutoreReady(genitoreTutore:Cittadino):void
		{
		}
		
		public function smartCardGenitoreTutoreError(error:Object):void
		{
		}
		
		public function smartCardGenitoreTutoreEject():void
		{
		}
		
	}
}