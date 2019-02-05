package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.model.vo.TreeEventi;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.view.component.PanelFiltriFlussi;
	
	import it.lispa.siss.library.ui.menustandard.Assets;
	import it.lispa.siss.sebc.flex.graphic.image.ImageDefinition;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.events.CloseEvent;

	public class PanelFlussiMediator extends Mediator
	{
		private var panelFilters:PanelFiltriFlussi; 
		private var changed:Boolean = false;
		private var oldDtIni:Date
		private var currDtIni:Date
		private var oldDtEnd:Date
		private var currDtEnd:Date
		  
		///////////////////////
		private var confIni:String;
		private var confEnd:String;
		public function PanelFlussiMediator()
		{
			super();
		}
		override protected function finalize():void
		{
			panelFilters.removeEventListener(CloseEvent.CLOSE,onClose);
			panelFilters.removeEventListener(TurboEvent.CHANGE_FILTER_DATA,onChangeData);
			FSEModel.getInstance().retrieveProxy( ConstDataProxy.DATA_CITTADINO ).removeEventListener(DataProxyEvent.DATA_UPDATE,onUpdate);
			//panelFilters.removeEventListener(TurboEvent.CLICK_BUTTON_FILTER,onClick);
		}
		override protected function initialize( ):void
		{
			panelFilters = (this.view as PanelFiltriFlussi);
			initializeData();
			initializeView();
		}
		private function isMajorAndSetDate(dataini:Date,dateEnd:Date):Date
		{
			if(UtilDate.isMajor(dataini, dateEnd))
			{
				return new Date(dateEnd.getFullYear(),dateEnd.getMonth(),dateEnd.getDate(),dateEnd.getHours(),dateEnd.getMinutes(),dateEnd.getSeconds());
			}
			return dataini;
		}
		private function onUpdate(e:DataProxyEvent):void
		{
			if(confIni!=null && confEnd!=null)
			{
				var conf:Configuration 	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
				conf.dataInizioFlussi = confIni;
				conf.dataFineFlussi   = confEnd;    
			}
			initFiltriPanel();
		}
		private function initFiltriPanel():void
		{
			var conf:Configuration 	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
			if(confIni==null)
			{
				confIni= conf.dataInizioFlussi;
			}
			if(confEnd==null)
			{
				confEnd = conf.dataFineFlussi;
			}
			var confDataIni:Date	= UtilDate.fromStringToDate( confIni );
			var confDataEnd:Date	= UtilDate.fromStringToDate( confEnd );
			var today:Date			= new Date();
			confDataEnd				= isMajorAndSetDate(confDataEnd,today);
			confDataIni				= isMajorAndSetDate(confDataIni,confDataEnd);
			//-- -- --
			panelFilters.dateInizioFlussi	= confDataIni;
			panelFilters.dateFineFlussi		= confDataEnd;
			//-- -- --
			currDtIni	= panelFilters.dateInizioFlussi;
			currDtEnd	= panelFilters.dateFineFlussi;
			oldDtIni 	= panelFilters.dateInizioFlussi;
			oldDtEnd 	= panelFilters.dateFineFlussi;
		}
		private function initializeData():void
		{
			FSEModel.getInstance().retrieveProxy( ConstDataProxy.DATA_CITTADINO ).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdate );
			initFiltriPanel();
		}
		private function initializeView():void
		{
			panelFilters.title					= "Pannello filtri";
			panelFilters.styleName				= "windowFilter";
			//panelFilters.iconButtonAggiorna		= ImageDefinition.ICONA_BOTTONE_AGGIORNA_16X16;
			panelFilters.iconButtonAggiorna		= Assets.ICO_AZIONI_UTENTE;
			panelFilters.showCloseButton		= true;
			panelFilters.addEventListener(CloseEvent.CLOSE,onClose);
			panelFilters.addEventListener(TurboEvent.CHANGE_FILTER_DATA,onChangeData);
		}
		private function onChangeData(e:TurboEvent):void
		{
			var today:Date	= new Date();
			var end:Date	= isMajorAndSetDate(panelFilters.dateFineFlussi,today);
			var ini:Date	= isMajorAndSetDate(panelFilters.dateInizioFlussi,panelFilters.dateFineFlussi);
			
			panelFilters.dateInizioFlussi	= ini;
			panelFilters.dateFineFlussi		= end;
			  
		}
		private function onClose(e:CloseEvent):void
		{
			/* la vecchia data iniziale */
			oldDtIni				= currDtIni;
			/* la vecchia data finale */
			oldDtEnd				= currDtEnd;
			/* la nuova data iniziale */
			currDtIni				= panelFilters.dateInizioFlussi;
			/* la nuova data finale */ 
			currDtEnd				= panelFilters.dateFineFlussi;
			/* la nuova data iniziale è maggiore alla vecchia */
			var isIniMajor:Boolean		= UtilDate.isMajor(currDtIni,oldDtIni);
			var isIniEqual:Boolean		= UtilDate.isEquals(currDtIni,oldDtIni);
			var isMajorIni:Boolean		= isIniMajor || isIniEqual;
			/* la nuova data finale è minore alla vecchia  */
			var isEndMinor:Boolean		= UtilDate.isMajor(oldDtEnd,currDtEnd);
			var isEndEqual:Boolean		= UtilDate.isEquals(currDtEnd,oldDtEnd);
			var isMinorEnd:Boolean		= isEndMinor || isEndEqual;	
			
			var form:String			= UtilDate.FORMATTER_STRING_DATA;
			var sCurIni:String		= UtilDate.formatterDate( currDtIni,form );	 
			var sCurEnd:String		= UtilDate.formatterDate( currDtEnd,form );
			var m:FSEModel 			= FSEModel.getInstance();
			var conf:Configuration	= m.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
			conf.dataInizioFlussi	= sCurIni;	 
			conf.dataFineFlussi		= sCurEnd;
			// pulisco la parte delle viste 
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_FLUSSI_SELECT).update( null );
			/* chiudo il pannello */
			Controller.getInstance().executeCommand(ConstCommand.CHIUDI_PANEL_FILTRI, panelFilters );
			/* se il range di tempo è uguale o minore del precedente */ 
			if(isMajorIni && isMinorEnd)
			{
				var tree:TreeEventi =  m.retrieveProxy(ConstDataProxy.DATA_TREE_FLUSSI).getData() as TreeEventi;
				// filtrare la lista
				tree = Utils.filtraFlussi( tree , currDtIni, currDtEnd); 
				m.retrieveProxy(ConstDataProxy.DATA_TREE_FLUSSI).update( tree ); 
				m.retrieveProxy(ConstDataProxy.HEADER_FLUSSI_TEXT).update( Utils.createLabelFiltri(conf.dataInizioFlussi,conf.dataFineFlussi ) );
			}else
			{
				Controller.getInstance().executeCommand(ConstCommand.DAMMI_FLUSSI );
			}
		}
	}
}