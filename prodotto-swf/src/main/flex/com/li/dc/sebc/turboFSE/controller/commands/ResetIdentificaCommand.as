package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.nodeView.AssistitoFse;
	import com.li.dc.sebc.turboFSE.view.nodeView.IdentificaCittadino;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;

	public class ResetIdentificaCommand extends Command
	{
		public function ResetIdentificaCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			Debug.logInfo("TODO completare ResetIdentificaCommand");
			// manca la gestione se sono su un'altro tab
			var model:FSEModel = FSEModel.getInstance();
			// resetto due volte lo stato per fargli fare il clear in automatico
			model.retrieveProxy(ConstDataProxy.STATE_IDENTIFICA_CITTADINO).update(IdentificaCittadino.IDENT_MULTIPLA);
			model.retrieveProxy(ConstDataProxy.STATE_IDENTIFICA_CITTADINO).update(IdentificaCittadino.IDENT_SINGOLA);
			model.retrieveProxy(ConstDataProxy.STATE_ASSISTITO_FSE).update(AssistitoFse.IDENTIFICA);
			model.retrieveProxy(ConstDataProxy.DATA_AREATAB).update( 0 );
			
			/*
			var tab:int	= GlobalModel.getInstance().tabView;
			GlobalModel.getInstance().listVistaFolder			= [];
			GlobalModel.getInstance().listEvents				= [];
			GlobalModel.getInstance().loadedEventiFlussi		= false;
			//
			GlobalModel.getInstance().displayDatiCittadino 		= false;
			GlobalModel.getInstance().displayPulsanteIdentifica	= false;
			GlobalModel.getInstance().enabledTabFascicolo 		= false;
			GlobalModel.getInstance().enabledTabEventi	 		= false;
			GlobalModel.getInstance().enabledTab		 		= false;
			GlobalModel.getInstance().loadedConsultaFascicolo	= false;
			GlobalModel.getInstance().loadedIndiceFascicolo		= false;
			GlobalModel.getInstance().dataCittadinoAssistito	= null;
			if(tab==0)
			{
				GlobalModel.getInstance().tabView 				= -1;
			} 
			GlobalModel.getInstance().tabView 					= 0;
			*/
		}
	}
}