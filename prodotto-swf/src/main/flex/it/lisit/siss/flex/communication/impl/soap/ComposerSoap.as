package it.lisit.siss.flex.communication.impl.soap
{
	import flash.events.EventDispatcher;
	
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	/**
	 * 
	 * @author Diego Fossati - Marco Salonia
	 * 
	 */	
	public final class ComposerSoap
	{
		/**
		 * Spedisce la richiesta al servizio  
		 * Throw SebException(id=SebException.IMPL_ERROR)
		 * @param Communicator
		 * @param interpreter
		 * @param dispatcher
		 * @param vo
		 * 
		 */		 	
		public static function send(communicator:ICommunicatorSoap, interpreter:IInterpreterSoap,dispatcher:EventDispatcher,vo:ValueObject=null):void
		{
			try{
				 var strategy:StrategyContainer = new StrategyContainer(communicator,interpreter,dispatcher,vo);
				strategy.execute();
			}catch(e:Error)
			{
				 throw new SebException(e.message,SebException.IMPL_ERROR);
			}
		}
	}
}