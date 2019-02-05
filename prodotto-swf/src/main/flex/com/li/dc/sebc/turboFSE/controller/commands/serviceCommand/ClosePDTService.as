package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	
	public class ClosePDTService extends ControlWait
	{
		private var reference:ISequenceReference;
		public function ClosePDTService()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			//prm = {item:lista.selectedItem,date:dataField.selectedDate};
			if(data==null)return;
			var prm:Object	= null;
			if( data is ISequenceReference)
			{
				reference  =  data as ISequenceReference;
			}
			if(reference!=null)
			{
				prm = reference.getData();
			}else
			{
				prm = data;	
			}
			if(prm !=null)
			{
				//(responder:IResponder, pdt:PercorsoDiagnosticoTerapeutico, note:String )
				// TODO CONTROLLARE LE NOTE
				var note:String		= "";
				var pdt:PercorsoDiagnosticoTerapeutico	= prm as PercorsoDiagnosticoTerapeutico;
				FactoryService.getInstance().getChiudiPDT( new WrapResponder(this), pdt ,note).execute();
			}
		}
		override protected function executeResult(data:Object):void
		{
			if(reference!=null)
			{
				reference.nextCommand( data );
			} 
		}
		override protected function executeFault(info:Object):void
		{
			if(reference!=null)
			{
				reference.nextCommand( info );
			} 
		}
	}
}