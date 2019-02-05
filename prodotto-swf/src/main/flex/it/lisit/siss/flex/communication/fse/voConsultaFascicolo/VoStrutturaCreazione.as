package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoStrutturaCreazione extends ClonableValueObject
	{
		/**
		 * Codice identificativo dell’ente associato alla creazione del documento clinico. 
		 * Stringa alfanumerica di lunghezza massima 16 caratteri.
		 * Obbligatorietà SI
		 */		
		public var idEnte:String
		/**
		 * Descrizione dell’ente associato alla creazione del documento clinico. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI tranne nel caso di pubblicazione di un Patient Summary.
		 */		
		public var descrizioneEnte:String
		/**
		 *	Codice identificativo dell’eventuale presidio o struttura associato alla creazione del documento clinico. 
		 *  Stringa alfanumerica di lunghezza massima 9 caratteri.
		 *  Obbligatorietà - NO
		 *  Quando non presente assume il valore di null
		 */		
		public var idPresidio:String = null;
		/**
		 * Descrizione dell’eventuale presidio o struttura associato alla creazione del documento clinico. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * Quando non presente assume il valore di null
		 */		
		public var descrizionePresidio:String = null;
		/**
		 * Codice aziendale dell'unità operativa di creazione del documento clinico.
		 * Stringa alfanumerica di lunghezza massima 6 caratteri.
		 * Obbligatorietà - NO
		 * Quando non presente assume il valore di null
		 */		
		public var idUnitaOperativaClinica:String = null;
		/**
		 * Descrizione dell'unità operativa di creazione del documento clinico.
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * Quando non presente assume il valore di null
		 */		
		public var descrizioneUnitaOperativaClinica:String = null;
		
		public function VoStrutturaCreazione()
		{
			super();
		}
	}
}