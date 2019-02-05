package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoAttributiSpecifici;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoAutoreDocumento;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoAutorizza;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoCittadino;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoInputAutorizzaDce;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoPrestazione;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoStrutturaCreazione;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.utility.debug.Debug;
	import it.lisit.siss.flex.utility.xml.XPathUtility;
	internal class CreateInputAutorizza
	{
		public function CreateInputAutorizza()
		{
		}
		private function isValid(str:String=null):Boolean
		{
			if(str==null || str.length==0)return false;
			return true;
		}
		public function execute(vo:VoInputAutorizzaDce):XML
		{
			var input	:XML				= ENVELOPE.copy();
			var autorizzaDCE:XML 			= AUTORIZZADCE.copy();
			//////////////////////////////////////////////////////////
			var children:XML				= input.children()[0];
			children.appendChild( autorizzaDCE );
			if(autorizzaDCE!=null)
			{
				var iter:IIterator 			= vo.iteratorAutorizzazioni;
				iter.reset();
				var counter:uint			= 0;
				
				while(iter.hasNext() && (counter++) < MAX_M)
				{
					var voAutorizza:VoAutorizza		= iter.next() as VoAutorizza;
					var richiestaAutorizzaDce:XML	= createRichiesta( voAutorizza );
					autorizzaDCE.appendChild( richiestaAutorizzaDce );
				}
			}
		 	return input;
		}
		
		private function createRichiesta(vo:VoAutorizza):XML
	 	{
	 		//XPathUtility.setAttributeValueIntoNode(apripdt,"//idCittadino","tipo",input.tipoIdCittadino);
	 		var richiesta:XML			= RICHIESTA.copy();
	 		// strutturaCreazione
	 		if(vo.strutturaCreazione!=null)
	 			addStrutturaCreazione(vo.strutturaCreazione , richiesta);
	 		if(vo.attributiSpecifici!=null)
	 			addAttributiSpecifici(vo.attributiSpecifici , richiesta);
	 		if(vo.autoreDocumento!=null)
	 			addAutoreDocumento(vo.autoreDocumento , richiesta);
	 		if(vo.cittadino!=null)
	 			addCittadino(vo.cittadino , richiesta);
	 		 
	 		if(isValid(vo.idsetDocumenti))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//idSetDocumenti",vo.idsetDocumenti );
	 		}
	 		if(isValid(vo.dataOraCreazione))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//dataOraCreazione",vo.dataOraCreazione );
	 		}
	 		if(isValid(vo.idTipoDocumento))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//idTipoDocumento",vo.idTipoDocumento );
	 		}
	 		if(isValid(vo.noteReperibilita))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//noteReperibilita",vo.noteReperibilita );
	 		}
	 		return richiesta;
	 	}
	 	private function addCittadino(cittadino:VoCittadino,richiesta:XML):void
	 	{
	 		if(isValid(cittadino.cognomeCittadino))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//cognomeCittadino",cittadino.cognomeCittadino );
	 		}
	 		if(isValid(cittadino.nomeCittadino))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//nomeCittadino",cittadino.nomeCittadino );
	 		}
	 		if(isValid(cittadino.tipoIdCittadino) && cittadino.tipoIdCittadino!="CF")
	 		{
	 			XPathUtility.setAttributeValueIntoNode(richiesta,"//idCittadino","tipo",cittadino.tipoIdCittadino);
	 		}
	 		if(isValid(cittadino.idCittadino))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//idCittadino",cittadino.idCittadino );
	 		}
	 	}
	 	private function addAutoreDocumento(autore:VoAutoreDocumento,richiesta:XML):void
	 	{
	 		if(isValid(autore.codiceFiscale))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//codiceFiscale",autore.codiceFiscale );
	 		}
	 		if(isValid(autore.cognome))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//cognome",autore.cognome );
	 		}
	 		if(isValid(autore.nome))
	 		{
	 			XPathUtility.setNodeValue(richiesta,"//nome",autore.nome );
	 		}
	 	}
	 	
		private function addAttributiSpecifici(attributi:VoAttributiSpecifici,richiesta:XML):void
		{
			if(attributi!=null)
			{
				if(isValid(attributi.numeroNosologico))
		 		{
		 			XPathUtility.setNodeValue(richiesta,"//numeroNosologico",attributi.numeroNosologico );
		 		}
		 		if(isValid(attributi.numeroPraticaPS))
		 		{
		 			XPathUtility.setNodeValue(richiesta,"//numeroPraticaPS",attributi.numeroPraticaPS );
		 		}
		 		if(isValid(attributi.numeroPrericovero))
		 		{
		 			XPathUtility.setNodeValue(richiesta,"//numeroPrericovero",attributi.numeroPrericovero );
		 		}
		 		//
		 		if(attributi.prestazioniAssociate != null)
		 		{
		 			attributi.prestazioniAssociate.reset();
		 			var xmPreAss:XML	= XPathUtility.getNode(richiesta,"//prestazioniAssociate"); 
		 			while(attributi.prestazioniAssociate.hasNext())
		 			{
		 				//var pres:* = attributi.prestazioniAssociate.next();
		 				var pres:VoPrestazione = attributi.prestazioniAssociate.next() as VoPrestazione;
		 				addPrestazione(pres,xmPreAss);
		 			}
		 		}
			}
		}
		private function addPrestazione(pres:VoPrestazione,xmPreAss:XML):void
		{
			var child:XML			= PRESTAZIONE.copy();
			if(isValid(pres.idPrestazioneSISS))
	 		{
	 			XPathUtility.setNodeValue(child,"//idPrestazioneSISS",pres.idPrestazioneSISS );
	 		}
	 		if(isValid(pres.IUP))
	 		{
	 			XPathUtility.setNodeValue(child,"//IUP",pres.IUP );
	 		}
			xmPreAss.appendChild( child );
		}
		private function addStrutturaCreazione(strutturaCreazione:VoStrutturaCreazione,richiesta:XML):void
		{
			if(strutturaCreazione!=null)
			{
		 		if(isValid(strutturaCreazione.idEnte))
		 		{
		 			XPathUtility.setNodeValue(richiesta,"//idEnte",strutturaCreazione.idEnte );
		 		}
		 		if(isValid(strutturaCreazione.idPresidio))
		 		{
		 			XPathUtility.setNodeValue(richiesta,"//idPresidio",strutturaCreazione.idPresidio );
		 		}
		 		if(isValid(strutturaCreazione.idUnitaOperativaClinica))
		 		{
		 			XPathUtility.setNodeValue(richiesta,"//idUnitaOperativaClinica",strutturaCreazione.idUnitaOperativaClinica );
		 		}
	 		}
		}
		
		////////////////////////
		private static const MAX_M:uint		= 20;
		
		private static const ENVELOPE:XML = <SOAP-ENV:Envelope 
			xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"> 	
				<SOAP-ENV:Body>
					 
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;
		
		private static const AUTORIZZADCE:XML = <m:FSE.autorizzaDCE xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/autorizzaDCE/" dataSetVersion="1.0" ></m:FSE.autorizzaDCE>;
						
			
		private static const PRESTAZIONE:XML = <prestazione>
											        <IUP></IUP>
											        <idPrestazioneSISS></idPrestazioneSISS>
										      	</prestazione>;
										      						
		private static const RICHIESTA:XML   =  <richiestaAutorizzaDCE>
												  <strutturaCreazione>
												    <idEnte></idEnte>
												    <idPresidio></idPresidio>
												    <idUnitaOperativaClinica></idUnitaOperativaClinica>
												  </strutturaCreazione>
																
												  <cittadino>
												    <idCittadino tipo="CF"></idCittadino>
												    <nomeCittadino> </nomeCittadino>
												    <cognomeCittadino> </cognomeCittadino>
												  </cittadino>
													
												  <autoreDocumento>
												    <codiceFiscale></codiceFiscale>
												    <cognome></cognome>
												    <nome></nome>
												  </autoreDocumento>
													
												  <idSetDocumenti></idSetDocumenti>
												  <noteReperibilita></noteReperibilita>
												  <idTipoDocumento></idTipoDocumento>
												  <dataOraCreazione></dataOraCreazione>
												  <hashDocumento></hashDocumento>
													
												  <attributiSpecifici>
												    <prestazioniAssociate>
												      
												    </prestazioniAssociate>
													    
												    <numeroPraticaPS></numeroPraticaPS>
												    <numeroNosologico></numeroNosologico>
												    <numeroPrericovero></numeroPrericovero>
													    
													</attributiSpecifici>
												</richiestaAutorizzaDCE>;
	}
}