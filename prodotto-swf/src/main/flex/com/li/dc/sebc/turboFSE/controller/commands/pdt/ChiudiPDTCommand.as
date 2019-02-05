package com.li.dc.sebc.turboFSE.controller.commands.pdt
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.component.PanelPDT;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.controls.Alert;

	public class ChiudiPDTCommand extends Command
	{
		public function ChiudiPDTCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			var m:FSEModel				= FSEModel.getInstance();
		 	/* La lista dei pdt chiudibili in questo momento */
		 	var codici:Array 	=  m.retrieveProxy(ConstDataProxy.DATA_PDT_CLOSE).getData() as Array;
		 	/* Se c'è una lista apro il popUp */
		 	if(codici.length>0 && !ViewMessageManager.getInstance().popUpBusy())
		 	{
		 		if(m.panelClosePdt == null)
		 		{
		 			m.panelClosePdt = new PanelPDT();
		 			TurboView.getInstance().createMediator(ConstMediator.PANEL_CLOSE_PDT,ConstMediator.PANEL_CLOSE_PDT,m.panelClosePdt);
		 		}
				var panel:PanelPDT 		= m.panelClosePdt;
				//var pad:Object			= {horizontal:40,vertical:40}; 
				ViewMessageManager.getInstance().showPanel( panel );
		 	}else
		 	{
		 		 
				ViewMessageManager.getInstance().showAlert("Non è possibile aprire il pannello dei percorsi diagnostici", "Attenzione", Alert.OK);
		 	}	
		}
	}
}