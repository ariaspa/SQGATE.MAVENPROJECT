package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	
	import it.lispa.siss.library.remoting.icce.IcceInvokeEvent;
	import it.lispa.siss.library.remoting.icce.IccePanelEmbedder;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	
	import mx.collections.ArrayCollection;

	public class AssistitoFseMediator extends Mediator
	{
		private var assistito:IccePanelEmbedder;
		public function AssistitoFseMediator()
		{
			super();
			Debug.logDebug("instance AssistitoFseMediator create");
		}
		override protected function finalize():void
		{
			
		}
		override protected function initialize():void
		{
			assistito = this.view as IccePanelEmbedder;
			initializeData();	
			initializeView();	
		}		    
		private function initializeData():void
		{
			//var model:FSEModel = FSEModel.getInstance();
			//model.retrieveProxy(ConstDataProxy.STATE_ASSISTITO_FSE).addEventListener(DataProxyEvent.DATA_UPDATE,changeState);
		} 
		private function changeState(e:DataProxyEvent):void
		{
			//assistito.currentState = e.getData() as String;
		}
		private function initializeView():void
		{
			if(assistito!=null)
			{
				//assistito.source				= "/nicce/nicce-panel.swf";
				assistito.local					= true;
				assistito.showLivelloEstrazione	= true;
				assistito.livelloEstrazione		= IccePanelEmbedder.LIVELLO_ESTRAZIONE_ESTESO;
				var turboViev:TurboView = TurboView.getInstance();
				//assistito.menuUtente	= turboViev.retriveMediator(ConstMediator.MENU_UTENTE).getView() as MenuUtente;
				assistito.addEventListener(IcceInvokeEvent.INVOKE_RESULT,onResult);
				assistito.addEventListener(IcceInvokeEvent.INVOKE_FAULT,onFault);
			}
			//turboViev.createMediator(ConstMediator.IDENTIFICA_CITTADINO,ConstMediator.IDENTIFICA_CITTADINO,assistito.identificaCittadino ); 
			//turboViev.createMediator(ConstMediator.VISUALIZZA_CITTADINO,ConstMediator.VISUALIZZA_CITTADINO,assistito.visualizzaCittadino ); 
			
		} 
		
		private function onFault(e:IcceInvokeEvent):void
		{
			
		}
		private function onResult(e:IcceInvokeEvent):void
		{
			if(e.result!=null && e.result is ArrayCollection)
			{
				var arr : ArrayCollection		= (e.result as ArrayCollection);
				if(arr.length>0)
				{
					var citt:Object 			= arr[0];
					var cittadino : Cittadino	= new Cittadino();
					cittadino.nome				= citt.nomeCittadino;
					cittadino.cognome			= citt.cognomeCittadino;
					cittadino.codiceSesso		= citt.sessoCittadino;
					cittadino.dataNascita		= citt.dataNascitaCittadino;
					cittadino.codiceFiscale		= citt.codiceFiscaleCittadino;
					cittadino.smartCard.serialNumber = citt.crsSerialNumber;
					//cittadino.codiceFiscale	= citt.codiceFiscaleCittadino;
					FSEModel.getInstance().retrieveProxy( ConstDataProxy.DATA_CITTADINO ).update( cittadino );
				}	
			}
		}
	}
}










