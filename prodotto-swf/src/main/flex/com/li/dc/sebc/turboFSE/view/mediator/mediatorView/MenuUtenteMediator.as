package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.AreaLavoro;
	
	import flash.events.Event;
	
	import it.lispa.siss.library.ui.menustandard.MenuUtente;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.Operatore;

	import com.li.dc.sebc.turboFSE.view.nodeView.AreaTab;

	public class MenuUtenteMediator extends Mediator
	{
		private var menuUtente:MenuUtente;
		public function MenuUtenteMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			menuUtente = (this.view as MenuUtente);
			 
 			menuUtente.visualizzaIccePanelEmbedderFunction = visualizzaIccePanelEmbedderFunction;
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).addEventListener(DataProxyEvent.DATA_UPDATE,onOperatore);
		}
		private function visualizzaIccePanelEmbedderFunction(e:Event):void
		{
			// sposto il tab al primo indice
			//
			var model:FSEModel = FSEModel.getInstance();
			model.enabledTabFascicolo		= false;
			model.enabledTabEventi			= false;
			model.enabledTabTimeLine		= false;
			model.retrieveProxy(ConstDataProxy.DATA_AREATAB).update( 0 );
			//(TurboView.getInstance().retriveMediator(ConstMediator.AREA_TAB).getView() as AreaTab).currentIndex = 0;
		}
		private function onOperatore(e:DataProxyEvent):void
		{
			var ope:Operatore = FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			if(ope!=null)
			{
				menuUtente.codiceFiscaleUtenteVisible	= true;
				menuUtente.nomeUtente			= ope.nome;
				menuUtente.cognomeUtente		= ope.cognome;
				menuUtente.codiceFiscaleUtente	= ope.codiceFiscale;
				var m:FSEModel = FSEModel.getInstance();
				m.retrieveProxy(ConstDataProxy.STATE_AREA_LAVORO).update( AreaLavoro.ACTIVE );
			}
		}
		
	}
}