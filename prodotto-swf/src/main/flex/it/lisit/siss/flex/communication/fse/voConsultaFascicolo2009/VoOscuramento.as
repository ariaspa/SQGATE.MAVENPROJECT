package it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoOscuramento extends ClonableValueObject
	{
		/**
		 * Definizione:		Codice associato alla tipologia di oscuramento ed autorizzazione del documento. 
		 * Vincoli:			Valori ammessi: vedi allegato 1 (Dati codificati – tabella CausaleOscuramento).
		 * Obbligatorietà:	SI
		 */		
		public var idCausaleOscuramento:String
		
		/**
		 * Definizione:		Valore associato al codice di oscuramento. 
		 * Vincoli:			Sono ammessi i seguenti valori:
		 * 		-	SI (documento clinico oscurato)
		 *		-	NO (documento clinico non oscurato)
		 * Obbligatorietà:	SI
		 */
		public var valoreOscuramento:String;
				
		public function VoOscuramento()
		{
			super();
		}
		
	}
}