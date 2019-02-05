package it.lisit.siss.flex.communication.fse.voAutorizzaDce
{
	import it.lisit.siss.flex.communication.ValueObject;
	

	public class VoAutorizza extends ValueObject
	{ 	
		public var strutturaCreazione:VoStrutturaCreazione;
		
		public var cittadino:VoCittadino;
		
		public var autoreDocumento:VoAutoreDocumento;
		
		public var idsetDocumenti:String;
		public var noteReperibilita:String;
		public var idTipoDocumento:String;
		public var dataOraCreazione:String;
		
		public var attributiSpecifici:VoAttributiSpecifici;
		
		public function VoAutorizza()
		{
			super();
			strutturaCreazione 	= new VoStrutturaCreazione();
			cittadino 			= new VoCittadino();
			autoreDocumento		= new VoAutoreDocumento();
			attributiSpecifici	= new VoAttributiSpecifici()
		}
	}
}