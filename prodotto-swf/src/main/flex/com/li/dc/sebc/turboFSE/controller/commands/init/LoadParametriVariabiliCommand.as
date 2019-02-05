package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.ResponderCommand;
	import com.li.dc.sebc.turboFSE.model.FSEModel;

	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;

	import mx.rpc.events.ResultEvent;

	public class LoadParametriVariabiliCommand extends ResponderCommand
	{
		private var reference:ISequenceReference;

		public function LoadParametriVariabiliCommand()
		{
			super();
		}

		override public function execute(data:Object=null):void
		{
			Debug.logDebug( "LoadParametriVariabiliCommand.execute " );
			if(data is ISequenceReference){
				reference = data as ISequenceReference;
				FactoryService.getInstance().getParametriVariabili(this).execute();
			}
		}

		override public function result(data:Object):void
		{
			Debug.logDebug( "LoadParametriVariabiliCommand.result " );
			var resultEvent:ResultEvent = (data as ResultEvent);
			FSEModel.getInstance().parametriVariabili = resultEvent.result;
			reference.nextCommand( );
		}

		override public function fault(info:Object):void
		{
			Debug.logDebug( "LoadParametriVariabiliCommand.fault: " + info);
			reference.nextCommand( );
		}
	}
}