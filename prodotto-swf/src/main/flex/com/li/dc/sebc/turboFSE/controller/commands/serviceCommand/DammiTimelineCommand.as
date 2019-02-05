package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.VoInputTimeLine;
	import com.li.dc.sebc.turboFSE.model.vo.VoOutputTimeLine;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	
	public class DammiTimelineCommand extends ControlWait
	{
		public function DammiTimelineCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			FactoryService.getInstance().getTimeline( new WrapResponder( this ), getVoInput() ).execute();
		}
		private function getVoInput():VoInputTimeLine
		{
			var model:FSEModel 		= FSEModel.getInstance();
		 	//var thisYear:int  		= model.today.fullYear;
			//var firstYear:int 		= thisYear - 4;
			//var secndYear:int 		= thisYear + 1;
			var input:VoInputTimeLine 	= new VoInputTimeLine();
			// il calcolo adesso viene fatto sul server
			// da primo gennaio di 4 anni fa
			//input.dataInizio	= Number(firstYear).toString()+"0101";
			// al 31 dicembre dell'anno prossimo
			//input.dataFine		= Number(secndYear).toString()+"1231";model.today
			var td:Date			= model.today;
			// YYYYMMDD	 
			input.today			= ""+td.fullYear + addZero("" + (td.month + 1)) + addZero("" + td.date);
			return input;
		} 
		private function addZero(n:String):String
		{
			if(n.length==1)
			{
				return "0"+n; 
			}
			return n;
		}
		override protected function executeResult(data:Object):void
		{
			Debug.logDebug("DammiTimelineCommand ::: "+data);
			if(data is VoOutputTimeLine)
			{
				var thereIsRisposte:Boolean	= ((data as VoOutputTimeLine).risposte!=null && (data as VoOutputTimeLine).risposte.length>0);
				var thereIsTimeline:Boolean	= ((data as VoOutputTimeLine).timeLine!=null && (data as VoOutputTimeLine).timeLine.length>0);
				var thereIsNothing:Boolean	= !thereIsRisposte && !thereIsTimeline;
				if(thereIsRisposte)
				{
					visualizzaRisposte( (data as VoOutputTimeLine).risposte.toArray() );
				}else if(thereIsNothing)
				{
					createAlertVoid();
				}
				if(thereIsTimeline)
				{
					createSkinData( (data as VoOutputTimeLine).timeLine.toArray() );
				}
			}
		}
		private function createAlertVoid( ):void
		{
			MessageManager.getInstance().addMessage( "il servizio ha restituito null" );	
		}
		private function createSkinData(tml:Array):void
		{
			if(tml!=null && tml.length>0)
			{
				FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TIMELINE).update( tml );
				// fa scattare l'apertura della popup
				//var val:Boolean = FSEModel.getInstance().retrieveProxy(ConstDataProxy.OPENPOPUPTIMELINE).getData() as Boolean;
				//FSEModel.getInstance().retrieveProxy(ConstDataProxy.OPENPOPUPTIMELINE).update( !val );
			} 
		}
		
		private function visualizzaRisposte(risp:Array):void
		{
			var iter:IIterator = new ArrayIterator(risp);
			while(iter.hasNext())
			{
				//var risposta:Risposta = iter.next() as Risposta;
				var risposta:Object = iter.next();
				if(risposta!=null){
					if(risposta.esitoNegativo!=null )
					{
						MessageManager.getInstance().addMessage( risposta.esitoNegativo );
					}else if(risposta.fault!=null)
					{
						MessageManager.getInstance().addMessage( risposta.fault );
					}
					if(risposta.listaWarning!=null && risposta.listaWarning.warning !=null && risposta.listaWarning.warning.length>0)
					{
						MessageManager.getInstance().addMessage( risposta.listaWarning );	
					}
				}
			}
		}
		
		override protected function executeFault(info:Object):void
		{
			MessageManager.getInstance().addMessage( info );
		}
	}
}