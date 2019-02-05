package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	/**
	 * Classe di switch sia per rootFascicolo che per eventi
	 * Indica cosa fare al click dei menu ion basso delle due viste
	 * @author Marco Salonia
	 * 
	 */	
	public class UpdateDownItemCommand extends Command
	{
		public function UpdateDownItemCommand()
		{
			super();
		}
		
		override public function execute(data:Object = null):void
		{
			if(data != null)
			{
				var dataLabel:DataLabelTree = data as DataLabelTree;
				var para:Object = FSEModel.getInstance().oldParamExpand;
				if(para!=null)
				{
					para.select = false;
					Controller.getInstance().executeCommand(ConstCommand.EXPAND_VIEW,para);
					FSEModel.getInstance().oldParamExpand = null;
				}
			 	switch(dataLabel.value)
			 	{
			 		case Costanti.DOCUMENTI:
			 		case Costanti.DISCIPLINA:
			 			openVista(dataLabel);
			 			break;
			 		case Costanti.CRONOLOGICO:
						var model:FSEModel = FSEModel.getInstance();
						model.retrieveProxy(ConstDataProxy.DATA_FLUSSI_SELECT).update( null );
		 				model.retrieveProxy(ConstDataProxy.DATA_FLUSSI_SELECT).update( dataLabel );
			 			break;
			 		case Costanti.TEMPORALE2:
			 			openTemporale(dataLabel);
			 			break;
			 	}
			}
		}
		 
		private function openVista(dataLabel:DataLabelTree):void
		{
			if(dataLabel!=null)
			{
				// FSEModel.getInstance().isTreeComplete viene messo a false quando si carica l'albero (DammiAlberoCommand)
				if(!FSEModel.getInstance().isTreeComplete)
				{ 
		    		//FactoryService.getInstance().getTree(new WrapResponder(this),0,true).execute();
		    		Controller.getInstance().executeCommand( ConstCommand.LOAD_ALL_TREE ,dataLabel);
	   			}else
	   			{
	   				FSEModel.getInstance().retrieveProxy( ConstDataProxy.DATA_FOLDER_SELECT ).update( dataLabel );
	   			}
			}	
		}
		
		private function openTemporale(data:DataLabelTree):void
		{
			var model:FSEModel = FSEModel.getInstance();
			// data.complete non sarà mai vero
			// pulisco la vista
			model.retrieveProxy( ConstDataProxy.DATA_FOLDER_SELECT ).update( null );
			// apro la popup esterna
			Controller.getInstance().executeCommand( ConstCommand.GO_TEMPORALE );
		}
	}
}