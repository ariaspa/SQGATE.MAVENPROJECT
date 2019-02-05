package it.lisit.siss.flex.gui.assistito
{
	import flash.events.Event;
	
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiCittadino;

	public class CittadinoIdentificatoEvent extends Event
	{
		public var cittadino:VoDatiCittadino;
		public function CittadinoIdentificatoEvent(type:String, cittadino:VoDatiCittadino)
		{
			super(type);
			this.cittadino = cittadino;
		}
	}
}