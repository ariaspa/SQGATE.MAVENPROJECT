package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	
	import flash.events.Event;
	
	import it.lispa.siss.library.ui.menustandard.Assets;
	import it.lispa.siss.library.ui.menustandard.Header;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.graphic.image.ImageDefinition;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	public class HeaderMediator extends Mediator
	{
		private var header:Header;
		public function HeaderMediator()
		{
			super();
			
			Debug.logDebug("instance HeaderMediator create");
		}
		override protected function finalize():void
		{
			
		}
		override protected function initialize():void
		{
			header = this.view as Header;
			//initializeData();
			//initializeView();
		}		    
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_OPERATORE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateOperatore);
			model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateCittadino);
			////////////////  
			model.retrieveProxy(ConstDataProxy.SMARTCARD_CIT).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateSmart);
			////////////////
			var citt:Cittadino = model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			var ope:Operatore  = model.retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			if(citt!=null)
				fillCittadino( citt );
			if(ope!=null)
				fillOperatore( ope );
		}
		private function onUpdateSmart(e:DataProxyEvent):void
		{
			//header.enabledPulsanteIdentifica = e.getData() as Boolean;
		}
		private function onUpdateCittadino(e:DataProxyEvent):void
		{
			fillCittadino(e.getData() as Cittadino);
		}
		private function onUpdateOperatore(e:DataProxyEvent):void
		{
			fillOperatore(e.getData() as Operatore);
		}	
		private function initializeView():void
		{
			/* var model:FSEModel = FSEModel.getInstance();
			header.enabledPulsanteIdentifica	= model.retrieveProxy(ConstDataProxy.SMARTCARD_CIT).getData() as Boolean;
			header.displayDatiCittadino			= true;
			header.displayPulsanteIdentifica 	= true
			header.displayCodiceOperatore		= true;
			header.styleBoxDown					= "datiOperatoreBox";
			header.styleBoxUp					= "testataOperatoreBox";
			header.stylePulsanteIdentifica		= "button";
			header.iconaBottoneRicerca			= Assets.ICO_RICERCA;
			//header.iconaBottoneRicerca			= ImageDefinition.ICONA_BOTTONE_RICERCA_16X16;
			header.iconaBottoneInfo				= ImageDefinition.ICONA_BOTTONE_INFORMAZIONE_16X16;
			
			header.enabledPulsanteInfo			= false;
			header.stylePulsanteInfo			= "button";
			header.displayPulsanteInfo			= true;
			header.toolTipInformazioni			= "Trascinare il bottone e rilasciare";	
			header.addEventListener("clickPulsanteIdentificaCittadino",onClickIdentifica); */
		}	
		 
		private function onClickIdentifica(e:Event):void
		{
			Controller.getInstance().executeCommand(ConstCommand.RESET_IDENTIFICA);
		}
		private function fillOperatore(ope:Operatore):void
		{
			Debug.logInfo("HeaderMediator fillOperatore");
			//header.cognomeOperatore.text 		= ope.cognome;
			//header.nomeOperatore.text 		= ope.nome;
			//header.ruoloOperatore.text 		= ope.ruolo;
			if(ope!=null)
			{
				//header.codiceOperatore.text 	= ope.codiceFiscale;
			}
		}
		private function fillCittadino(citt:Cittadino):void
		{
			/* Debug.logInfo("HeaderMediator ---- fillCittadino");
			if(citt!=null){
			header.nomeCittadino.text 			= citt.nome;
			header.cognomeCittadino.text 		= citt.cognome;
			header.sessoCittadino.text 			= citt.codiceSesso;
			header.identificativoCittadino.text = citt.codiceFiscale;
			header.dataNascitaCittadino.text 	= UtilDate.getStringData(citt.dataNascita); 
			}*/
		}
	}
}
