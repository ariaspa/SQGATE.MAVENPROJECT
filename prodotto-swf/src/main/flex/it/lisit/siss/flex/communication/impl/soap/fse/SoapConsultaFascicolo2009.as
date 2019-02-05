package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaFascicolo2009;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoInputConsultaFascicolo2009;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	 
	internal class SoapConsultaFascicolo2009 extends AbstractConsultaFascicolo2009
	{
		private var communicator:ICommunicatorSoap;	 
		public function SoapConsultaFascicolo2009(communicator:ICommunicatorSoap )
		{
			super( );
			this.communicator = communicator;
		}
		public override function execute(vo:VoInputConsultaFascicolo2009):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapConsultaFascicolo2009(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}