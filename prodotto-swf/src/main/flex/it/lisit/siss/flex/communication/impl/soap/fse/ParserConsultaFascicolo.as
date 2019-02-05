package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoConsultaFascicolo;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoEventi;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoOutputConsultafascicolo;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.Vofascicolo;
	import it.lisit.siss.flex.utility.xml.XPathUtility;;
	internal class ParserConsultaFascicolo
	{
		private var body:XML;
		public function ParserConsultaFascicolo(body:XML)
		{
			this.body = body;
		}
		public function execute():VoOutputConsultafascicolo
		{
			var npagine:String 					= body.child( "nPagine" );
			var consultaFascicolo:XML	 		= body.child( "consultaFascicolo" )[0];
			var esitoConsultaFascicolo:String 	= body.child( "esitoConsultaFascicolo" )[0].child("esito");
			///
			var outConsulta:VoOutputConsultafascicolo 	= new VoOutputConsultafascicolo();
			outConsulta.nPagine							= (npagine==null || npagine.length==0)?0:Number(npagine);
			if(esitoConsultaFascicolo!=null && esitoConsultaFascicolo.length>0)
			{
				outConsulta.esito						= esitoConsultaFascicolo;
			}
			///	
			var consultaFascicoloVo:VoConsultaFascicolo	= new VoConsultaFascicolo();
			///
			if(consultaFascicolo!=null)
			{
				var folderList:XMLList = null;
				if(consultaFascicolo.fascicolo!=null && consultaFascicolo.fascicolo.listaFolder!=null)
				{
					folderList 		= consultaFascicolo.fascicolo.listaFolder.child("folder");
				}
				//var queryFolder:String 			= "//folder";
				//var folderList:XMLList 			= XPathUtility.execQuery( consultaFascicolo, queryFolder );
				if(folderList!=null)
				{
					consultaFascicoloVo.fascicolo 		= new Vofascicolo();
					var parserFascicoli:ParserFascicoli = new ParserFascicoli(folderList);
					consultaFascicoloVo.fascicolo.listaFolder = parserFascicoli.execute();
				}
				//var queryEventi:String 			= "//evento";	 
				//var eventList:XMLList		 	= XPathUtility.execQuery( consultaFascicolo , queryEventi );
				var eventList:XMLList = null;
				if(consultaFascicolo.eventi!=null && consultaFascicolo.eventi.listaEventi!=null)
				{
					eventList 		= consultaFascicolo.fascicolo.listaFolder.child("evento");
				}
				if(eventList!=null)
				{
					consultaFascicoloVo.eventi				= new VoEventi();
					var parserEventi:ParserEventi			= new ParserEventi(eventList);
					consultaFascicoloVo.eventi.listaEventi  = parserEventi.execute(); 
				}
				var cittadino:String			=  consultaFascicolo.child( "cittadino" )[0].child( "idCittadino" );
				var tipo:String					=  consultaFascicolo.child( "cittadino" )[0].child( "idCittadino" ).attribute("")
				if(cittadino!=null && cittadino.length>0)
				{
					consultaFascicoloVo.idCittadino		=  cittadino;
					//consultaFascicoloVo.tipoIdCittadino = 
				}
			}
			outConsulta.consultaFascicolo		= consultaFascicoloVo; 
			return outConsulta;
		}
	}
}
