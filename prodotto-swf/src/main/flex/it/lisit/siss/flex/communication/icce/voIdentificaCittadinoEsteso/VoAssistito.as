package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoAssistito extends ClonableValueObject
	{
		public var codiceFiscaleCittadino:String;
		public var sessoCittadino:String;
		public var statoAssistito:String;
		public var dataUltimaVariazioneAnagrafici:String;
		public var idComuneNascitaCittadino:String;
		public var codiceSanitarioCittadino:String;
		public var dataNascitaCittadino:String;
		public var comuneNascitaCittadino:String;
		public var cognomeCittadino:String;
		public var nomeCittadino:String;
		
		public var idProvenienza:String;
		public var siglaAslAppartenenza:String;
		public var origineDati:String;
		public function VoAssistito()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoAssistito 				= new VoAssistito();
			cl.codiceFiscaleCittadino		= this.codiceFiscaleCittadino;
			cl.sessoCittadino				= this.sessoCittadino;
			cl.statoAssistito				= this.statoAssistito;
			cl.idComuneNascitaCittadino		= this.idComuneNascitaCittadino;
			cl.codiceSanitarioCittadino		= this.codiceSanitarioCittadino;
			cl.dataNascitaCittadino			= this.dataNascitaCittadino;
			cl.comuneNascitaCittadino		= this.comuneNascitaCittadino;
			cl.cognomeCittadino				= this.cognomeCittadino;
			cl.nomeCittadino				= this.nomeCittadino;
			
			cl.idProvenienza				= this.idProvenienza;
			cl.dataUltimaVariazioneAnagrafici= this.dataUltimaVariazioneAnagrafici;
			cl.siglaAslAppartenenza			= this.siglaAslAppartenenza;
			cl.origineDati					= this.origineDati;
			return cl;
		}
	}
}