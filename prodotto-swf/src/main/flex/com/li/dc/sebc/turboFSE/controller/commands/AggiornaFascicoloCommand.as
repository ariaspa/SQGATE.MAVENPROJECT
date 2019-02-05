package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;   
	import com.li.dc.sebc.turboFSE.model.dataProxy.DataDownTree; 
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	import com.li.dc.sebc.turboFSE.util.window.GestWindows;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	import mx.collections.ArrayCollection;

	public class AggiornaFascicoloCommand extends Command
	{
		public function AggiornaFascicoloCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			Debug.logDebug( "AggiornaFascicoloCommand.execute AAAA");
			var oldTree:Tree = FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TREE).getData() as Tree;
			if(oldTree!=null)
			{
				var tree:Tree 		= new Tree();
				tree.cittadino 		= oldTree.cittadino;
				tree.listaFolder 	= new ArrayCollection();
				//
				FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TREE).update( tree );
				FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).update( null );
			}
			 
			//
			(FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_DOWN_TREE) as DataDownTree).fillDefault();
			GestWindows.getInstance().clearAll();
			FSEModel.getInstance().hashViste.clear();
			/* promemoria per quando ci sarà la gestione delle popup esterne */
			// GestWindows.getInstance().clearAll();
			// pulire la parte delle viste 
			Controller.getInstance().executeCommand( ConstCommand.DAMMI_ALBERO, "1" );
			 
		}
	}
}