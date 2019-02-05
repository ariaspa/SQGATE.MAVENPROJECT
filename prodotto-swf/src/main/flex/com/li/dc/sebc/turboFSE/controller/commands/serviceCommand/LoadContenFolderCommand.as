package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.ContentFolder;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	import mx.collections.ArrayCollection;
	/**
	 * Carica il singolo folder completo e lo sostituisce con quello incompleto
	 * @author Marco Salonia 14-12-2010
	 * 
	 */	
	public class LoadContenFolderCommand extends ControlWait
	{
		private var id:String;
		public function LoadContenFolderCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			Debug.logDebug( "LoadContenFolderCommand (data !=null)" +(data !=null)+",  "+data);
			if(data !=null && data is FolderTree )
			{
				var folder:FolderTree = data as FolderTree;
				
				if(folder.folder!=null && folder.folder.codice!=null && folder.folder.codice.length>0 )
				{
					id =  folder.folder.codice;
					Debug.logDebug( "LoadContenFolderCommand id : "+id );
					var data:Object = FSEModel.getInstance().oldParamExpand;
					if(data!=null)
					{
						data.select = false;
						Controller.getInstance().executeCommand(ConstCommand.EXPAND_VIEW,data);
						FSEModel.getInstance().oldParamExpand = null;
					}
					FactoryService.getInstance().getContentFolder( new WrapResponder( this ), id ).execute();
				}
			}
		}
				 
		override protected function executeResult(data:Object):void
		{
			Debug.logDebug( "LoadContenFolderCommand executeResult data :: "+data );
			var model:FSEModel 			= FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).update( null );
			if(data is ContentFolder)
			{
				var risposta:ContentFolder	=  data as ContentFolder;
				if(risposta.esitoNegativo!=null && risposta.esitoNegativo!=null)
				{
					Debug.logDebug( "LoadContenFolderCommand esitoNegativo" );
					MessageManager.getInstance().addMessage( risposta.esitoNegativo );
				}else if(risposta.fault!=null)
				{
					Debug.logDebug( "LoadContenFolderCommand fault" );
					MessageManager.getInstance().addMessage( risposta.fault );
				}else
				{
					
					var folder:FolderTree = risposta.folder;
					Debug.logDebug( "LoadContenFolderCommand folder.complete ::: " +folder);
					if(folder!=null && folder.complete)
					{
						/**
						 * TODO:da rivedere  
						 */						
						/* recupero la lista originale */
						var list:ArrayCollection 	= (model.retrieveProxy(ConstDataProxy.DATA_TREE).getData() as Tree).listaFolder;
						//var list2:ArrayCollection 	= model.retrieveProxy(ConstDataProxy.DATA_VISIBLE_UP_TREE).getData() as ArrayCollection;
						/* aggiorno la lista originale */
						//Utils.substitute( folder , list );
						var newFolder:FolderTree = Utils.update( folder , list  );
						//Utils.substitute( folder , list2 );
						/* filtro la lista originale e creo la nuova lista dei visibili */
						//Controller.getInstance().executeCommand(ConstCommand.FILTRA_DATA_TREE);
						model.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).update( newFolder );
					} 
					if(risposta.listaWarning!=null)
					{
						MessageManager.getInstance().addMessage( risposta.listaWarning );
					}
				}
			}
		}
		override protected function executeFault(info:Object):void
		{
			 MessageManager.getInstance().addMessage( info );
		}
	}
}