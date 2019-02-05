package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.nodeView.HeaderToggle;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.graphic.image.ImageDefinition;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class HeaderToogleMediator extends Mediator
	{
		private var hToogle:HeaderToggle;
		public function HeaderToogleMediator()
		{
			super();
		}
		override protected function finalize():void
		{
			
		}
		override protected function initialize():void
		{
			hToogle = this.view as HeaderToggle;
			initializeData();
			initializeView();
		}	
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.TEXT_NAVIGATION_LABEL).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateNavLabel);
			model.retrieveProxy(ConstDataProxy.DATA_SELECT_BUTTON).addEventListener(DataProxyEvent.DATA_UPDATE,onDataSelectButton);
		}
		private function onDataSelectButton(e:DataProxyEvent):void
		{
			//var select:Boolean  = _selectButtonFilter.select;
			//var btn:Button		= _listButton[_selectButtonFilter.index];
			hToogle.dataButtonFilter =  e.getData();
		}
		private function onUpdateNavLabel(e:DataProxyEvent):void
		{
			hToogle.textNavigationLabel	= e.getData() as String;
		}
		private function initializeView():void
		{
			var model:FSEModel = FSEModel.getInstance();
			
			var conf:Configuration 		= model.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
			if(conf!=null) hToogle.disabilitaButtonPDT	= conf.apriChiudiPdt;
			 
			hToogle.iconButtonAggiorna 	= ImageDefinition.ICONA_BOTTONE_AGGIORNA_16X16;
			
			hToogle.listButtonPDT		= model.listButtonPDT ;    
			hToogle.listToolButtonBar	= model.listToolButtonBar;  
			hToogle.textNavigationLabel	= model.retrieveProxy(ConstDataProxy.TEXT_NAVIGATION_LABEL).getData() as String;
			   
			hToogle.addEventListener(TurboEvent.CLICK_BUTTON_FILTER,clickButtonFilter);
			hToogle.addEventListener(TurboEvent.CLICK_BUTTON_PDT,clickButtonPDT);
			hToogle.addEventListener(TurboEvent.CLICK_BUTTON_OSCURATI,clickButtonOscurati);
			hToogle.addEventListener(TurboEvent.CLICK_BUTTON_AGGIORNA,clickButtonAggiorna);
		}
		private function clickButtonAggiorna(e:Event):void
		{
			Alert.yesLabel 		= "Si";
			var body:String		= "L'aggiornamento comporta la ricreazione dell'albero dei folder e l'eliminazione di eventuali dettagli di questi, inclusi i documenti visualizzati, sei sicuro di voler continuare?";
			var title:String	= "Attenzione";
			Alert.show(body,title,Alert.YES | Alert.NO,null,confermaAggiorna,ImageDefinition.ICONA_WARNING,Alert.NO);
		}
		private function clickButtonOscurati(e:TurboEvent):void
		{
			var index:int = hToogle.indexButtonOscurati;
			Alert.yesLabel 		= "Si";
			var body:String		= "L'apertura della finestra di visibiltà causa la chiusura di eventuali DCE aperti, sei sicuro di voler continuare?";
			var title:String	= "Attenzione";
			ViewMessageManager.getInstance().showAlert(body,title,(Alert.YES | Alert.NO),confermaOscurati);			
		}
		private function confermaOscurati(event:CloseEvent):void 
		{
			if (event.detail == Alert.YES) 
			{ 
				Controller.getInstance().executeCommand(ConstCommand.LOAD_GADO,{action:Costanti.FINESTRA});
			}
		} 
		private function confermaAggiorna(event:CloseEvent):void 
		{
			if (event.detail == Alert.YES) 
			{ 
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_FASCICOLO);
			}
		} 
		private function clickButtonPDT(e:TurboEvent):void
		{
			var index:int = hToogle.indexButtonPDT;
			if(index==0)
			{
				Controller.getInstance().executeCommand( ConstCommand.APRI_PDT );
			}else if(index == 1)
			{
				Controller.getInstance().executeCommand( ConstCommand.CHIUDI_PDT);
			}
		}
		private function clickButtonFilter(e:TurboEvent):void
		{
			var index:int = hToogle.indexButtonFilter;
			Controller.getInstance().executeCommand(ConstCommand.APRI_PANEL_FILTRI,index);
		}
	}
}