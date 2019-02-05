package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.ResponderCommand;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;

	public class InterrogaAscoltatoreCDA2Command extends ResponderCommand
	{
		private var reference:ISequenceReference;
		public function InterrogaAscoltatoreCDA2Command()
		{
			super();
		}
		override public function execute(data:Object = null):void
		{
			Debug.logDebug( "InterrogaAscoltatoreCDA2Command.execute START ottieniDocumentoTestuale" );
			if(data is ISequenceReference){ 	
				reference = data as ISequenceReference;
				var nomeMetodo:String	= "FSE.ottieniDocumentoCDA2";
				var nameSpace:String	= "http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/ottieniDocumentoCDA2/";
				FactoryService.getInstance().getInterrogaAscoltatori(this,nomeMetodo,nameSpace).execute();
			}
		}
		override public function result(data:Object):void
		{
			if(data!=null){
				Debug.logDebug( "InterrogaAscoltatoreCDA2Command.result " );
				FSEModel.getInstance().documentoCDA2 = true;
				reference.nextCommand( );
			}else
			{
				FSEModel.getInstance().documentoCDA2 = false;
			}
		}
		override public function fault(info:Object):void
		{
			Debug.logDebug( "InterrogaAscoltatoreCDA2Command.fault " );
			FSEModel.getInstance().documentoCDA2 = false;
			reference.nextCommand( );
		}
	}
}