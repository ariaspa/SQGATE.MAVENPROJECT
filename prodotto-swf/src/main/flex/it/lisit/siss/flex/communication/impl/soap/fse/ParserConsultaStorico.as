package it.lisit.siss.flex.communication.impl.soap.fse
{
	 
	import it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE.VoConsultaStoricoDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE.VoOutputConsultaStoricoDCE;	 
	internal class ParserConsultaStorico
	{
		private var body:XML;
		public function ParserConsultaStorico(body:XML) 
		{
			this.body = body;
		}
		public function execute():VoOutputConsultaStoricoDCE
		{
			var consultaStoricoXml:XML	 		= body.child( "consultaStoricoDCE" )[0];
			var esitoConsultaStorico:String 	= body.child( "esitoConsultaStoricoDCE" )[0].child("esito");
			///
			var outConsulta:VoOutputConsultaStoricoDCE 	= new VoOutputConsultaStoricoDCE();
			if(esitoConsultaStorico!=null && esitoConsultaStorico.length>0)
			{
				outConsulta.esito = esitoConsultaStorico;
			}
			///
			var consultaStorico:VoConsultaStoricoDCE = new VoConsultaStoricoDCE();	
			var parser:ParserFascicoli = new ParserFascicoli(null);
			consultaStorico.listaDCE = parser.createListaDce2009(body.child("listaDCE"));
			///
			var cittadino:String			=  consultaStoricoXml.child( "cittadino" )[0].child( "idCittadino" );
			if(cittadino!=null && cittadino.length>0)
			{
				consultaStorico.idCittadino		=  cittadino;
			}
			///
			outConsulta.consultaStoricoDCE		= consultaStorico; 
			return outConsulta;
		}
	}
}
	