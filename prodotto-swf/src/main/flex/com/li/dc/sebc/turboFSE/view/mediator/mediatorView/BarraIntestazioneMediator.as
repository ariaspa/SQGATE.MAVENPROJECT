package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.nodeView.BarraIntestazione;
	
	import flash.events.Event;
	
	import it.lispa.siss.library.ui.menustandard.Header;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.graphic.image.ImageDefinition;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	 
	public class BarraIntestazioneMediator extends Mediator
	{
		
		private var barra:Header;
		public function BarraIntestazioneMediator()
		{
			super();
			Debug.logDebug("instance BarraIntestazioneMediator create");
		}
		override protected function finalize():void
		{
			
		}
		override protected function initialize( ):void
		{
			barra = this.view as Header;
			initializeView();
			initializeData();
		}
		private function initializeData():void
		{
			/* var model:FSEModel	= FSEModel.getInstance(); 
			//var cod:String = model.queryParams[Costanti.CODICEFISCALE];
			var cod:String = null;
			if(cod==null)
			{
				/* aggiungo il listener , il dato restituito è una stringa rappresentante lo stato del componente, */
				/* Il dataProxy controlla che il valore dello stato sia sempre coerente */
				//model.retrieveProxy(ConstDataProxy.STATE_LOGO).addEventListener(DataProxyEvent.DATA_UPDATE,changeState);
			//}else{
				// vecchia barra
				//barra.visibleButton = false;
			//} 
		}
		
		private function changeState(e:DataProxyEvent):void
		{
			//barra.stateLogo = e.getData() as String;
		}
		
		private function initializeView():void
		{
			//barra.iconaLogo 		= ImageDefinition.ICONA_ROSA_CAMUNA; 
			//barra.iconaButtonHome	= ImageDefinition.ICONA_BOTTONE_HOME; 
			//barra.styleButton		= "button";
			
			barra.nome_testata 	= "SISS - Consultazione Fascicolo Sanitario Elettronico";
			barra.nome_app		= "FSE";
			//barra.nome_sottotitolo_app = "Consultazione Fascicolo Sanitario Elettronico";
			barra.numVerde.text = "800.070.090"; 
			//barra.labelBarraIntestazione 	= " Regione Lombardia - Consultazione Fascicolo";
			//barra.labelButtonHome 			= "HOME";
			//barra.toolTipButtonHome 		= "Ritorno al menù principale";
			//barra.addEventListener("clickHome",function(e:Event):void
			//{
			//	Controller.getInstance().executeCommand(ConstCommand.GO_HOME);
			//});
		}
	}
}