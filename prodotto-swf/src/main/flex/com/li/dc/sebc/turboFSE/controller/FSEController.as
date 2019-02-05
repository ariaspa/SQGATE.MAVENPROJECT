package com.li.dc.sebc.turboFSE.controller
{

	import com.li.dc.sebc.turboFSE.controller.commands.AggiornaChangeTab;
	import com.li.dc.sebc.turboFSE.controller.commands.AggiornaFascicoloCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.AggiornaFlussiCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.ApriPanelFiltriCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.ApriPanelFiltriFlussiCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.AutorizzaDCECommand;
	import com.li.dc.sebc.turboFSE.controller.commands.ChiudiPanelFiltriCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.ExpandViewCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.FilterDataTreeCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.GoHomeCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.GoTemporaleCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.LoadElencoComuniCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.LoadGadoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.PushMementoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.RedoMementoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.ResetIdentificaCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.RichiediUrlImmagineCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.SmartCardCittReadyCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.UndoMementoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.UpdateContenFolderCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.UpdateDownItemCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.UpdateFiltriCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.UpdateFlussiCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.UpdateFolderCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.VisualizzaValidateErrorCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.crm.OttieniTestoRefertoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.fse.RichiediUrlTestoRefertoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.init.ConfigDebugCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.init.ConfigStartCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.init.InitSmartCard;
	import com.li.dc.sebc.turboFSE.controller.commands.init.InterrogaAscoltatoreCDA2Command;
	import com.li.dc.sebc.turboFSE.controller.commands.init.InterrogaAscoltatoreTestualeCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.init.LoadConfigurationCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.init.LoadElencoProvince;
	import com.li.dc.sebc.turboFSE.controller.commands.init.LoadParametriVariabiliCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.init.LoadQueryCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.init.StartApplicationCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.pdt.AddPdtInFascicolo;
	import com.li.dc.sebc.turboFSE.controller.commands.pdt.ApriPDTCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.pdt.ChiudiPDTCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.pdt.ClosePdtInFascicolo;
	import com.li.dc.sebc.turboFSE.controller.commands.pdt.RefreshOpenFolderPDTCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.pdt.UpdatePdtCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.AggiornaClassificazioniCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.AggiornaTimelineCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.ClosePDTService;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.DammiAlberoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.DammiFlussiCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.DammiFsepsCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.DammiTimelineCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.IdentificaCittadinoCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.LoadAllTreeCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.LoadCittadinoSmartCardCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.LoadContenFolderCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.LoadOperatoreCommand;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.OpenPdtService;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;

	public class FSEController extends Controller
	{

		public function FSEController()
		{
			super();
		}
		override protected function initialize():void
		{
			//SEQUENCE   STARTAPPLICATION
			registerCommand(ConstCommand.LOAD_PARAMETRI_VARIABILI, LoadParametriVariabiliCommand);

			registerCommand( ConstCommand.INIT_SMART_CARD , InitSmartCard );
			registerCommand( ConstCommand.INTERROGA_ASCOLTATORE_TESTUALE , InterrogaAscoltatoreTestualeCommand );
	    	registerCommand( ConstCommand.INTERROGA_ASCOLTATORE_CDA2 , InterrogaAscoltatoreCDA2Command );
			registerCommand( ConstCommand.START_APPLICATION , StartApplicationCommand );
			registerCommand( ConstCommand.LOAD_INIT_QUERY , LoadQueryCommand );

			registerCommand( ConstCommand.LOAD_CONFIGURATION , LoadConfigurationCommand );
			registerCommand( ConstCommand.CONF_DEBUG , ConfigDebugCommand );
			registerCommand( ConstCommand.LOAD_ELENCO_PROVINCE , LoadElencoProvince );
			registerCommand( ConstCommand.CONF_LABEL , ConfigStartCommand );
			//SEQUENCE  STARTAPPLICATION END
			registerCommand( ConstCommand.GO_HOME , GoHomeCommand );
			// MEMENTO
	    	registerCommand( ConstCommand.PUSH_MEMENTO , PushMementoCommand );
	    	registerCommand( ConstCommand.UNDO , UndoMementoCommand );
	    	registerCommand( ConstCommand.REDO , RedoMementoCommand );
	    	// COMMAND SERVICE CONTROL WAIT
	    	registerCommand( ConstCommand.LOAD_OPERATORE , LoadOperatoreCommand );
	    	registerCommand( ConstCommand.LOAD_CITTADINO_SMART_CARD , LoadCittadinoSmartCardCommand );
			registerCommand( ConstCommand.DAMMI_ALBERO , DammiAlberoCommand );
			registerCommand( ConstCommand.DAMMI_FSEPS , DammiFsepsCommand );

	    	registerCommand( ConstCommand.RESET_IDENTIFICA , ResetIdentificaCommand );
	    	registerCommand( ConstCommand.VISUALIZZA_VALIDATE_ERROR , VisualizzaValidateErrorCommand );
	    	registerCommand( ConstCommand.IDENTIFICA_CITTADINO , IdentificaCittadinoCommand );
	    	registerCommand( ConstCommand.LOAD_ELENCO_COMUNI , LoadElencoComuniCommand );
	    	registerCommand( ConstCommand.SMART_CARD_CITT_READY , SmartCardCittReadyCommand );
	    	registerCommand( ConstCommand.AGGIORNA_FASCICOLO , AggiornaFascicoloCommand );
	    	registerCommand( ConstCommand.AGGIORNA_CLASSIFICAZIONI , AggiornaClassificazioniCommand );
	    	//registerCommand( ConstCommand.AGGIORNA_TIMELINE , AggiornaTimelineCommand );

	    	registerCommand( ConstCommand.AGGIORNA_CHANGE_TAB , AggiornaChangeTab );
	    	registerCommand( ConstCommand.EXPAND_VIEW , ExpandViewCommand );
	    	registerCommand( ConstCommand.APRI_PANEL_FILTRI , ApriPanelFiltriCommand );
	    	registerCommand( ConstCommand.CHIUDI_PANEL_FILTRI , ChiudiPanelFiltriCommand );

	    	registerCommand( ConstCommand.APRI_PDT , ApriPDTCommand );

	    	registerCommand( ConstCommand.ADD_PDT_IN_FASCICOLO , AddPdtInFascicolo );

	    	registerCommand( ConstCommand.OPEN_PDT_SERVICE , OpenPdtService );

	    	registerCommand( ConstCommand.REFRESH_FOLDER_PDT , RefreshOpenFolderPDTCommand );


	    	registerCommand( ConstCommand.CHIUDI_PDT , ChiudiPDTCommand );

	    	registerCommand( ConstCommand.CLOSE_PDT_IN_FASCICOLO , ClosePdtInFascicolo );

	    	registerCommand( ConstCommand.CLOSE_PDT_SERVICE , ClosePDTService );


	    	registerCommand( ConstCommand.UPDATE_PDT , UpdatePdtCommand );



	    	registerCommand( ConstCommand.LOAD_GADO , LoadGadoCommand );
	    	registerCommand( ConstCommand.LOAD_CONTENT_FOLDER , LoadContenFolderCommand );
	    	registerCommand( ConstCommand.UPDATE_CONTENT_FOLDER , UpdateContenFolderCommand );
	    	registerCommand( ConstCommand.UPDATE_FOLDER , UpdateFolderCommand );
	    	registerCommand( ConstCommand.UPDATE_FILTRI , UpdateFiltriCommand );
	    	registerCommand( ConstCommand.FILTRA_DATA_TREE , FilterDataTreeCommand );

	    	registerCommand( ConstCommand.UPDATE_DOWN_ITEM_TREE , UpdateDownItemCommand );
	    	registerCommand( ConstCommand.GO_TEMPORALE , GoTemporaleCommand );
	    	registerCommand( ConstCommand.LOAD_ALL_TREE , LoadAllTreeCommand );
	    	registerCommand( ConstCommand.UPDATE_FLUSSI , UpdateFlussiCommand );

	    	registerCommand( ConstCommand.DAMMI_FLUSSI , DammiFlussiCommand );
	    	registerCommand( ConstCommand.AGGIORNA_FLUSSI , AggiornaFlussiCommand );


	    	registerCommand( ConstCommand.APRI_PANEL_FILTRI_FLUSSI , ApriPanelFiltriFlussiCommand );
	    	registerCommand( ConstCommand.AUTORIZZA_DCE , AutorizzaDCECommand );
	    	registerCommand( ConstCommand.RICHIEDI_URL_IMMAGINE , RichiediUrlImmagineCommand );

	    	//registerCommand( ConstCommand.DAMMI_TIMELINE , DammiTimelineCommand );
			registerCommand(ConstCommand.RICHIEDI_URL_TESTO_REFERTO, RichiediUrlTestoRefertoCommand);
			registerCommand(ConstCommand.OTTIENI_TESTO_REFERTO, OttieniTestoRefertoCommand);

			

		}
	}
}