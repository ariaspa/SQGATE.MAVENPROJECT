package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.response.Risposta;
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.RispostaTree")]
	public class RispostaTree extends Risposta
	{
		public var tree:Tree;
		public function RispostaTree()
		{
			super();
		}
	}
}