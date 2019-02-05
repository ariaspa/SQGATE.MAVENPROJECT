package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.nodeView.HeaderToggleFlussi;
	
	import it.lisit.siss.flex.server.common.graphic.ImageDefinition;
	import it.lispa.siss.library.ui.menustandard.Assets;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class HeaderToggleFlussiMediator extends Mediator
	{
		private var header:HeaderToggleFlussi;
		public function HeaderToggleFlussiMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			header = (this.view as HeaderToggleFlussi);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			///////////////////////////////////////////////////////////////////
			header.iconButtonAggiorna 	= Assets.ICO_RICERCA;
			//header.iconButtonAggiorna 	= ImageDefinition.ICONA_BOTTONE_AGGIORNA_16X16;
			header.labelButtonAggiorna	= "Aggiorna";
			header.labelButtonFiltri	= "Filtri eventi";
			var m:FSEModel	= FSEModel.getInstance();
			m.retrieveProxy(ConstDataProxy.HEADER_FLUSSI_TEXT).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdate);
		}
		private function onUpdate(e:DataProxyEvent):void
		{
			header.textMessage	= e.getData() as String;
		}
		private function initializeView():void
		{
			header.addEventListener(TurboEvent.CLICK_BUTTON_AGGIORNA,onAggiorna);
			header.addEventListener(TurboEvent.CLICK_BUTTON_FILTER,onFiltri);
		}
		private function onAggiorna(e:TurboEvent):void
		{
			Alert.yesLabel 		= "Si";
			var body:String		= "L'aggiornamento comporta la ricreazione dell'albero degli eventi e l'eliminazione di eventuali dettagli di questi, inclusi i documenti visualizzati, sei sicuro di voler continuare?";
			var title:String	= "Attenzione";
			Alert.show(body,title,Alert.YES | Alert.NO,null,confermaAggiorna,ImageDefinition.ICONA_WARNING,Alert.NO);
		}
		private function onFiltri(e:TurboEvent):void
		{
			Controller.getInstance().executeCommand(ConstCommand.APRI_PANEL_FILTRI_FLUSSI);
		}
		private function confermaAggiorna(event:CloseEvent):void 
		{
			if (event.detail == Alert.YES) 
			{
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_FLUSSI);
			}
		}
	}
}