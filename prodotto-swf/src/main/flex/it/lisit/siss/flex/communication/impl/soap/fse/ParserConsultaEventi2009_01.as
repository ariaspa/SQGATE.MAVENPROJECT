package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaEventiDaFlussi.VoConsultaEventi;
	import it.lisit.siss.flex.communication.fse.voConsultaEventiDaFlussi.VoOutputConsultaEventiDaFlussi;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoEventi;
	
	internal class ParserConsultaEventi2009_01
	{
		public function ParserConsultaEventi2009_01()
		{
		}
		public function execute(output:XML):VoOutputConsultaEventiDaFlussi
		{
			var outPut:VoOutputConsultaEventiDaFlussi = new VoOutputConsultaEventiDaFlussi();
			outPut.esito						= "";	
			outPut.nPagine	 					= Number(output.child( "nPagine" ));
			var consultaEventi:XMLList	 		= output.child( "consultaEventiDaFlussi" );
			var esitoCEventi:XMLList 			= output.child( "esitoConsultaEventiDaFlussi" );
			if(esitoCEventi!=null && esitoCEventi.length()>0)
			{
				outPut.esito					= esitoCEventi[0].child("esito");
			}
			var cEv:VoConsultaEventi			= new VoConsultaEventi();
			cEv.idCittadino						= "";
			cEv.tipoIdCittadino					= "";
			var citt:XMLList					= consultaEventi.child("cittadino");
			if(citt!=null && citt.length()>0)
			{
				cEv.idCittadino						= citt[0].child("idCittadino");
				cEv.tipoIdCittadino					= citt[0].attribute("idCittadino");
			}
			var eventList:XMLList		 		= consultaEventi.child("listaEventi");
			cEv.eventi							= null;	
			if(eventList!=null && eventList.length()>0)
			{
				cEv.eventi						= new VoEventi();
				var parserEventi:ParserEventi	= new ParserEventi(eventList.children());
				cEv.eventi.listaEventi  		= parserEventi.execute(); 
			}
			outPut.consultaEventi				= cEv;
			return outPut;
		}
	}
}