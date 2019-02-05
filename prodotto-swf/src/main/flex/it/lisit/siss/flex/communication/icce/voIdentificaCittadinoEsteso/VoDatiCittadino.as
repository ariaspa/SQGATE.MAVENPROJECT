package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoDatiCittadino extends ClonableValueObject
	{
		public var cognomeCittadino:String;
		public var nomeCittadino:String;
		public var sessoCittadino:String;
		public var dataNascitaCittadino:String;
		public var idComuneNascitaCittadino:String;
		public var comuneNascitaCittadino:String;
		public var provinciaNascitaCittadino:String;
		public var codiceFiscaleCittadino:String;
		public var codiceSanitarioCittadino:String;
		public var indirizzoResidenzaCittadino:String;
		public var civicoResidenzaCittadino:String;
		public var codiceFiscalePrecedenteCittadino:String;
		public var frazioneResidenzaCittadino:String;
		public var origineDati:String;
		public var dataUltimaVariazioneResidenza:String;
		public var idComuneResidenzaCittadino:String;
		public var comuneResidenzaCittadino:String;
		public var provinciaResidenzaCittadino:String;
		public var indirizzoDomicilioCittadino:String;
		public var civicoDomicilioCittadino:String;
		public var idComuneDomicilioCittadino:String;
		public var comuneDomicilioCittadino:String;
		public var capDomicilioCittadino:String;
		public var idCasaRiposo:String;
		public var descrizioneRSA:String;
		public var codiceDistrettoAppartenenza:String;
		public var descrizioneDistrettoAppartenenza:String;
		public var validatoMef:String;
		public var dataValidazioneMef:String;
		public var dataDecesso:String;
		public var tipoRilevazione:String;
		public var capResidenzaCittadino:String;
		public var provinciaDomicilioCittadino:String;
		public var siglaAslAppartenenza:String;
		public var descrizioneAslAppartenenza:String;
		public var descrizioneAslAssistenza:String;
		public var siglaAslAssistenza:String;
		public var dataDecorrenzaIscrizione:String;
		public var dataScadenzaIscrizione:String;
		public var statoAssistito:String;
		public var idProvenienza:String;
		public var frazioneDomicilioCittadino:String;
		public var codiceDistrettoAssistenza:String;
		public var descrizioneDistrettoAssistenza:String;
		public var dataUltimaVariazioneAnagrafici:String;
		public var dataUltimaVariazioneAmministrativi:String;
		public var statoAggiornamentoCRS:String;
		
		public function VoDatiCittadino()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			 var cl:VoDatiCittadino 			= new VoDatiCittadino();
			 cl.cognomeCittadino		 		= this.cognomeCittadino;
			 cl.idCasaRiposo		 			= this.idCasaRiposo;
			 cl.descrizioneRSA		 			= this.descrizioneRSA;
			 cl.descrizioneDistrettoAppartenenza= this.descrizioneDistrettoAppartenenza;
			 cl.validatoMef		 				= this.validatoMef;
			 cl.dataValidazioneMef		 		= this.dataValidazioneMef;
			 cl.dataDecesso		 				= this.dataDecesso;
			 cl.tipoRilevazione		 			= this.tipoRilevazione;
			 cl.nomeCittadino					= this.nomeCittadino;
			 cl.sessoCittadino					= this.sessoCittadino; 
			 cl.dataNascitaCittadino			= this.dataNascitaCittadino; 
			 cl.idComuneNascitaCittadino		= this.idComuneNascitaCittadino; 
			 cl.comuneNascitaCittadino			= this.comuneNascitaCittadino; 
			 cl.provinciaNascitaCittadino  		= this.provinciaNascitaCittadino;
			 cl.codiceFiscaleCittadino			= this.codiceFiscaleCittadino; 
			 cl.codiceSanitarioCittadino		= this.codiceSanitarioCittadino; 
			 cl.indirizzoResidenzaCittadino		= this.indirizzoResidenzaCittadino; 
			 cl.civicoResidenzaCittadino		= this.civicoResidenzaCittadino; 
			 cl.idComuneResidenzaCittadino		= this.idComuneResidenzaCittadino; 
			 cl.comuneResidenzaCittadino		= this.comuneResidenzaCittadino; 
			 cl.provinciaResidenzaCittadino		= this.provinciaResidenzaCittadino; 
			 cl.indirizzoDomicilioCittadino		= this.indirizzoDomicilioCittadino; 
			 cl.civicoDomicilioCittadino		= this.civicoDomicilioCittadino; 
			 cl.idComuneDomicilioCittadino		= this.idComuneDomicilioCittadino; 
			 cl.comuneDomicilioCittadino		= this.comuneDomicilioCittadino; 
			 cl.capDomicilioCittadino			= this.capDomicilioCittadino; 
			 cl.provinciaDomicilioCittadino		= this.provinciaDomicilioCittadino; 
			 cl.siglaAslAppartenenza			= this.siglaAslAppartenenza; 
			 cl.descrizioneAslAppartenenza		= this.descrizioneAslAppartenenza; 
			 cl.siglaAslAssistenza				= this.siglaAslAssistenza; 
			 cl.dataDecorrenzaIscrizione		= this.dataDecorrenzaIscrizione; 
			 cl.dataScadenzaIscrizione			= this.dataScadenzaIscrizione; 
			 cl.statoAssistito					= this.statoAssistito; 
			 cl.idProvenienza					= this.idProvenienza; 
			 cl.codiceFiscalePrecedenteCittadino= this.codiceFiscalePrecedenteCittadino; 
			 cl.capResidenzaCittadino			= this.capResidenzaCittadino; 
			 cl.frazioneResidenzaCittadino		= this.frazioneResidenzaCittadino; 
			 cl.frazioneDomicilioCittadino		= this.frazioneDomicilioCittadino; 
			 cl.descrizioneAslAssistenza		= this.descrizioneAslAssistenza; 
			 cl.codiceDistrettoAssistenza		= this.codiceDistrettoAssistenza; 
			 cl.descrizioneDistrettoAssistenza	= this.descrizioneDistrettoAssistenza; 
			 cl.dataUltimaVariazioneAnagrafici	= this.dataUltimaVariazioneAnagrafici; 
			 cl.dataUltimaVariazioneResidenza	= this.dataUltimaVariazioneResidenza; 
			 cl.dataUltimaVariazioneAmministrativi	= this.dataUltimaVariazioneAmministrativi; 
			 cl.origineDati						= this.origineDati; 
			 cl.statoAggiornamentoCRS			= this.statoAggiornamentoCRS; 
			 cl.codiceDistrettoAppartenenza		= this.codiceDistrettoAppartenenza; 
			 return cl;
		}
	}
}
















