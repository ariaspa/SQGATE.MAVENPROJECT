package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class LoadElencoComuniCommand extends ResponderCommand
	{
		public function LoadElencoComuniCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data!=null)
			{
				FactoryService.getInstance().getElencoComuni(this , data as String ).execute();
			}else
			{
				internalFault();
			}
		}
		private function internalFault():void
		{
			Debug.logWarning("LoadElencoComuniCommand implements internalFault");
			fault({});
		}
		override public function fault(info:Object):void
		{
			Debug.logWarning("LoadElencoComuniCommand implements show fault");
		}
		override public function result(data:Object):void
		{
			var model:FSEModel 	= FSEModel.getInstance();
			// doppia gestione per il locale e il remoto, TODO si dovrà togliere
			var result:ResultEvent = (data as ResultEvent);
			if(result.result is Array){
				model.elencoComuni =  result.result as Array;
			}else
			{
				model.elencoComuni =  (result.result as ArrayCollection).toArray();	
			}
		}
	}
}