package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoDatiMedico extends ClonableValueObject
	{
		public var dataInizioScelta:String;
		public var nomeMedico:String;
		public var cognomeMedico:String;
		public var tipoAssistenza:String;
		public var frazioneAmbulatorio:String;
		public var civicoAmbulatorio:String;
		public var indirizzoAmbulatorio:String;
		public var capAmbulatorio:String;
		public var denominazioneComuneAmbulatorio:String;
		public var telefoniMedico:String;
		public var codiceComuneAmbulatorio:String;
		public var codiceFiscaleMedico:String;
		public var dataFineScelta:String;
		public var codiceMedico:String;
		public var provinciaAmbulatorio:String;
		
		public function VoDatiMedico()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoDatiMedico 				= new VoDatiMedico();
			cl.dataInizioScelta					= this.dataInizioScelta;
			cl.nomeMedico						= this.nomeMedico;
			cl.cognomeMedico					= this.cognomeMedico;
			cl.tipoAssistenza					= this.tipoAssistenza;
			cl.civicoAmbulatorio				= this.civicoAmbulatorio;
			cl.indirizzoAmbulatorio				= this.indirizzoAmbulatorio;	
			cl.capAmbulatorio					= this.capAmbulatorio;
			cl.denominazioneComuneAmbulatorio 	= this.denominazioneComuneAmbulatorio;
			cl.telefoniMedico					= this.telefoniMedico;
			cl.codiceComuneAmbulatorio			= this.codiceComuneAmbulatorio;
			cl.codiceFiscaleMedico				= this.codiceFiscaleMedico;
			cl.dataFineScelta					= this.dataFineScelta;
			cl.codiceMedico						= this.codiceMedico;
			cl.frazioneAmbulatorio				= this.frazioneAmbulatorio;
			cl.provinciaAmbulatorio				= this.provinciaAmbulatorio;
			return cl;
		}
	}
}