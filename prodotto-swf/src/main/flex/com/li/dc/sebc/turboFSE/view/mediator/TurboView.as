package com.li.dc.sebc.turboFSE.view.mediator
{
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.AreaLavoroMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.AreaTabMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.AreaWaitMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.AssistitoFseMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.BarraIntestazioneMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.BoxFlussiMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.BoxTreeMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.BoxViewFlussiMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.BoxViewMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.ClassificazioneMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.DisciplinaVistaMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.DownTreeMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.FiltriDataMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.FiltriGenericiMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.FooterMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.HeaderMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.HeaderToggleFlussiMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.HeaderToogleMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.IdentificaCittadinoMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.MenuUtenteMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.OpenableVistaMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.PanelClosePDTMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.PanelFiltersMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.PanelFlussiMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.PanelOpenPDTMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.RootFascicoloMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.RootFlussiMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.RootMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.RootTimeLineHtmlMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.UpTreeFlussiMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.UpTreeMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.mediatorView.VisualizzaCittadinoMediator;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.model.MessageMVC;
	import it.lispa.siss.sebc.flex.mvc.view.View;

	public class TurboView extends View
	{
		private static var instance:TurboView;
		public static function getInstance():TurboView
		{
			if(instance == null)
			{
				instance = new TurboView(  ) ;
			}
			return instance;
		}
		public function TurboView()
		{
			super();
			 if (instance != null) throw Error(MessageMVC.SINGLETON_MSG);
			 instance = this;
			 Debug.logDebug("Prima istanzio TurboView");
		}
		/////////////////////////
		 
		override protected function initialize():void
		{
			/* qui creo le classi  */
			addClassMediator(ConstMediator.HEADER, HeaderMediator);
			addClassMediator(ConstMediator.ROOT, RootMediator);
			addClassMediator(ConstMediator.BARRA_INTESTAZIONE, BarraIntestazioneMediator);
			addClassMediator(ConstMediator.AREA_LAVORO, AreaLavoroMediator);
			
			addClassMediator(ConstMediator.AREA_TAB, AreaTabMediator);
			addClassMediator(ConstMediator.AREA_WAIT, AreaWaitMediator);
			
			addClassMediator(ConstMediator.ASSISTITO_FSE, AssistitoFseMediator);
			
			
			
			addClassMediator(ConstMediator.ROOT_FASCICOLO, RootFascicoloMediator);
			//addClassMediator(ConstMediator.ROOT_TIMELINE, RootTimeLineMediator);
			addClassMediator(ConstMediator.ROOT_TIMELINE_HTML, RootTimeLineHtmlMediator);
			
			addClassMediator(ConstMediator.HEADER_TOOGLE, HeaderToogleMediator);
			
			addClassMediator(ConstMediator.BOX_TREE,BoxTreeMediator);
			
			addClassMediator(ConstMediator.UP_TREE,UpTreeMediator);
			addClassMediator(ConstMediator.DOWN_TREE,DownTreeMediator);
			addClassMediator(ConstMediator.DOWN_TREE_FLUSSI,DownTreeMediator);
			
			addClassMediator(ConstMediator.BOX_VIEW,BoxViewMediator);
			
			
			addClassMediator(ConstMediator.ROOT_FLUSSI,RootFlussiMediator);
			addClassMediator(ConstMediator.CLASSIFICAZIONE,ClassificazioneMediator);
			addClassMediator(ConstMediator.FOOTER,FooterMediator);
			addClassMediator(ConstMediator.MENU_UTENTE,MenuUtenteMediator);
			
			addClassMediator(ConstMediator.IDENTIFICA_CITTADINO,IdentificaCittadinoMediator);
			addClassMediator(ConstMediator.VISUALIZZA_CITTADINO,VisualizzaCittadinoMediator);
			
			addClassMediator(ConstMediator.PANEL_FILTER,PanelFiltersMediator);
			addClassMediator(ConstMediator.FILTER_DATA,FiltriDataMediator);
			addClassMediator(ConstMediator.FILTER_GENERICI,FiltriGenericiMediator);
			addClassMediator(ConstMediator.PANEL_OPEN_PDT,PanelOpenPDTMediator);
			addClassMediator(ConstMediator.PANEL_CLOSE_PDT,PanelClosePDTMediator);


			addClassMediator(ConstMediator.OPENABLE_VISTA,OpenableVistaMediator);
			addClassMediator(ConstMediator.DISCIPLINA_VISTA,DisciplinaVistaMediator);
			addClassMediator(ConstMediator.HEADER_TOOGLE_FLUSSI,HeaderToggleFlussiMediator);
			addClassMediator(ConstMediator.BOX_TREE_FLUSSI,BoxFlussiMediator);
			addClassMediator(ConstMediator.BOX_VIEW_FLUSSI,BoxViewFlussiMediator);
			addClassMediator(ConstMediator.UP_TREE_FLUSSI,UpTreeFlussiMediator);


			addClassMediator(ConstMediator.PANEL_FILTER_FLUSSI,PanelFlussiMediator);
			
			
			 
		}
	}
}