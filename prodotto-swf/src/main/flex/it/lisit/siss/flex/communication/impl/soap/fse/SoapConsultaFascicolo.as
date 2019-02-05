package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaFascicolo;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoInputConsultaFascicolo;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	 
	internal class SoapConsultaFascicolo extends AbstractConsultaFascicolo
	{
		private var communicator:ICommunicatorSoap;	 
		public function SoapConsultaFascicolo(communicator:ICommunicatorSoap )
		{
			super( );
			this.communicator = communicator;
		}
		public override function execute(vo:VoInputConsultaFascicolo):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapConsultaFascicolo(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}