package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;

	public class AggiornaChangeTab extends Command
	{
		private var mod:FSEModel;
		public function AggiornaChangeTab()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data!=null && (data is int) && (data as int) >- 1 )
			{
				mod = FSEModel.getInstance();
				var inx:int = data as int;
				switch(inx)
				{
					case 0:
						break;
						setAssistito();	
					case 1:
						setRootFascicolo();
						break;
					case 2:
						setEventi();
						break;
					case 3:
						setTimeLine();
						// questa era la vecchgia chiamata adesso è stato tolto 
						// il pannello ed è stato messo al suo posto la timeline
						//setClassificazioni();
						break;
				}
			}
		}
		private function setAssistito():void
		{
		
		}
		private function setRootFascicolo():void
		{
			if(mod.reloadRootFascicolo)
			{
				mod.reloadRootFascicolo = false;
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_FASCICOLO);
			}
		}
		private function setEventi():void
		{
			if(mod.reloadRootFlussi)
			{
				mod.reloadRootFlussi = false;
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_FLUSSI);
			}
		}
		
		private function setClassificazioni():void
		{
			if(mod.reloadClassificazioni)
			{
				mod.reloadClassificazioni = false;
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_CLASSIFICAZIONI);
			}
		}
		private function setTimeLine():void
		{
			/*if(FSEModel.getInstance().reloadTimeline)
			{
				// AggiornaTimelineCommand
				FSEModel.getInstance().reloadTimeline = false;
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_TIMELINE);
			}*/
			/*else{
				var val:Boolean = FSEModel.getInstance().retrieveProxy(ConstDataProxy.OPENPOPUPTIMELINE).getData() as Boolean;
				FSEModel.getInstance().retrieveProxy(ConstDataProxy.OPENPOPUPTIMELINE).update( !val );
			}*/
			// Se è stato selezionato il tab della Timeline, apre la finestra
			Controller.getInstance().executeCommand( ConstCommand.GO_TEMPORALE  );
			
		}
	}
}