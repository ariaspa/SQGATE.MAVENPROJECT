package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.response.Risposta;
	/* DA COMPLETARE BISOGNA COSTRUIRE L'OGGETTO IN JAVA
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.RispostaTimeline")]
	*/
	public class RispostaTimeline extends Risposta
	{
		public var timeline:DataTimeline;
		public function RispostaTimeline()
		{
			super();
		}
		
	}
}