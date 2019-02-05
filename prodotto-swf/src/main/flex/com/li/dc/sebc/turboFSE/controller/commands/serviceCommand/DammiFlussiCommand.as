package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	 
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.model.vo.RispostaTreeEventi;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	
	public class DammiFlussiCommand extends ControlWait
	{
		public function DammiFlussiCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			var m:FSEModel = FSEModel.getInstance();
			var conf:Configuration = m.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
			FactoryService.getInstance().getEventiCittadino(new WrapResponder( this ),conf.dataInizioFlussi,conf.dataFineFlussi).execute();
		}
		override protected function executeResult(data:Object):void
		{
			if(data is RispostaTreeEventi)
			{
				var risposta:RispostaTreeEventi	=  data as RispostaTreeEventi;
				if(risposta.esitoNegativo!=null)
				{
					MessageManager.getInstance().addMessage( risposta.esitoNegativo );
				}else if(risposta.fault!=null)
				{
					MessageManager.getInstance().addMessage( risposta.fault );
				}else
				{
					var m:FSEModel = FSEModel.getInstance();
					m.retrieveProxy(ConstDataProxy.DATA_TREE_FLUSSI).update( risposta.tree );
					var conf:Configuration = m.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
					m.retrieveProxy(ConstDataProxy.HEADER_FLUSSI_TEXT).update( Utils.createLabelFiltri(conf.dataInizioFlussi,conf.dataFineFlussi ) );
				}
			}	 
		}
		override protected function executeFault(info:Object):void
		{
			 MessageManager.getInstance().addMessage( info );
		}
	}
}