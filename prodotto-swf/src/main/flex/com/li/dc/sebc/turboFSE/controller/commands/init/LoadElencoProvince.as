package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.ResponderCommand;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class LoadElencoProvince extends ResponderCommand
	{
		private var reference:ISequenceReference;
		public function LoadElencoProvince()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			Debug.logDebug( "LoadElencoProvince.execute " );
			if(data is ISequenceReference){
				reference = data as ISequenceReference;
				FactoryService.getInstance().getElencoProvince(this).execute();
			}
		}
		override public function result(data:Object):void
		{
			Debug.logDebug( "LoadElencoProvince.result " );
			// doppia gestione per il locale e il remoto, TODO si dovrà togliere
			var result:ResultEvent = (data as ResultEvent);
			if(result.result is Array){
				FSEModel.getInstance().elencoProvincie =  result.result as Array;
			}else
			{
				FSEModel.getInstance().elencoProvincie =  (result.result as ArrayCollection).toArray();	
			}
			reference.nextCommand( );
		}
		override public function fault(info:Object):void
		{
			Debug.logDebug( "LoadElencoProvince.fault " );
			reference.nextCommand( );
		}
	}
}