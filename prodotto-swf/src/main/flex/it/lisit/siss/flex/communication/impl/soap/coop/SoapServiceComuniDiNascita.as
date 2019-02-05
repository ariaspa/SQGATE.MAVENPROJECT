package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceComuniDiNascita;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapServiceComuniDiNascita extends AbstractServiceComuniDiNascita
	{
		private var communicator:ICommunicatorSoap;
		public function SoapServiceComuniDiNascita(comm:ICommunicatorSoap)
		{
			super();
			communicator = comm;
		}
		override public function getElenco(codiceProvincia:String):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapComuniDiNascita(),this, new CodProv(codiceProvincia));
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.COOP_ERROR);
			}
		}
	}
}
	import it.lisit.siss.flex.communication.ValueObject;
	

class CodProv extends ValueObject
{
	public var codiceProvincia:String;
	public function CodProv(cod:String)
	{
		super();
		codiceProvincia = cod;
	}
}