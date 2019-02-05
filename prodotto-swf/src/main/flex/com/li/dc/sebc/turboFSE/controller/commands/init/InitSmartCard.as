package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.ObserverSmartCard;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;
	import it.lispa.siss.sebc.flex.smartCard.SmartCardManager;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;

	public class InitSmartCard extends Command 
	{
		private var reference:ISequenceReference;
		private var cittadino:Cittadino = null;
		public function InitSmartCard()
		{
			super(); 
		}
		override public function execute(data:Object=null):void
		{
			Debug.logDebug( "InitSmartCard . execute " + data );
			if(data is ISequenceReference)
			{
				reference = data as ISequenceReference;
				var model:FSEModel		= FSEModel.getInstance();
				model.retrieveProxy(ConstDataProxy.DATA_MESSAGE).update("Lettura credenziali operatore");
				//var conf:Configuration 	= model.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
				// tolgo il default  e metto un ascoltatore fake manovrato con la tastiera
				//SmartCardManager.getInstance().smartCardReader 		= new LocalSmartCardReader();
				/*  TurboSmartCardService fornisce i servizi da usare per la lettura della smart card */
				/*   29-10-12
					SmartCardManager non viene più usato, in quanto la lettura delle carte 
					Cittadino e Operatore avvengono on demand 
				*/
				//SmartCardManager.getInstance().service 				= new TurboSmartCardService();
				//SmartCardManager.getInstance().enable 				= true;
				/* il destinatario degli eventi  IManagerObserverOperatore */
				//SmartCardManager.getInstance().addObserver( this );
				Controller.getInstance().executeCommand( ConstCommand.LOAD_OPERATORE, new Responder(resultOperatore,faultOperatore) );
			}
		}
		private function resultOperatore(data:Object):void
		{
			if(data is ResultEvent && (data as ResultEvent).result is Operatore){
				FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).update( (data as ResultEvent).result as Operatore );
				FSEModel.getInstance().retrieveProxy(ConstDataProxy.SMARTCARD_CIT).update( true );
				reference.nextCommand();
			}
		}
		private function faultOperatore(info:Object):void
		{
			var msg:String = MessageManager.getInstance().reader.createMessage(info).message;
			Debug.logDebug( "smartCardOperatoreError :: " +msg); 
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_MESSAGE).update("Carta operatore non leggibile");
			this.cittadino	= null;
		}
		//====================================================================================
		//======= TUTTA ROBA VECCHIA =========================================================
		
		public function smartCardOperatoreReading():void
		{
			Debug.logDebug( "smartCardOperatoreReading" );
		}
		/* Fase in cui la carta operatore è stata letta correttamente */
		public function smartCardOperatoreReady(operatore:Operatore):void
		{
			//Debug.logDebug( "smartCardOperatoreReady" );
			/* rimuovo me stesso come destinatario degli eventi  IManagerObserverOperatore */
			//SmartCardManager.getInstance().removeObserver( this );
			/* il nuovo destinatario degli eventi  IManagerObserverOperatore */
			SmartCardManager.getInstance().addObserver( new ObserverSmartCard() );
		}
		 
		/* Fase in cui la carta Cittadino è stata letta correttamente */
		public function smartCardCittadinoReady(cittadino:Cittadino):void
		{
			this.cittadino	= cittadino;
		}
		/* Fase in cui la lettura della carta operatore ha generato un errore */
		public function smartCardOperatoreError(error:Object):void
		{
			var msg:String = MessageManager.getInstance().reader.createMessage(error).message;
			Debug.logDebug( "smartCardOperatoreError :: " +msg);
			//SmartCardManager.getInstance().removeObserver( this );
			//Controller.getInstance().executeCommand( ConstCommand.GO_HOME );
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_MESSAGE).update("Carta operatore non leggibile");
			this.cittadino	= null;
		}
		
		public function smartCardOperatoreEject():void
		{
			Debug.logDebug( "smartCardOperatoreEject" );
			//SmartCardManager.getInstance().removeObserver( this );
			//Controller.getInstance().executeCommand( ConstCommand.GO_HOME );
			this.cittadino	= null;
		} 
		////////////////////////////////////////////////////////////////////////
		/* Fase in cui la carta Cittadino viene letta per recuperne le credenziali (servizi SOAP, da driver, etc.) */
		public function smartCardCittadinoReading():void
		{
			this.cittadino	= null;
		}
		
		/* Fase in cui la lettura della carta Cittadino ha generato un errore */
		public function smartCardCittadinoError(error:Object):void
		{
			this.cittadino	= null;
		}
		  /* Fase in cui la carta Cittadino viene rimossa dal lettore */
		public function smartCardCittadinoEject():void
		{
			this.cittadino	= null;
		}
	}
}

