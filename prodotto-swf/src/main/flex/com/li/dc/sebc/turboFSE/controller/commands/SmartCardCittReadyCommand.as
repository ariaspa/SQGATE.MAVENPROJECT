package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.nodeView.AssistitoFse;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;

	public class SmartCardCittReadyCommand extends Command
	{
		public function SmartCardCittReadyCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data != null)
			{
				Debug.logWarning("TODO completare SmartCardCittReadyCommand ");
				var cittadino:Cittadino = data as Cittadino;
				var model:FSEModel 		= FSEModel.getInstance();
				model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).update( cittadino );
				// setto due volte lo stato per poter chimare il clear automatico
				model.retrieveProxy(ConstDataProxy.STATE_ASSISTITO_FSE).update( AssistitoFse.IDENTIFICA );
				model.retrieveProxy(ConstDataProxy.STATE_ASSISTITO_FSE).update( AssistitoFse.VISUALIZZA );
			}
		}
	}
}