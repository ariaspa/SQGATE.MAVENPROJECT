package com.li.dc.sebc.turboFSE.controller.commands.pdt
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.component.PanelPDT;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.controls.Alert;

	public class ApriPDTCommand extends Command
	{
		public function ApriPDTCommand()
		{
			super();
		}
		/* istanzia il pannello se non istanziato e lo visualizza */
		override public function execute(data:Object = null):void
		{
		 	var m:FSEModel				= FSEModel.getInstance();
		 	/* La lista dei pdt apribili in questo momento */
		 	var codici:Array 	=  m.retrieveProxy(ConstDataProxy.DATA_PDT_OPEN).getData() as Array;
		 	/* Se c'è una lista apro il popUp */
		 	if(codici.length>0 && !ViewMessageManager.getInstance().popUpBusy())
		 	{
		 		if(m.panelOpenPdt == null)
		 		{
		 			m.panelOpenPdt = new PanelPDT();
		 			TurboView.getInstance().createMediator(ConstMediator.PANEL_OPEN_PDT,ConstMediator.PANEL_OPEN_PDT,m.panelOpenPdt);
		 		}
				var panel:PanelPDT 		= m.panelOpenPdt;
				//var pad:Object			= {horizontal:40,vertical:40}; 
				ViewMessageManager.getInstance().showPanel( panel );
		 	}else
		 	{
		 		 
				ViewMessageManager.getInstance().showAlert("Non è possibile aprire il pannello dei percorsi diagnostici", "Attenzione", Alert.OK);
		 	}
		}
	}
}