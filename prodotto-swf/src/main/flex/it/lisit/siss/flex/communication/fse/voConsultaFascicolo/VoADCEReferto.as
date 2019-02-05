package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	/**
	 * I tipi di documenti che corrispondono al referto specialistico sono :  
	 * Visita Specialistica (01), 
	 * Specialistico Laboratorio (02), 
	 * Specialistico Radiologia (03).
	 * 
	 * Un referto specialistico può essere emesso:
	 * 		1.Nell’ambito di un ricovero ospedaliero oppure 
	 * 		2.Nell’ambito di un accesso di PS oppure
	 * 		3.Per un cittadino esterno 
	 * 
	 * A seconda dei casi cambia l’obbligatorietà di alcune proprietà. 
	 * In particolare:
	 * 	Nel caso ‘1’  risultano obbligatori le proprietà <idPresidio> e  <numeroNosologico>
	 * 	Nel caso ‘2’  risultano obbligatori le proprietà <idPresidio> e <numeroPraticaPS>
	 * 	Nel caso ‘3’  risulta obbligatorio  la proprietà <IUP>
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoADCEReferto extends VoAttributiSpecificiDCE
	{
		/**
		 * Codice del presidio.
		 * Stringa alfanumerica di lunghezza massima 9 caratteri.
		 * Obbligatorietà - SI solo nel caso sia valorizzato 
		 * uno tra le proprietà numeroNosologico,  numeroCartellaAmbulatoriale, numeroPraticaPS. 
		 */		
		public var idPresidio:String
		/**
		 * Numero del prericovero a cui il referto specialistico è eventualmente associato.
		 * Stringa alfanumerica di lunghezza 10 caratteri nel formato 
		 * AAAANNNNNN dove AAAA è l’anno e NNNNNN è un numero progressivo (tale numero deve essere sempre costituito
		 * da 6 cifre, utilizzare eventualmente un numero opportuno di zeri a sinistra per completarlo) 
		 * Obbligatorietà - NO. Diventa obbligatorio in alternativa al numeroPraticaPS, allo IUP e al numeroNosologico
		 */		
		public var numeroPrericovero:String;
		/**
		 * Numero nosologico del ricovero a cui il referto specialistico è eventualmente associato.
		 * Stringa alfanumerica di lunghezza 10 caratteri nel formato 
		 * AAAANNNNNN dove AAAA è l’anno e NNNNNN è un numero progressivo (tale numero deve essere sempre costituito
		 * da 6 cifre, utilizzare eventualmente un numero opportuno di zeri a sinistra per completarlo) 
		 * Obbligatorietà - NO. Diventa obbligatorio in alternativa al numeroPraticaPS, al numeroPrericovero e allo IUP.
		 */		
		public var numeroNosologico:String;
		/**
		 * Numero di pratica PS a cui il referto specialistico è eventualmente associato.
		 * Stringa alfanumerica di lunghezza massima di 20 caratteri. 
		 * Obbligatorietà - NO. E’ in alternativa  numero Nosologico, al numeroPrericovero e allo IUP.
		 */		
		public var numeroPraticaPS:String;
		/**
		 * Numero di cartella di ambulatorio a cui il referto specialistico è eventualmente associato.
		 * Stringa alfanumerica di lunghezza massima di 64 caratteri.
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var numeroCartellaAmbulatoriale:String = null;
		/**
		 * Data di nascita del neonato 
		 * Stringa alfanumerica di lunghezza 8. Formato YYYYMMDD.
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var dataNascitaNeonato:String = null;
		/**
		 * Data della richiesta di prestazioni a cui il referto specialistico fa riferimento
		 * Data valida formalmente
		 * Lunghezza minima 12 e  massima 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MM[SS]'
		 * In caso di assenza di secondi è da interpretare come valore ‘00’
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var dataOraRichiesta:String = null;
		/**
		 * Struttura dati che i dati relativi al medico richiedente
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var medicoRichiedente:VoMedicoRichiedente = null;
		/**
		 * Unità Operativa richiedente le prestazioni associate al referto specialistico
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var idUnitaOperativaRichiedente:String = null;
		/**
		 * 
		 */		
		public var descrizioneUnitaOperativaRichiedente:String = null;
		/**
		 * 
		 */		
		public var descrizionePresidio:String = null;
		/**
		 * Struttura dati che contiene  l’elenco delle prestazioni cui il referto specialistico fa riferimento
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var prestazioniAssociate:VoElencoPrestazioni = null;
	 
		
		public function VoADCEReferto()
		{
			super();
		}
		override public function get type():int
		{
			if (numeroPrericovero == null || numeroPrericovero.length == 0)
				return ConstTipiAttributiDCE.ATTRIBUTI_REFERTO;
			else
				return ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009;
		}
	}
}