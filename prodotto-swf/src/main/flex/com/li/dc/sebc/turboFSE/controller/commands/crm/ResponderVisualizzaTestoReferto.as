package com.li.dc.sebc.turboFSE.controller.commands.crm
{
	import mx.rpc.IResponder;

	public class ResponderVisualizzaTestoReferto implements IResponder
	{
		private var reference:OttieniTestoRefertoCommand;

		public function ResponderVisualizzaTestoReferto(reference:OttieniTestoRefertoCommand)
		{
			this.reference = reference;
		}

		public function result(data:Object):void
		{
			this.reference.resultVisualizzaTestoReferto(data);
		}

		public function fault(info:Object):void
		{
			this.reference.faultVisualizzaTestoReferto(info);
		}
	}
}