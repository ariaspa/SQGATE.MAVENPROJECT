package it.lisit.siss.flex.communication.icce.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoInputIdentificaCittadinoEsteso

	public class AbstractServiceIdentificaCittadinoEsteso2008_01 extends AbstractServiceSEB
	{
		public function AbstractServiceIdentificaCittadinoEsteso2008_01()
		{
			super();
		}
		
		virtual public function execute(vo:VoInputIdentificaCittadinoEsteso):void{}
		
	}
}