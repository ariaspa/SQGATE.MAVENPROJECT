package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;

	public class OpenPdtService extends ControlWait
	{
		private var reference:ISequenceReference;
		public function OpenPdtService()
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
			var model:FSEModel		= FSEModel.getInstance();
			var conf:Configuration 	= model.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
			if(prm !=null)
			{
				var pdt:PercorsoDiagnosticoTerapeutico	= prm as PercorsoDiagnosticoTerapeutico;
				FactoryService.getInstance().getApriPDT( new WrapResponder(this), pdt );
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