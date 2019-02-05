package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.ResponderCommand;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;

	public class InterrogaAscoltatoreTestualeCommand extends ResponderCommand
	{
		private var reference:ISequenceReference;
		public function InterrogaAscoltatoreTestualeCommand()
		{
			super();
		}
		override public function execute(data:Object = null):void
		{
			Debug.logDebug( "InterrogaAscoltatoreTestualeCommand.execute START ottieniDocumentoTestuale" );
			if(data is ISequenceReference){
				reference = data as ISequenceReference;
				var nomeMetodo:String	= "FSE.ottieniDocumentoTestuale";
				var nameSpace:String	= "http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/ottieniDocumentoTestuale/";
				FactoryService.getInstance().getInterrogaAscoltatori(this,nomeMetodo,nameSpace).execute();
			}
		}
		override public function result(data:Object):void
		{
			if(data!=null){
				Debug.logDebug( "InterrogaAscoltatoreTestualeCommand.execute STOP ottieniDocumentoTestuale" );
				FSEModel.getInstance().documentoTestuale = true;
				reference.nextCommand( );
			}
		}
		override public function fault(info:Object):void
		{
			Debug.logDebug( "InterrogaAscoltatoreTestualeCommand.fault " );
			FSEModel.getInstance().documentoTestuale = false;
			reference.nextCommand( );
		}
	}
}