package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.ContentFolder;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	
	public class AggiornaClassificazioniCommand extends ControlWait
	{
		public function AggiornaClassificazioniCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			FactoryService.getInstance().getClassificazioni(new WrapResponder(this)).execute();
		}
		
		
		override protected function executeResult(data:Object):void
		{
			var content:ContentFolder = data as ContentFolder;
			
			if(content.esitoNegativo != null)
			{
				 MessageManager.getInstance().addMessage( content.esitoNegativo );
			}else if(content.fault!=null)
			{
				 MessageManager.getInstance().addMessage( content.fault );
			}else
			{
				FSEModel.getInstance().retrieveProxy( ConstDataProxy.CLASSIFICAZIONI).update( content.folder );
			}
		}
		
		
		override protected function executeFault(info:Object):void
		{
			 MessageManager.getInstance().addMessage( info );
		}
	}
}