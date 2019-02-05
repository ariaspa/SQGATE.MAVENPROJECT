package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.component.PanelPDT;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	
	import mx.controls.DateField;
	import mx.events.CloseEvent;

	public class PanelOpenPDTMediator extends Mediator
	{
		private var panelPdt:PanelPDT;
		private var isNN:ISpecification;
		public function PanelOpenPDTMediator()
		{
			super();
		}
		override protected function finalize():void
		{}
		override protected function initialize( ):void
		{
			panelPdt = (this.view as PanelPDT);
			initializeView();	
			initializeData();
		}
		private function initializeData():void
		{
			isNN = new IsNullSpecification().not();
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_PDT_OPEN).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateopenPDT);
		}
		private function onUpdateopenPDT(e:DataProxyEvent):void
		{
			panelPdt.listaCodici = e.getData() as Array;
		}
		private function initializeView():void
		{
			var m:FSEModel = FSEModel.getInstance();
			var dataProxy:DataProxy = m.retrieveProxy(ConstDataProxy.DATA_PDT_OPEN); 
			panelPdt.listaCodici = dataProxy.getData() as Array;
			///////////////////////
			panelPdt.labelListFunction 	= setLabelList;
			panelPdt.title				= "Apertura di un Percorso Diagnostico Terapeutico";	
			panelPdt.showCloseButton	= true;
			panelPdt.addEventListener(CloseEvent.CLOSE,onClosePanel);		
			panelPdt.addEventListener(TurboEvent.CLICK_CONFERMA,onConferma);
			panelPdt.addEventListener(Event.ADDED_TO_STAGE,addStage);
		}
		private function addStage(e:Event):void
		{
			panelPdt.callLater(initDataField);	
		}
		private function initDataField( ):void
		{
			var dataField:DateField 	= panelPdt.dataField;
			dataField.minYear			= 1900;
			dataField.monthNames		= UtilDate.MESI; 
			dataField.dayNames			= UtilDate.GIORNI; 
			dataField.formatString		= UtilDate.FORMATTER_STRING; 
			dataField.selectedDate		= new Date();
			///////////////////////
		}
		private function onClosePanel(e:CloseEvent):void
		{
			closePanel();
		}
		private function closePanel():void 
		{
			 ViewMessageManager.getInstance().closeDisplayer();
		}
		private function onConferma(e:TurboEvent):void
		{
			var dati:Object = panelPdt.getDati();
			closePanel();
			Controller.getInstance().executeCommand( ConstCommand.ADD_PDT_IN_FASCICOLO, dati ); 
		}
		//--- --- --- --- --- --- --- --- --- --- --- --- ---
		private function setLabelList(obj:Object):String
		{
			var pdt:PercorsoDiagnosticoTerapeutico	= obj as PercorsoDiagnosticoTerapeutico;
			var descrizione:String 	= "";
			var codice:String 		= "";
			if(isNN.isSatisfiedBy( pdt )
			&& isNN.isSatisfiedBy(pdt.PDT)
			&& isNN.isSatisfiedBy(pdt.PDT.descrizione)
			&& pdt.PDT.descrizione.length>0)
			{
				descrizione = pdt.PDT.descrizione;
			}
			if(isNN.isSatisfiedBy( pdt )
			&& isNN.isSatisfiedBy(pdt.PDT)
			&& isNN.isSatisfiedBy(pdt.PDT.codice)
			&& pdt.PDT.codice.length>0)
			{
				codice = pdt.PDT.codice;
			}
			return descrizione + " ("+codice+")";
		}
	}
}