package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoAutorizza;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoInputAutorizzaDce;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoStrutturaCreazione;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.IIterator;
	//
	internal class InterpreterSoapAutorizzaDce2009_01 implements IInterpreterSoap
	{
		public function InterpreterSoapAutorizzaDce2009_01()
		{
		}
		public function toXmlInput(vo:ValueObject=null):XML
		{
			return new CreateInputAutorizza().execute( vo as VoInputAutorizzaDce);
		}
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserAutorizzaDce2009_01().execute( body );
		}
		public function getNameService():String
		{
			return "FSE.autorizzaDCE";
		}
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/autorizzaDCE/","FSE.autorizzaDCEResponse");
		}
	} 
}