package com.li.dc.sebc.turboFSE.model.vo
{
	
	import com.li.dc.sebc.turboFSE.model.vo.TreeEventi;
	
	import it.lispa.siss.sebc.middleground.entity.response.Risposta;

	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.RispostaTreeEventi")]
	public class RispostaTreeEventi extends Risposta
	{
		public var tree:TreeEventi;		
		public function RispostaTreeEventi()
		{
					
		}
	}
}