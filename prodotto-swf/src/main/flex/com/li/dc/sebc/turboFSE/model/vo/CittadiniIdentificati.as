package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.response.Risposta;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.CittadiniIdentificati")]
	public class CittadiniIdentificati extends Risposta
	{
		public var  listaCittadini:ArrayCollection;
		public function CittadiniIdentificati()
		{
			super();
		}
	}
}