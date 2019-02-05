package it.lisit.siss.flex.communication.coop.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;

	public class AbstractServiceComuniDiNascita extends AbstractServiceSEB
	{
		public function AbstractServiceComuniDiNascita()
		{
			super();
		}
		
		virtual public function getElenco(codiceProvincia:String):void{}
		
	}
}