package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.TreeEventi;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.collections.ArrayCollection;
	
	

	public class UpdateFlussiCommand extends Command
	{
		public function UpdateFlussiCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data!=null && data is TreeEventi )
			{
				Debug.logWarning("TODO: Completare UpdateFlussiCommand");
				
				var flussi:TreeEventi	= data as TreeEventi;
				var model:FSEModel = FSEModel.getInstance();
				if(flussi.listaEventi==null)
				{
					flussi.listaEventi = new ArrayCollection();
				}
				model.retrieveProxy(ConstDataProxy.DATA_VISIBLE_UP_FLUSSI).update(flussi.listaEventi);
			}			
		}
	}
}