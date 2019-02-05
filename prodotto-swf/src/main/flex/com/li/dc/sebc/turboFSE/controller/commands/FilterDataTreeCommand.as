package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.filters.ManagerFilters;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.collections.ArrayCollection;

	public class FilterDataTreeCommand extends Command
	{
		public function FilterDataTreeCommand()
		{
			super();
		}
	 
		override public function execute(data:Object=null):void
		{
			var model:FSEModel			= FSEModel.getInstance();
			var list:ArrayCollection 	= (model.retrieveProxy(ConstDataProxy.DATA_TREE).getData() as Tree).listaFolder;
			if(list!=null)
			{
				list 						= ManagerFilters.getInstance().executeFilters( list );
		 		//list 						= Utils.clearListFolderVisible( list );
		 		model.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).update( null ); 
		 		model.retrieveProxy(ConstDataProxy.DATA_VISIBLE_UP_TREE).update( new ArrayCollection( list.toArray() ) );
			}
		}
	}
}