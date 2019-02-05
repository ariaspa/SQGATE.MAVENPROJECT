package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.ConstTipiAttributiDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCEEvaluationNote;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCELDimissione;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCEPSoccorso;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCEReferto;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAllegato;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCaratterizzazione;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoInputOttieniDocumentoTestuale;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoPrestazione;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapOttieniDocumentoTestuale implements IInterpreterSoap
	{
		public function InterpreterSoapOttieniDocumentoTestuale()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var ottieniDoc:XML = INPUT_OTTIENI_DOC_TEST.copy();
			var input:VoInputOttieniDocumentoTestuale;
			try 
			{
				input = vo as VoInputOttieniDocumentoTestuale;
			} catch (e:Error) {
				throw new SebException("ValueObject non di tipo VoInputOttieniDocumentoTestuale",SebException.FSE_ERROR);
			}
			if (input.idTipoDocumento == null || input.idTipoDocumento.length == 0) {
				throw new SebException("VoInputOttieniDocumentoTestuale.idTipoDocumento non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//idTipoDocumento", input.idTipoDocumento);
			if (input.disciplinaErogazione == null || input.disciplinaErogazione.length == 0) {
				XPathUtility.removeNode(ottieniDoc, "//disciplinaErogazione");
			} else {
				XPathUtility.setNodeValue(ottieniDoc, "//disciplinaErogazione", input.disciplinaErogazione);
			}
			if (input.caratterizzazioniCliniche == null || input.caratterizzazioniCliniche.iterator == null) {
				XPathUtility.removeNode(ottieniDoc, "//caratterizzazioniCliniche");
			} else {
				var itCarateriz:IIterator = input.caratterizzazioniCliniche.iterator;
				var i:int = 0;
				while (itCarateriz.hasNext()) {
					var carat:VoCaratterizzazione = null;
					try {
						carat = itCarateriz.next() as VoCaratterizzazione;
						i++;
					} catch (e:Error) {
						if (i == 0 && !itCarateriz.hasNext())
							XPathUtility.removeNode(ottieniDoc, "//caratterizzazioniCliniche");
							
						continue;
					}
					var inputCaratterizzazioni:XML = INPUT_CARATTERIZ.copy();
					if (carat.dizionario == null || carat.dizionario.length == 0) {
						throw new SebException("VoCaratterizzazione.dizionario non valido", SebException.FSE_ERROR);
					}
					XPathUtility.setNodeValue(inputCaratterizzazioni, "//dizionario", carat.dizionario);
					
					if (carat.codice == null || carat.codice.length == 0) {
						throw new SebException("VoCaratterizzazione.codice non valido", SebException.FSE_ERROR);
					}
					XPathUtility.setNodeValue(inputCaratterizzazioni, "//codice", carat.codice);
					XPathUtility.importNode(ottieniDoc, "//caratterizzazioniCliniche", inputCaratterizzazioni);
				}
			}
			
			if (input.dataOraCreazione == null || input.dataOraCreazione.length != 14) {
				throw new SebException("VoInputOttieniDocumentoTestuale.dataOraCreazione non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//dataOraCreazione", input.dataOraCreazione);
			
			if (input.documento == null) {
				throw new SebException("VoInputOttieniDocumentoTestuale.documento non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//documento/idSetDocumenti", input.documento.idSetDocumenti);
			XPathUtility.setNodeValue(ottieniDoc, "//documento/nVersione", new String(input.documento.nVersione));
			XPathUtility.setNodeValue(ottieniDoc, "//documento/linguaggioDocumento", input.documento.linguaggioDocumento);
			
			if (input.documento.formato == null || input.documento.formato.length == 0) {
				throw new SebException("VoDocumentoB64.formato non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//documento/formato", input.documento.formato);
			
			if (input.documento.contenuto == null || input.documento.contenuto.length == 0) {
				throw new SebException("VoDocumentoB64.contenuto non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//documento/contenuto", input.documento.contenuto);
			
			if (input.documento.uri == null || input.documento.uri.length == 0) {
				throw new SebException("VoDocumentoB64.uri non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//documento/uri", input.documento.uri);

			if (input.documento.hashDocumento == null || input.documento.hashDocumento.length == 0) {
				throw new SebException("VoDocumentoB64.hashDocumento non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//documento/hashDocumento", input.documento.hashDocumento);
			
			if (input.documento.algoritmoHash != null && input.documento.algoritmoHash.length <= 10) {
				XPathUtility.setNodeValue(ottieniDoc, "//documento/algoritmoHash", input.documento.algoritmoHash);
			} 
			XPathUtility.setNodeValue(ottieniDoc, "//documento/sizeDocumento", input.documento.sizeDocumento);
					
			if (input.listaAllegati == null || input.listaAllegati.iterator == null) {
				XPathUtility.removeNode(ottieniDoc, "//listaAllegati");
			} else {
				var itAllegati:IIterator = input.listaAllegati.iterator;
				i = 0;
				while (itAllegati.hasNext()) {
					var allegato:VoAllegato = null;
					try {
						allegato = itAllegati.next() as VoAllegato;
						i++;
					} catch (e:Error) {
						if (i == 0 && !itAllegati.hasNext()) {
							XPathUtility.removeNode(ottieniDoc, "//listaAllegati");
							continue;
						}
							
						break;
					}
					var inputAllegato:XML = INPUT_ALLEGATI.copy();
					if (allegato.linkAllegato == null || allegato.linkAllegato.length == 0) {
						throw new SebException("VoAllegato.linkAllegato non valido", SebException.FSE_ERROR);
					}
					XPathUtility.setNodeValue(inputAllegato, "//linkAllegato", allegato.linkAllegato);
					
					if (allegato.formatoAllegato == null || allegato.formatoAllegato.length == 0) {
						throw new SebException("VoAllegato.formatoAllegato non valido", SebException.FSE_ERROR);
					}
					XPathUtility.setNodeValue(inputAllegato, "//formatoAllegato", allegato.formatoAllegato);
					XPathUtility.importNode(ottieniDoc, "//listaAllegati", inputAllegato);
				}
			}
			
			if (input.reteDiPatologia == null || input.reteDiPatologia.length == 0) {
				XPathUtility.removeNode(ottieniDoc, "//reteDiPatologia");
			} else {
				XPathUtility.setNodeValue(ottieniDoc, "//reteDiPatologia", input.reteDiPatologia);
			}
			
			if (input.idTipoDocumentoLOINC == null || input.idTipoDocumentoLOINC.length == 0) {
				XPathUtility.removeNode(ottieniDoc, "//idTipoDocumentoLOINC");
			} else {
				XPathUtility.setNodeValue(ottieniDoc, "//idTipoDocumentoLOINC", input.idTipoDocumentoLOINC);
			}
			
			if (input.cittadino == null) {
				throw new SebException("VoInputOttieniDocumentoTestuale.cittadino non valido", SebException.FSE_ERROR);
			}
			if (input.cittadino.idCittadino == null) {
				throw new SebException("VoCittadino.idCittadino non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//cittadino/idCittadino", input.cittadino.idCittadino);
			if (input.cittadino.tipoIdCittadino == null || input.cittadino.tipoIdCittadino != "CF") {
				throw new SebException("VoCittadino.tipo non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(ottieniDoc, "//cittadino/idCittadino", "tipo", input.cittadino.tipoIdCittadino);
			
			if (input.autoreDocumento == null) {
				throw new SebException("VoInputOttieniDocumentoTestuale.autoreDocumento non valido", SebException.FSE_ERROR);
			}
			if (input.autoreDocumento.codiceFiscale == null || input.autoreDocumento.codiceFiscale.length != 16) {
				throw new SebException("VoAutoreDocumento.codiceFiscale non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//autoreDocumento/codiceFiscale", input.autoreDocumento.codiceFiscale);
			if (input.autoreDocumento.cognome == null || input.autoreDocumento.cognome.length == 0) {
				throw new SebException("VoAutoreDocumento.cognome non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//autoreDocumento/cognome", input.autoreDocumento.cognome);
			if (input.autoreDocumento.nome == null || input.autoreDocumento.nome.length == 0) {
				throw new SebException("VoAutoreDocumento.nome non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniDoc, "//autoreDocumento/nome", input.autoreDocumento.nome);
			XPathUtility.setNodeValue(ottieniDoc, "//autoreDocumento/ruolo", input.autoreDocumento.ruolo);
			if (input.operatoreAutorizzante == null) {
				XPathUtility.removeNode(ottieniDoc, "//operatoreAutorizzante");
			} else {
				if (input.operatoreAutorizzante.codiceFiscaleAutorizzante == null || input.operatoreAutorizzante.codiceFiscaleAutorizzante.length != 16) {
					throw new SebException("VoOperatoreAutorizzante.codiceFiscaleAutorizzante non valido", SebException.FSE_ERROR);
				}
				XPathUtility.setNodeValue(ottieniDoc, "//operatoreAutorizzante/codiceFiscaleAutorizzante", input.operatoreAutorizzante.codiceFiscaleAutorizzante);
				if (input.operatoreAutorizzante.cognomeAutorizzante == null || input.operatoreAutorizzante.cognomeAutorizzante.length == 0) {
					throw new SebException("VoOperatoreAutorizzante.cognomeAutorizzante non valido", SebException.FSE_ERROR);
				}
				XPathUtility.setNodeValue(ottieniDoc, "//operatoreAutorizzante/cognomeAutorizzante", input.operatoreAutorizzante.cognomeAutorizzante);
				if (input.operatoreAutorizzante.nomeAutorizzante == null || input.operatoreAutorizzante.nomeAutorizzante.length == 0) {
					throw new SebException("VoOperatoreAutorizzante.nomeAutorizzante non valido", SebException.FSE_ERROR);
				}
				XPathUtility.setNodeValue(ottieniDoc, "//operatoreAutorizzante/nomeAutorizzante", input.operatoreAutorizzante.nomeAutorizzante);
			}
			if (input.statoAutorizzazioneDocumento == null || input.statoAutorizzazioneDocumento.length == 0) {
				XPathUtility.removeNode(ottieniDoc, "//statoAutorizzazioneDocumento");
			} else {
				XPathUtility.setNodeValue(ottieniDoc, "//statoAutorizzazioneDocumento", input.statoAutorizzazioneDocumento);
			}
			if (input.noteReperibilita == null || input.noteReperibilita.length == 0) {
				XPathUtility.removeNode(ottieniDoc, "//noteReperibilita");
			} else {
				XPathUtility.setNodeValue(ottieniDoc, "//noteReperibilita", input.noteReperibilita);
			}
			if (input.attributiSpecificiDCE == null || input.attributiSpecificiDCE.type == -1 ) {
				XPathUtility.removeNode(ottieniDoc, "//attributiSpecificiDCE");
			} else {
				switch(input.attributiSpecificiDCE.type) {
					case ConstTipiAttributiDCE.ATTRIBUTI_ENOTE:
						buildAttributiENode(ottieniDoc, input.attributiSpecificiDCE as VoADCEEvaluationNote);
						break;
					case ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE:
						buildAttributiLDimissione(ottieniDoc, input.attributiSpecificiDCE as VoADCELDimissione);
						break;
					case ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO:
						builAttributiPSoccorso(ottieniDoc, input.attributiSpecificiDCE as VoADCEPSoccorso);
						break;
					case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO:
						buildAttributiReferto(ottieniDoc, input.attributiSpecificiDCE as VoADCEReferto);
						break;
					case ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009:
						buildAttributiENode(ottieniDoc, input.attributiSpecificiDCE as VoADCEEvaluationNote);
						break;
					case ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE_2009:
						buildAttributiLDimissione(ottieniDoc, input.attributiSpecificiDCE as VoADCELDimissione);
						break;
					case ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO_2009:
						builAttributiPSoccorso(ottieniDoc, input.attributiSpecificiDCE as VoADCEPSoccorso);
						break;
					case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009:
						buildAttributiReferto(ottieniDoc, input.attributiSpecificiDCE as VoADCEReferto);
						break;
					default:
						XPathUtility.removeNode(ottieniDoc, "//attributiSpecificiDCE");
				}
			}
			
			return ottieniDoc;
		}
		
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			var parsing:ParserOttieniDocumentoTestuale = new ParserOttieniDocumentoTestuale( body );
			return parsing.execute();
		}
		
		public function getNameService():String
		{
			return "FSE.ottieniDocumentoTestuale";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/ottieniDocumentoTestuale/", "FSE.ottieniDocumentoTestualeResponse");
		}
		
		protected function buildAttributiENode(ottieniDoc:XML, attr:VoADCEEvaluationNote):void {
			var inputAttrDce:XML =   <c:attributi_enote   
										 xmlns:c="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/attributi_enote/">
										  <idPresidio></idPresidio>
										  <descrizionePresidio></descrizionePresidio>
										  <numeroPrericovero></numeroPrericovero>
										  <numeroNosologico></numeroNosologico>
										  <neonato>
										        <dataNascitaNeonato></dataNascitaNeonato>
										  </neonato>
										  <dataOraIngresso></dataOraIngresso>
									  </c:attributi_enote>
			if (attr.type == ConstTipiAttributiDCE.ATTRIBUTI_ENOTE) {
				inputAttrDce = <c:attributi_enote   
								 xmlns:c="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_enote/">
								  <idPresidio></idPresidio>
								  <descrizionePresidio></descrizionePresidio>
								  <numeroNosologico></numeroNosologico>
								  <neonato>
								        <dataNascitaNeonato></dataNascitaNeonato>
								  </neonato>
								  <dataOraIngresso></dataOraIngresso>
								 </c:attributi_enote>
			}

			if (attr.idPresidio == null || attr.idPresidio.length != 8) {
				throw new SebException("VoADCEEvaluationNote.idPresidio non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(inputAttrDce, "//idPresidio", attr.idPresidio);
			if (attr.descrizionePresidio == null || attr.descrizionePresidio.length == 0) {
				throw new SebException("VoADCEEvaluationNote.descrizionePresidio non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(inputAttrDce, "//descrizionePresidio", attr.descrizionePresidio);
			if (attr.type == ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009) {
				XPathUtility.setNodeValue(inputAttrDce, "//numeroPrericovero", attr.numeroPrericovero);
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//numeroPrericovero", attr.numeroPrericovero);
			}
			XPathUtility.setNodeValue(inputAttrDce, "//numeroNosologico", attr.numeroNosologico);
			if (attr.dataNascitaNeonato == null || attr.dataNascitaNeonato.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//neonato");
			} else {
				if (attr.dataNascitaNeonato.length != 8) {
					throw new SebException("VoADCEEvaluationNote.dataNascitaNeonato non valido", SebException.FSE_ERROR);
				}				
				XPathUtility.setNodeValue(inputAttrDce, "//neonato/dataNascitaNeonato", attr.dataNascitaNeonato);
			}
			if (attr.dataOraIngresso == null || attr.dataOraIngresso.length < 12 || attr.dataOraIngresso.length > 14) {
				throw new SebException("VoADCEEvaluationNote.dataOraIngresso non valido", SebException.FSE_ERROR);
			}				
			XPathUtility.setNodeValue(inputAttrDce, "//dataOraIngresso", attr.dataOraIngresso);
			
			//Aggiungo gli attributi speciali dce al XML di richiesta
			XPathUtility.importNode(ottieniDoc, "//attributiSpecificiDCE", inputAttrDce);
		}
		
		protected function buildAttributiLDimissione(ottieniDoc:XML, attr:VoADCELDimissione):void {
			var inputAttrDce:XML = <c:attributi_ldimissione   
									  xmlns:c="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_ldimissione/">
									  <idPresidio></idPresidio>
									  <descrizionePresidio></descrizionePresidio> 
									  <numeroNosologico></numeroNosologico>
									  <IUP></IUP>
									  <neonato>
									        <dataNascitaNeonato></dataNascitaNeonato>
									  </neonato>
									  <dataOraAccettazione></dataOraAccettazione>
									 </c:attributi_ldimissione>

			if (attr.idPresidio == null || attr.idPresidio.length != 8) {
				throw new SebException("VoADCELDimissione.idPresidio non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(inputAttrDce, "//idPresidio", attr.idPresidio);
			if (attr.descrizionePresidio == null || attr.descrizionePresidio.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//descrizionePresidio");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//descrizionePresidio", attr.descrizionePresidio);
			}
			if (attr.numeroNosologico == null || attr.numeroNosologico.length != 10) {
				throw new SebException("VoADCELDimissione.numeroNosologico non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(inputAttrDce, "//numeroNosologico", attr.numeroNosologico);
			if (attr.IUP == null || attr.IUP.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//IUP");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//IUP", attr.IUP);
			}
			if (attr.dataNascitaNeonato == null || attr.dataNascitaNeonato.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//neonato");
			} else {
				if (attr.dataNascitaNeonato.length != 8) {
					throw new SebException("VoADCELDimissione.dataNascitaNeonato non valido", SebException.FSE_ERROR);
				}				
				XPathUtility.setNodeValue(inputAttrDce, "//neonato/dataNascitaNeonato", attr.dataNascitaNeonato);
			}
			if (attr.dataOraAccettazione == null || attr.dataOraAccettazione.length < 12 || attr.dataOraAccettazione.length > 14) {
				throw new SebException("VoADCELDimissione.dataOraAccettazione non valido", SebException.FSE_ERROR);
			}				
			XPathUtility.setNodeValue(inputAttrDce, "//dataOraAccettazione", attr.dataOraAccettazione);
										 
			//Aggiungo gli attributi speciali dce al XML di richiesta
			XPathUtility.importNode(ottieniDoc, "//attributiSpecificiDCE", inputAttrDce);
		}
		
		 protected function builAttributiPSoccorso(ottieniDoc:XML, attr:VoADCEPSoccorso):void {
			var inputAttrDce:XML =  <c:attributi_psoccorso   
									 xmlns:c="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_psoccorso/">
									  <idPresidio></idPresidio>
									  <descrizionePresidio></descrizionePresidio> 
									  <numeroPraticaPS></numeroPraticaPS>
									  <dataOraAccettazione></dataOraAccettazione>
									 </c:attributi_psoccorso>


			if (attr.idPresidio == null || attr.idPresidio.length != 8) {
				throw new SebException("VoADCEPSoccorso.idPresidio non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(inputAttrDce, "//idPresidio", attr.idPresidio);
			if (attr.descrizionePresidio == null || attr.descrizionePresidio.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//descrizionePresidio");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//descrizionePresidio", attr.descrizionePresidio);
			}
			if (attr.numeroPraticaPS == null || attr.numeroPraticaPS.length == 0) {
				throw new SebException("VoADCEPSoccorso.numeroPraticaPS non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(inputAttrDce, "//numeroPraticaPS", attr.numeroPraticaPS);
			if (attr.dataOraAccettazione == null || attr.dataOraAccettazione.length < 12 || attr.dataOraAccettazione.length > 14) {
				throw new SebException("VoADCEPSoccorso.dataOraAccettazione non valido", SebException.FSE_ERROR);
			}				
			XPathUtility.setNodeValue(inputAttrDce, "//dataOraAccettazione", attr.dataOraAccettazione);
										 
			//Aggiungo gli attributi speciali dce al XML di richiesta
			XPathUtility.importNode(ottieniDoc, "//attributiSpecificiDCE", inputAttrDce);
		}
		
		protected function buildAttributiReferto(ottieniDoc:XML, attr:VoADCEReferto):void {
			var inputAttrDce:XML = <c:attributi_referto   
									 xmlns:c="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/attributi_referto/">
									  <idPresidio></idPresidio>
									  <descrizionePresidio></descrizionePresidio> 
									  <numeroPrericovero></numeroPrericovero>
									  <numeroNosologico></numeroNosologico>
									  <numeroPraticaPS></numeroPraticaPS>
									  <numeroCartellaAmbulatoriale></numeroCartellaAmbulatoriale>
									  <neonato>
									        <dataNascitaNeonato></dataNascitaNeonato>
									  </neonato>
									  <dataOraRichiesta></dataOraRichiesta>
									  <medicoRichiedente>   
									     <cognome></cognome>
									     <nome></nome>
									     <codiceFiscale></codiceFiscale>
									  </medicoRichiedente>   
									  <idUnitaOperativaRichiedente></idUnitaOperativaRichiedente> 
									  <descrizioneUnitaOperativaRichiedente></descrizioneUnitaOperativaRichiedente>
									  <prestazioniAssociate>   
									         
									  </prestazioniAssociate>   
									 </c:attributi_referto>
			if (attr.type == ConstTipiAttributiDCE.ATTRIBUTI_REFERTO) {
				inputAttrDce = 	<c:attributi_referto   
									 xmlns:c="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_referto/">
									  <idPresidio></idPresidio>
									  <descrizionePresidio></descrizionePresidio> 
									  <numeroNosologico></numeroNosologico>
									  <numeroPraticaPS></numeroPraticaPS>
									  <numeroCartellaAmbulatoriale></numeroCartellaAmbulatoriale>
									  <neonato>
									        <dataNascitaNeonato></dataNascitaNeonato>
									  </neonato>
									  <dataOraRichiesta></dataOraRichiesta>
									  <medicoRichiedente>   
									     <cognome></cognome>
									     <nome></nome>
									     <codiceFiscale></codiceFiscale>
									  </medicoRichiedente>   
									  <idUnitaOperativaRichiedente></idUnitaOperativaRichiedente> 
									  <descrizioneUnitaOperativaRichiedente></descrizioneUnitaOperativaRichiedente>
									  <prestazioniAssociate>   
									         
									  </prestazioniAssociate>   
									 </c:attributi_referto>
			}

			var inputPrestazione:XML = <prestazione>   
							         <IUP></IUP>
							         <idPrestazioneSISS></idPrestazioneSISS>
							         <descrizionePrestazioneSISS></descrizionePrestazioneSISS> 
							         <quantitaErogata></quantitaErogata> 
							         <flagAggiuntiva></flagAggiuntiva> 
							       </prestazione>
							       
			if (attr.idPresidio == null || attr.idPresidio.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//idPresidio");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//idPresidio", attr.idPresidio);
			}
			if (attr.descrizionePresidio == null || attr.descrizionePresidio.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//descrizionePresidio");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//descrizionePresidio", attr.descrizionePresidio);
			}
			if (attr.type == ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009 && (attr.numeroPrericovero == null || attr.numeroPrericovero.length == 0)) {
				XPathUtility.removeNode(inputAttrDce, "//numeroPrericovero");
			} else if (attr.type == ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009){
				XPathUtility.setNodeValue(inputAttrDce, "//numeroPrericovero", attr.numeroPrericovero);
			}
			if (attr.numeroNosologico == null || attr.numeroNosologico.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//numeroNosologico");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//numeroNosologico", attr.numeroNosologico);
			}
			if (attr.numeroPraticaPS == null || attr.numeroPraticaPS.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//numeroPraticaPS");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//numeroPraticaPS", attr.numeroPraticaPS);
			}
			if (attr.numeroCartellaAmbulatoriale == null || attr.numeroCartellaAmbulatoriale.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//numeroCartellaAmbulatoriale");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//numeroCartellaAmbulatoriale", attr.numeroCartellaAmbulatoriale);
			}
			if (attr.dataNascitaNeonato == null || attr.dataNascitaNeonato.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//neonato");
			} else {
				if (attr.dataNascitaNeonato.length != 8) {
					throw new SebException("VoADCEReferto.dataNascitaNeonato non valido", SebException.FSE_ERROR);
				}				
				XPathUtility.setNodeValue(inputAttrDce, "//neonato/dataNascitaNeonato", attr.dataNascitaNeonato);
			}
			if (attr.dataOraRichiesta == null || attr.dataOraRichiesta.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//dataOraRichiesta");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//dataOraRichiesta", attr.dataOraRichiesta);
			}
			if (attr.medicoRichiedente == null) {
				XPathUtility.removeNode(inputAttrDce, "//medicoRichiedente");
			} else {
				if (attr.medicoRichiedente.cognome == null || attr.medicoRichiedente.cognome.length == 0) {
					throw new SebException("VoMedicoRichiedente.cognome non valido", SebException.FSE_ERROR);
				}
				XPathUtility.setNodeValue(inputAttrDce, "//medicoRichiedente/cognome", attr.medicoRichiedente.cognome);
				if (attr.medicoRichiedente.nome == null || attr.medicoRichiedente.nome.length == 0) {
					throw new SebException("VoMedicoRichiedente.nome non valido", SebException.FSE_ERROR);
				}
				XPathUtility.setNodeValue(inputAttrDce, "//medicoRichiedente/nome", attr.medicoRichiedente.nome);
				if (attr.medicoRichiedente.codiceFiscale == null || attr.medicoRichiedente.codiceFiscale.length == 0) {
					throw new SebException("VoMedicoRichiedente.codiceFiscale non valido", SebException.FSE_ERROR);
				}
				XPathUtility.setNodeValue(inputAttrDce, "//medicoRichiedente/codiceFiscale", attr.medicoRichiedente.codiceFiscale);
			}
			if (attr.idUnitaOperativaRichiedente == null || attr.idUnitaOperativaRichiedente.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//idUnitaOperativaRichiedente");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//idUnitaOperativaRichiedente", attr.idUnitaOperativaRichiedente);
			}
			if (attr.descrizioneUnitaOperativaRichiedente == null || attr.descrizioneUnitaOperativaRichiedente.length == 0) {
				XPathUtility.removeNode(inputAttrDce, "//descrizioneUnitaOperativaRichiedente");
			} else {
				XPathUtility.setNodeValue(inputAttrDce, "//descrizioneUnitaOperativaRichiedente", attr.descrizioneUnitaOperativaRichiedente);
			}	 
			if (attr.prestazioniAssociate == null || attr.prestazioniAssociate.iterator == null) {
				throw new SebException("VoADCEReferto.prestazioniAssociate non valido", SebException.FSE_ERROR);
			} else {
				var itPrest:IIterator = attr.prestazioniAssociate.iterator;
				var i:int = 0;
				while (itPrest.hasNext()) {
					var pres:VoPrestazione = null;
					try {
						pres = itPrest.next() as VoPrestazione;
						i++;
					} catch(e:Error) {
						if (i == 0 && !itPrest.hasNext()) {
							throw new SebException("VoADCEReferto.prestazioniAssociate non valido", SebException.FSE_ERROR);
						}
						continue;
					}
					var prestazioni:XML = inputPrestazione.copy();
					XPathUtility.setNodeValue(prestazioni, "//IUP", pres.IUP);
					if (pres.idPrestazioneSISS == null || pres.idPrestazioneSISS.length == 0) {
						throw new SebException("VoPrestazione.idPrestazioneSISS non valido", SebException.FSE_ERROR);
					}
					XPathUtility.setNodeValue(prestazioni, "//idPrestazioneSISS", pres.idPrestazioneSISS);
					XPathUtility.setNodeValue(prestazioni, "//descrizionePrestazioneSISS", pres.descrizionePrestazioneSISS);
					if (pres.quantitaErogata == null || pres.quantitaErogata.length == 0) {
						XPathUtility.setNodeValue(prestazioni, "//quantitaErogata", "1");
					} else {
						XPathUtility.setNodeValue(prestazioni, "//quantitaErogata", pres.quantitaErogata);
					}
					if (pres.flagAggiuntiva == null || pres.flagAggiuntiva.length != 1){
						XPathUtility.setNodeValue(prestazioni, "//flagAggiuntiva", "N");
					} else {
						XPathUtility.setNodeValue(prestazioni, "//flagAggiuntiva", pres.flagAggiuntiva);
					}
					XPathUtility.importNode(inputAttrDce, "//prestazioniAssociate", prestazioni);
				}
			}
			
			//Aggiungo gli attributi speciali dce al XML di richiesta
			XPathUtility.importNode(ottieniDoc, "//attributiSpecificiDCE", inputAttrDce);
		}
		
		private const INPUT_OTTIENI_DOC_TEST:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.ottieniDocumentoTestuale xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/ottieniDocumentoTestuale/">
  						<documentoClinicoElettronico>
						    <idTipoDocumento></idTipoDocumento>
						    <disciplinaErogazione></disciplinaErogazione>
						    <caratterizzazioniCliniche>
						      
						    </caratterizzazioniCliniche>
						    <dataOraCreazione></dataOraCreazione>
						    <documento>
						      <idSetDocumenti></idSetDocumenti>
						      <nVersione></nVersione>
						      <uri></uri>
						      <linguaggioDocumento></linguaggioDocumento>
						      <formato></formato>
						      <contenuto></contenuto>
						      <hashDocumento></hashDocumento>
						      <algoritmoHash></algoritmoHash>
						      <sizeDocumento></sizeDocumento>
						    </documento>
						    <listaAllegati>
						      
						    </listaAllegati>
						    <reteDiPatologia></reteDiPatologia>
						    <idTipoDocumentoLOINC></idTipoDocumentoLOINC>
						    <cittadino>
						        <idCittadino tipo="CF"></idCittadino>
						    </cittadino>
						    <autoreDocumento>
						        <codiceFiscale></codiceFiscale>
						        <cognome></cognome>
						        <nome></nome>
						        <ruolo></ruolo>
						    </autoreDocumento>
						    <operatoreAutorizzante>
						        <codiceFiscaleAutorizzante></codiceFiscaleAutorizzante>
						        <cognomeAutorizzante></cognomeAutorizzante>
						        <nomeAutorizzante></nomeAutorizzante>
						    </operatoreAutorizzante>
						    <statoAutorizzazioneDocumento></statoAutorizzazioneDocumento>
						    <noteReperibilita></noteReperibilita>
						    <attributiSpecificiDCE>
						
						    </attributiSpecificiDCE>
  						</documentoClinicoElettronico>
					</m:FSE.ottieniDocumentoTestuale>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;
			
		protected const INPUT_CARATTERIZ:XML = <caratterizzazione>
										        <dizionario></dizionario>
										        <codice></codice>
										      </caratterizzazione>
	      
	   	protected const INPUT_ALLEGATI:XML = <allegato>
									        <linkAllegato></linkAllegato>
									        <formatoAllegato></formatoAllegato>
									      </allegato>
 
		
	}
}