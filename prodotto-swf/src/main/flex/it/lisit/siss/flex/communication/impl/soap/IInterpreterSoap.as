package it.lisit.siss.flex.communication.impl.soap
{
	import it.lisit.siss.flex.communication.ValueObject;
	public interface IInterpreterSoap
	{
		function toXmlInput(vo:ValueObject=null):XML
		function toVoOutput(body:XML=null):ValueObject
		function getNameService():String;
		function getQNameResponse():QName
	}
}