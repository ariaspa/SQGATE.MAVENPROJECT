package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.smartCard.ISmartCardService;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	
	import mx.rpc.IResponder;
	/**
	 * Utilizzato dallo smartcardmanager come erogatore dei servizi
	 * @author Marco Salonia
	 * 
	 */
	public class TurboSmartCardService implements ISmartCardService
	{
		private var flagCitt:Boolean = false;
		private var temp:Object;
		public function TurboSmartCardService()
		{
			Debug.logDebug( "TurboSmartCardService " );
		}
		public function readOperatore(responder:IResponder):void
		{
			Debug.logDebug( "TurboSmartCardService . readOperatore" );
			// così ne ho notizia anch'io
			var wrapOpe:OpeWrapResponder = new OpeWrapResponder(callbackOpe , new WrapResponder(responder) );
			Controller.getInstance().executeCommand(ConstCommand.LOAD_OPERATORE,wrapOpe);
		}
		private function callbackOpe(flagOk:Boolean):void
		{
			// ok c'è l'ope
			if(flagOk)
			{
				// nel frattempo mi è stato chiesto anche il citt
				if(flagCitt)
				{
					loadCitt( temp.responder );
				}
			}
		}
		public function readCittadino(responder:IResponder):void
		{
			var model:FSEModel 	= FSEModel.getInstance();
			var ope:Operatore 	= model.retrieveProxy( ConstDataProxy.DATA_OPERATORE ).getData() as Operatore;
			if(ope!=null)
			{
				loadCitt( responder );
			}else
			{
				flagCitt = true;
				temp = {responder:responder};		
			}
		}
		private function loadCitt(responder:IResponder):void
		{
			Debug.logDebug( "TurboSmartCardService . loadCitt" );
			Controller.getInstance().executeCommand(ConstCommand.LOAD_CITTADINO_SMART_CARD,new WrapResponder( responder ) );
		}
		public function stopReading():void
		{
			flagCitt = false;
		}
	}
}
	import mx.rpc.IResponder;
	
class OpeWrapResponder implements IResponder
{
	private var rep:IResponder;
	private var callback:Function;
	public function OpeWrapResponder(callback:Function, rep:IResponder)
	{
		this.rep = rep;
		this.callback = callback;
	}
	public function result(data:Object):void
	{
		rep.result(data);
		callback(true);
	}
	public function fault(info:Object):void
	{ 
		rep.fault(info);
		callback(false);
	}
}

	 