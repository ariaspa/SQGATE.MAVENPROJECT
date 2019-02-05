package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.DataIdentificaCittadinoEvent;
	import com.li.dc.sebc.turboFSE.events.ErrorValidateEvent;
	import com.li.dc.sebc.turboFSE.events.MessageEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.nodeView.AssistitoFse;
	import com.li.dc.sebc.turboFSE.view.nodeView.IdentificaCittadino;
	
	import it.lispa.siss.library.ui.menustandard.Assets;
	import it.lispa.siss.sebc.flex.graphic.image.ImageDefinition;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	
	import mx.binding.utils.BindingUtils;
	import mx.formatters.DateFormatter;

	public class IdentificaCittadinoMediator extends Mediator
	{
		private var elencoCittadini:Array;
		private var identificaCittadino:IdentificaCittadino;
		public function IdentificaCittadinoMediator()
		{
			super();
			elencoCittadini = new Array();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			identificaCittadino = (this.view as IdentificaCittadino);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();	
			BindingUtils.bindProperty(identificaCittadino,"elencoComuni",model,"elencoComuni",true);
			BindingUtils.bindProperty(identificaCittadino,"elencoProvincie",model,"elencoProvincie",true);
			//
			model.retrieveProxy(ConstDataProxy.DATA_ELENCO_CITTADINI).addEventListener(DataProxyEvent.DATA_UPDATE,onChangeDataElenco);
			model.retrieveProxy(ConstDataProxy.STATE_IDENTIFICA_CITTADINO).addEventListener(DataProxyEvent.DATA_UPDATE,onChangeStateIdentifica);
		}
		private function onChangeStateIdentifica(e:DataProxyEvent):void
		{
			identificaCittadino.currentState 	= e.getData() as String;
		}
		private function onChangeDataElenco(e:DataProxyEvent):void
		{
			var ele:Array		= e.getData() as Array;
			var model:FSEModel = FSEModel.getInstance();	
			if(ele!=null && ele.length>1)
			{
				identificaCittadino.elencoCittadini = ele;
				model.retrieveProxy(ConstDataProxy.STATE_IDENTIFICA_CITTADINO).update(IdentificaCittadino.IDENT_MULTIPLA);
			}else if(ele!=null && ele.length==1)
			{
				model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).update(ele[0] as Cittadino);
				model.retrieveProxy(ConstDataProxy.STATE_ASSISTITO_FSE).update(AssistitoFse.VISUALIZZA);
			} 
		}
		 
		private function initializeView():void
		{
			identificaCittadino.currentState			= IdentificaCittadino.IDENT_SINGOLA;
			identificaCittadino.elencoProvincie			= FSEModel.getInstance().elencoProvincie;
			//identificaCittadino.iconButtonAzzera		= ImageDefinition.ICONA_BOTTONE_CANCELLA_16X16;
			identificaCittadino.iconButtonAzzera		= Assets.ICO_CAMBIO_UTENTE;
			//identificaCittadino.iconButtonRicerca 		= ImageDefinition.ICONA_BOTTONE_RICERCA_16X16; 
			identificaCittadino.iconButtonRicerca 		= Assets.ICO_RICERCA; 
			identificaCittadino.iconBottoneConferma 	= ImageDefinition.ICONA_BOTTONE_CONFERMA_16X16; 
			
			identificaCittadino.tooltipButtonAzzera 	= "Elimina i criteri di ricerca";
			identificaCittadino.tooltipButtonRicerca 	= "Esegue la ricerca del cittadino in base ai criteri indicati";
			identificaCittadino.styleButtonAzzera		= "button";
			identificaCittadino.styleButtonRicerca		= "button"
			identificaCittadino.styleButtonConferma		= "button"
			identificaCittadino.formatter				= new DateFormatter();
			identificaCittadino.formatter.formatString	= "DD/MM/YYYY";
			identificaCittadino.addEventListener(MessageEvent.CHANGE_PROVINCIA,onChangeProvincia);
			identificaCittadino.addEventListener(DataIdentificaCittadinoEvent.IDENTIFICA_CITTADINO_EVENT,onIdentificaCittadino);
			identificaCittadino.addEventListener(ErrorValidateEvent.ERROR_VALIDATE_EVENT,onErrorValidate);
			   
		}
		//////////////////////////////////////////
		private function onErrorValidate(e:ErrorValidateEvent):void
		{
			Controller.getInstance().executeCommand(ConstCommand.VISUALIZZA_VALIDATE_ERROR,e.getErrors());
		}
		private function onIdentificaCittadino(e:DataIdentificaCittadinoEvent):void
		{
			Controller.getInstance().executeCommand(ConstCommand.IDENTIFICA_CITTADINO,e.getData());
		}
		private function onChangeProvincia(e:MessageEvent):void
		{
			Controller.getInstance().executeCommand(ConstCommand.LOAD_ELENCO_COMUNI,e.getValue());
		}
	}
}