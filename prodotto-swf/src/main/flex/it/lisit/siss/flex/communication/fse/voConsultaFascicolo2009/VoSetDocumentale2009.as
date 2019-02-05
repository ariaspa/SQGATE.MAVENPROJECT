package it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiSpecificiDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAutoreDocumento;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCaratterizzazioniCliniche;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoDocumento;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaAllegati;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoSetDocumentale;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaCreazione;
	/**
	 * Struttura contenente i metadati specifici associati al singolo DCE considerato 
	 * 
	 * @author Salvatore Civiletto
	 * 
	 */	
	public class VoSetDocumentale2009 extends VoSetDocumentale
	{
		/**
		 * Definizione	Struttura contenente i dati relativi alla struttura di conservazione del documento clinico 
		 * Obbligatorietà	SI
		 */		
		public var strutturaArchiviazione:VoStrutturaArchiviazione;
		
		/**
		 * Definizione:		Indica se il DCE risulta essere una copia di un DCE 
		 * 	(inserito tramite il servizio ‘copiaDCE’ oppure no (inserito tramite il servizio ‘pubblicaDocumenti’)
		 * Vincoli:			Valori ammessi:’S’ (DCE copiato), ‘N’ (DCE non copiato)
		 * Obbligatorietà:	NO
		 */
		 public var flagCopiato:String;
		
		/**
		 * Definizione	Struttura dati che contiene le informazioni di classificazione del documento clinico in relazione ai criteri di oscuramento. 
		 * Vincoli	Presente solo se almeno una causale di oscuramento risulta valorizzata a SI
		 * Obbligatorietà	NO
		 */		
		public var oscuramento:VoListaOscuramento = null;
		
		 
		public function VoSetDocumentale2009()
		{
			super();
		}
	}
}