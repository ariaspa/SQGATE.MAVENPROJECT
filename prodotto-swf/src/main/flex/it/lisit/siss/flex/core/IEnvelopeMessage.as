package it.lisit.siss.flex.core
{
	public interface IEnvelopeMessage
	{
		  function getMessage():MessageObject;
		  function completeUse():void;
		  function stopPropagation():void;
	}
}