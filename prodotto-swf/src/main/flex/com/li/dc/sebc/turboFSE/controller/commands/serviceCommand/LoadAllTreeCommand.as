package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.RispostaTree;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lisit.siss.flex.core.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	public class LoadAllTreeCommand extends ControlWait
	{
		private var dt:DataLabelTree;
		public function LoadAllTreeCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{ 
			if(data!=null && data is DataLabelTree)
			{
				dt = data as DataLabelTree;
				FactoryService.getInstance().getTree(new WrapResponder(this),0,true).execute();
			}
		}
		override protected function executeFault(info:Object):void
		{
			var m:FSEModel = FSEModel.getInstance();
			m.retrieveProxy( ConstDataProxy.DATA_FOLDER_SELECT ).update( null ); 
			MessageManager.getInstance().addMessage( info );
		}
		override protected function executeResult(data:Object):void
		{
			if(data is RispostaTree)
			{
				var risposta:RispostaTree	=  data as RispostaTree;
				if(risposta.esitoNegativo!=null  )
				{
					MessageManager.getInstance().addMessage( risposta.esitoNegativo );
				}else if(risposta.fault!=null)
				{
					MessageManager.getInstance().addMessage( risposta.fault );
				}else
				{
					FSEModel.getInstance().isTreeComplete	= true;
					FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TREE).update( risposta.tree );
					/* filtro la lista originale e creo la nuova lista dei visibili */
					Controller.getInstance().executeCommand(ConstCommand.FILTRA_DATA_TREE);
						 
				}
			}	 
			FSEModel.getInstance().retrieveProxy( ConstDataProxy.DATA_FOLDER_SELECT ).update( dt ); 
		}
		
	}
}