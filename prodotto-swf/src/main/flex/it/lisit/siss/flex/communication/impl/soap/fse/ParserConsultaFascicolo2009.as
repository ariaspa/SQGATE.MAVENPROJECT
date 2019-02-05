package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoConsultaFascicolo;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoEventi;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.Vofascicolo;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoOutputConsultaFascicolo2009;;
	internal class ParserConsultaFascicolo2009
	{
		private var body:XML;
		public function ParserConsultaFascicolo2009(body:XML) 
		{
			this.body = body;
		}
		public function execute():VoOutputConsultaFascicolo2009
		{
			var npagine:String 					= body.child( "nPagine" );
			var consultaFascicolo:XML	 		= body.child( "consultaFascicolo" )[0];
			var esitoConsultaFascicolo:String 	= body.child( "esitoConsultaFascicolo" )[0].child("esito");
			///
			var outConsulta:VoOutputConsultaFascicolo2009 	= new VoOutputConsultaFascicolo2009();
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
					consultaFascicoloVo.fascicolo.listaFolder = parserFascicoli.executeParser2009();
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
