package it.lisit.siss.flex.core
{
	public interface IUserMessage
	{
		function analyze( type:String ):Boolean;
		function useMessage( envelope:IEnvelopeMessage ):void;
	}
}