package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.TabFSEEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.AreaTab;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;

	public class AreaTabMediator extends Mediator
	{
		private var areaTab:AreaTab;
		public function AreaTabMediator()
		{
			super();
			Debug.logDebug("instance AreaTabMediator create");
		}
		override protected function finalize():void
		{
			areaTab.removeEventListener(TabFSEEvent.TAB_FSE_INDEX_CHANGE,onTabIndexChange);
		}
		override protected function initialize( ):void
		{
			areaTab = (this.view as AreaTab);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_AREATAB).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateTabIndex);
			model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateCittadino);
		}
		private function initializeView():void
		{
			areaTab.addEventListener(TabFSEEvent.TAB_FSE_INDEX_CHANGE,onTabIndexChange); 
			var turboView:TurboView = TurboView.getInstance();
			
			turboView.createMediator(ConstMediator.HEADER,ConstMediator.HEADER,areaTab.header);
			/* non cambiare la sequenza. Viene inizializzato prima menuUtente e poi assistito che utilizza menuUtente */
			turboView.createMediator(ConstMediator.MENU_UTENTE,ConstMediator.MENU_UTENTE,areaTab.menuUtente);
			turboView.createMediator(ConstMediator.ASSISTITO_FSE,ConstMediator.ASSISTITO_FSE,areaTab.assistitofse);
			turboView.createMediator(ConstMediator.ROOT_FASCICOLO,ConstMediator.ROOT_FASCICOLO,areaTab.rootfascicolo);
			turboView.createMediator(ConstMediator.ROOT_FLUSSI,ConstMediator.ROOT_FLUSSI,areaTab.rootflussi);
			turboView.createMediator(ConstMediator.ROOT_TIMELINE_HTML,ConstMediator.ROOT_TIMELINE_HTML,areaTab.rootTimelineHtml);
			//turboView.createMediator(ConstMediator.ROOT_TIMELINE,ConstMediator.ROOT_TIMELINE,areaTab.rootTimeline);
			//turboView.createMediator(ConstMediator.CLASSIFICAZIONE,ConstMediator.CLASSIFICAZIONE,areaTab.classificazione);
			turboView.createMediator(ConstMediator.FOOTER,ConstMediator.FOOTER,areaTab.footer);	
		}
		private function onUpdateCittadino(e:DataProxyEvent):void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.enabledTabFascicolo		= true;
			model.enabledTabEventi			= true;
			model.enabledTabTimeLine		= true;
			//model.enabledTabClassificazioni = true;
			model.reloadRootFascicolo		= true;
			model.reloadRootFlussi			= true;
			model.reloadTimeline			= true;	
			//model.reloadClassificazioni		= true;
			model.retrieveProxy(ConstDataProxy.DATA_AREATAB).update( 0 );
		}
		private function onUpdateTabIndex(e:DataProxyEvent):void
		{
			 
			var inx:int	= e.getData() as int;
			if(inx!=areaTab.currentIndex)
			{
				FSEModel.getInstance().oldIndexTab = areaTab.currentIndex; 
				areaTab.currentIndex = inx;
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_CHANGE_TAB,inx);
			}
		}
		private function onTabIndexChange(e:TabFSEEvent):void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_AREATAB).update( e.getIndex() );
		}
	}
}