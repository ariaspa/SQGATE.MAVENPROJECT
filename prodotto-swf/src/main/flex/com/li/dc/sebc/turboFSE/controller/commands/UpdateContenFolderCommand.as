package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	/**
	 * Controlla se il folder appena selezionato è completo o c'è bisogno di chiamare il servizio per completarlo
	 * 
	 * @author Marco Salonia 14-12-2010
	 * 
	 */
	public class UpdateContenFolderCommand extends Command
	{
		public function UpdateContenFolderCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			Debug.logDebug( "UpdateContenFolderCommand execute (data !=null): "+ (data !=null) +", "+data);
			if(data !=null)
			{
				var folder:FolderTree = data as FolderTree;
				Debug.logDebug( "UpdateContenFolderCommand folder.complete :1: "+folder.complete );
				if(folder.children!=null && folder.children.length>0)
				{
					folder.complete = true; 
				}
				Debug.logDebug( "UpdateContenFolderCommand folder.complete :2: "+folder.complete );
				if(folder.complete)
				{
					var model:FSEModel = FSEModel.getInstance();
		 			model.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).update( folder );
				}else
				{
					Controller.getInstance().executeCommand(ConstCommand.LOAD_CONTENT_FOLDER , folder  );
				}
			}
		}
	}
}