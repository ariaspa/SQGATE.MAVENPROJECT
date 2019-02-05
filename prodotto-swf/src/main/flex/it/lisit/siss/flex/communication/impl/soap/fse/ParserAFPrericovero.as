package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoIFAFPreRicovero;
	
	internal class ParserAFPrericovero
	{
		private var attributi:XML;
		public function ParserAFPrericovero(attributi:XML)
		{
			this.attributi = attributi;
		}
		
		public function execute():VoIFAFPreRicovero {
			var preRic:VoIFAFPreRicovero = new VoIFAFPreRicovero();
			if (attributi != null && attributi.length() > 0) {
//===========================================================================================
				if (attributi.child("neonato") != null) {
					preRic.dataNascitaNeonato	= attributi.neonato.child("dataNascitaNeonato");
				}
//===========================================================================================
				var strut:XMLList				= attributi.child( "strutturaErogazione" );
				if(strut != null && strut.length() > 0)
				{
					preRic.strutturaErogazione	= new VoStrutturaErogazionePrericoveroImpl(strut[0]);
				}		
//===========================================================================================
				var datiPreric:XMLList				= attributi.child( "datiPrericovero" );
				if(datiPreric != null && datiPreric.length() > 0)
				{
					preRic.datiPrericovero	= new VoDatiPrericoveroImpl(datiPreric[0]);
				}		
			}
			return preRic
		}

	}
}
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaErogazione;
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoDatiPrericovero;
	

class VoStrutturaErogazionePrericoveroImpl extends VoStrutturaErogazione
{
	public function  VoStrutturaErogazionePrericoveroImpl(struttura:XML)
	{
		super();
		parsing(struttura);
	}	
	private function parsing(struttura:XML):void
	{
		if(struttura.length()==0)return;
		this.descrizioneEnte			= struttura.child( "descrizioneEnte" );
		this.descrizionePresidio		= struttura.child( "descrizionePresidio" );	
		this.idEnte						= struttura.child( "idEnte" );
		this.idPresidio					= struttura.child( "idPresidio" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoStrutturaErogazionePrericoveroImpl = new VoStrutturaErogazionePrericoveroImpl (new XML());
		clone.descrizioneEnte			= this.descrizioneEnte;
		clone.descrizionePresidio		= this.descrizionePresidio;	
		clone.idEnte					= this.idEnte;
		clone.idPresidio				= this.idPresidio;
		return clone;
	}
}

class VoDatiPrericoveroImpl extends VoDatiPrericovero {
	
	public function VoDatiPrericoveroImpl(struttura:XML) {
		super();
		parsing(struttura)
	}
	
	private function parsing(struttura:XML):void {
		if(struttura.length()==0)return;
		this.codiceDiagnosi 			= struttura.child("codiceDiagnosi");
		this.dataOraFinePrericovero 	= struttura.child("dataOraFinePrericovero");
		this.dataOraInizioPrericovero 	= struttura.child("dataOraInizioPrericovero");
		this.descrizioneDiagnosi 		= struttura.child("descrizioneDiagnosi");
		this.descrizioneRepartoRicovero = struttura.child("descrizioneRepartoRicovero");
		this.idRepartoRicovero 			= struttura.child("idRepartoRicovero");
		this.numeroPrericovero 			= struttura.child("numeroPrericovero");
		this.iup						= struttura.child("IUP");
	}
	
}