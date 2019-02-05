package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoCittadino;
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoIndiceFascicolo;
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoOttieniIndiceFascicolo;
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoOutputOttieniIndiceFascicolo;
	
	internal class ParserOttieniIndiceFascicolo
	{
		private var _body:XML;
		public function ParserOttieniIndiceFascicolo(body:XML)
		{
			this._body = body;
		}
 

		public function execute():VoOutputOttieniIndiceFascicolo {
			var outOttieniIndice:VoOutputOttieniIndiceFascicolo = new VoOutputOttieniIndiceFascicolo();
			var npagine:String 						= _body.child( "nPagine" );
			var ottieniIndiceFascicolo:XML	 		= _body.child( "ottieniIndiceFascicolo" )[0];
			var esitoOttieniIndiceFascicolo:String 	= _body.child( "esitoOttieniIndiceFascicolo" )[0].child("esito");
			 
			outOttieniIndice.nPagine		= (npagine == null || npagine.length == 0)? 1 : Number(npagine);
			if (esitoOttieniIndiceFascicolo != null && esitoOttieniIndiceFascicolo.length > 0) {
				outOttieniIndice.esito = esitoOttieniIndiceFascicolo;
			}
			if (ottieniIndiceFascicolo != null && ottieniIndiceFascicolo.length() > 0) {
				var ottIndiceFasc:VoOttieniIndiceFascicolo = new VoOttieniIndiceFascicolo();
				var idCitt:String = ottieniIndiceFascicolo.child("cittadino")[0].child("idCittadino");
				var citt:VoCittadino = new VoCittadino();
				citt.idCittadino = idCitt;
				ottIndiceFasc.cittadino = citt;
				
				var folderList:XMLList = null;
				if (ottieniIndiceFascicolo.indiceFascicolo != null && 
						ottieniIndiceFascicolo.indiceFascicolo.listaFolder != null) {
					
					folderList = ottieniIndiceFascicolo.indiceFascicolo.listaFolder.child("folder");
					if(folderList != null)
					{
						ottIndiceFasc.indiceFascicolo 		= new VoIndiceFascicolo();
						var parserFascicoli:ParserFascicoli = new ParserFascicoli(folderList);
						ottIndiceFasc.indiceFascicolo.listaFolder = parserFascicoli.executeParserIndice();
					}
				}
				outOttieniIndice.ottieniIndiceFascicolo = ottIndiceFasc;
			}
			return outOttieniIndice;
		}
		
	}
	
}