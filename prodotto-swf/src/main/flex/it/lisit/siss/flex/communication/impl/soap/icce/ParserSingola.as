package it.lisit.siss.flex.communication.impl.soap.icce
{
	import it.lisit.siss.flex.utility.debug.Debug;
	
	internal class ParserSingola
	{
		private var rSingola:XML
		private var dtCittadino:XMLList
		private var dtMedico:XMLList
		private var dtTesserino:XMLList
		private var rsGodute:XMLList
		
		public function ParserSingola(singola:XML)
		{
			this.rSingola = singola;
			var datiRispostaXml:XMLList		= rSingola.child( "datiRisposta" );
			if(datiRispostaXml!=null && datiRispostaXml.length()>0)
			{
				var datiRisposta:XML 	= datiRispostaXml[0];
				//
				dtCittadino 	= datiRisposta.child( "datiCittadino" );
				dtMedico 		= datiRisposta.child( "datiMedico" );
				dtTesserino		= datiRisposta.child( "datiTesserino" );
				rsGodute		= datiRisposta.child( "esenzioniGodute" );
			}
		}
		public function datiCittadino():VoDatiCittadinoImpl
		{
			if(dtCittadino!=null && dtCittadino.length()>0)
			{
		 		return new VoDatiCittadinoImpl( dtCittadino[0] );
		 	}
		 	return null;
		}
		public function datiMedico():VoDatiMedicoImpl
		{
			if(dtMedico!=null && dtMedico.length()>0)
			{
				Debug.logInfo( "datiMedico :: "+dtMedico);
			 	return new VoDatiMedicoImpl( dtMedico[0] );
			}
			return null;
		}
		public function datiTesserino():VoDatiTesserinoImpl
		{
			if(dtTesserino!=null && dtTesserino.length()>0)
			{
				Debug.logInfo( "datiTesserino :: "+dtTesserino);
				return new VoDatiTesserinoImpl( dtTesserino[0] );
			}
			return null;
		}
		public function esenzioniGodute():VoEsenzioniGoduteImpl
		{
			if(rsGodute!=null && rsGodute.length()>0)
			{
				Debug.logInfo( "rsGodute :: "+rsGodute)
				return new VoEsenzioniGoduteImpl( rsGodute[0] );
			}
			return null;
		}
		public function esitoServizio():String{return rSingola.child( "esitoServizio" );}
	}
}
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiCittadino;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiMedico;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiTesserino;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoEsenzione;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoEsenzioniGodute;
	import it.lisit.siss.flex.utility.ArrayIterator;
		 

class VoDatiCittadinoImpl extends VoDatiCittadino
{
	public function VoDatiCittadinoImpl(citt:XML)
	{
		super();
		if(citt!=null);
		parsing(citt);
	}
	private function parsing(citt:XML):void
	{
		 
		this.capDomicilioCittadino			= citt.child( "capDomicilioCittadino" );
		this.idCasaRiposo					= citt.child( "idCasaRiposo" );
		this.descrizioneRSA					= citt.child( "descrizioneRSA" );
		this.codiceDistrettoAppartenenza	= citt.child( "codiceDistrettoAppartenenza" );
		this.descrizioneDistrettoAppartenenza	= citt.child( "descrizioneDistrettoAppartenenza" );
		this.validatoMef					= citt.child( "validatoMef" );
		this.dataValidazioneMef				= citt.child( "dataValidazioneMef" );
		this.dataDecesso					= citt.child( "dataDecesso" );
		this.tipoRilevazione				= citt.child( "tipoRilevazione" );
		this.capResidenzaCittadino			= citt.child( "capResidenzaCittadino" );
		this.civicoDomicilioCittadino		= citt.child( "civicoDomicilioCittadino" );
		this.civicoResidenzaCittadino		= citt.child( "civicoResidenzaCittadino" );
		this.codiceFiscalePrecedenteCittadino= citt.child( "codiceFiscalePrecedenteCittadino" );
		this.frazioneResidenzaCittadino		= citt.child( "frazioneResidenzaCittadino" );
		this.origineDati					= citt.child( "origineDati" );
		this.dataUltimaVariazioneAmministrativi= citt.child( "dataUltimaVariazioneAmministrativi" );
		this.codiceFiscaleCittadino			= citt.child( "codiceFiscaleCittadino" );
		this.frazioneDomicilioCittadino		= citt.child( "frazioneDomicilioCittadino" );
		this.codiceDistrettoAssistenza		= citt.child( "codiceDistrettoAssistenza" );
		this.dataUltimaVariazioneAnagrafici	= citt.child( "dataUltimaVariazioneAnagrafici" );
		this.dataUltimaVariazioneResidenza	= citt.child( "dataUltimaVariazioneResidenza" );
		this.descrizioneDistrettoAssistenza	= citt.child( "descrizioneDistrettoAssistenza" );
		this.descrizioneAslAssistenza		= citt.child( "descrizioneAslAssistenza" );
		this.codiceSanitarioCittadino		= citt.child( "codiceSanitarioCittadino" );	
		this.cognomeCittadino				= citt.child( "cognomeCittadino" );
		this.comuneDomicilioCittadino		= citt.child( "comuneDomicilioCittadino" );	
		this.comuneNascitaCittadino			= citt.child( "comuneNascitaCittadino" );
		this.comuneResidenzaCittadino		= citt.child( "comuneResidenzaCittadino" );	
		this.dataDecorrenzaIscrizione		= citt.child( "dataDecorrenzaIscrizione" );
		this.dataNascitaCittadino			= citt.child( "dataNascitaCittadino" );
		this.dataScadenzaIscrizione			= citt.child( "dataScadenzaIscrizione" );
		this.descrizioneAslAppartenenza		= citt.child( "descrizioneAslAppartenenza" );
		this.descrizioneAslAssistenza		= citt.child( "descrizioneAslAssistenza" );
		this.idComuneDomicilioCittadino		= citt.child( "idComuneDomicilioCittadino" );
		this.idComuneNascitaCittadino		= citt.child( "idComuneNascitaCittadino" );
		this.idComuneResidenzaCittadino		= citt.child( "idComuneResidenzaCittadino" );
		this.idProvenienza					= citt.child( "idProvenienza" );
		this.indirizzoDomicilioCittadino	= citt.child( "indirizzoDomicilioCittadino" );	
		this.indirizzoResidenzaCittadino	= citt.child( "indirizzoResidenzaCittadino" );
		this.nomeCittadino					= citt.child( "nomeCittadino" );
		this.provinciaDomicilioCittadino	= citt.child( "provinciaDomicilioCittadino" );
		this.provinciaNascitaCittadino		= citt.child( "provinciaNascitaCittadino" );
		this.provinciaResidenzaCittadino	= citt.child( "provinciaResidenzaCittadino" );
		this.sessoCittadino					= citt.child( "sessoCittadino" );
		this.siglaAslAppartenenza			= citt.child( "siglaAslAppartenenza" );
		this.siglaAslAssistenza				= citt.child( "siglaAslAssistenza" );
		this.statoAssistito					= citt.child( "statoAssistito" );
		this.statoAggiornamentoCRS			= citt.child( "statoAggiornamentoCRS" );
	}
} 

class VoDatiMedicoImpl extends VoDatiMedico
{
	public function VoDatiMedicoImpl(medd:XML)
	{
		super();
		if(medd!=null);
			parsing(medd);
	}
	private function parsing(medd:XML):void
	{
		
		this.capAmbulatorio					= medd.child( "capAmbulatorio" );
		this.civicoAmbulatorio				= medd.child( "civicoAmbulatorio" );
		this.codiceComuneAmbulatorio		= medd.child( "codiceComuneAmbulatorio" );
		this.codiceFiscaleMedico			= medd.child( "codiceFiscaleMedico" );
		this.codiceMedico					= medd.child( "codiceMedico" );
		this.cognomeMedico					= medd.child( "cognomeMedico" );
		this.dataFineScelta					= medd.child( "dataFineScelta" );
		this.dataInizioScelta				= medd.child( "dataInizioScelta" );	
		this.denominazioneComuneAmbulatorio	= medd.child( "denominazioneComuneAmbulatorio" );
		this.indirizzoAmbulatorio			= medd.child( "indirizzoAmbulatorio" );	
		this.nomeMedico						= medd.child( "nomeMedico" );
		this.telefoniMedico					= medd.child( "telefoniMedico" );
		this.tipoAssistenza					= medd.child( "tipoAssistenza" );
		this.frazioneAmbulatorio			= medd.child( "frazioneAmbulatorio" );
		this.provinciaAmbulatorio			= medd.child( "provinciaAmbulatorio" );
	}
}

class VoDatiTesserinoImpl extends VoDatiTesserino
{
	public function VoDatiTesserinoImpl(tess:XML)
	{
		super();
		parsing(tess);
	}
	private function parsing(tess:XML):void
	{
		if(tess==null)return;
		this.codiceTesserino			= tess.child( "codiceTesserino" );
		this.dataAssegnazioneTesserino	= tess.child( "dataAssegnazioneTesserino" );
	}
}

class VoEsenzioniGoduteImpl extends VoEsenzioniGodute
{
	private var orig:Array;
	public function VoEsenzioniGoduteImpl(esenzioni:XML)
	{
		super();
		parsing(esenzioni);
	}
	private function parsing(esenzioni:XML):void
	{
		if(esenzioni==null || esenzioni.length()==0)return;
		this.occorrenze		= esenzioni.child( "occorrenze" );
		var esenXml:XMLList	= esenzioni.child( "esenzione" );
		if(esenXml!=null && esenXml.length()>0)
		{
			orig					= getList(esenXml);
			this.iteratorEsenzioni	= new ArrayIterator(orig);
		}
	}
	override public function clone():ClonableValueObject
	{
		var cl:VoEsenzioniGoduteImpl 	= new VoEsenzioniGoduteImpl(new XML());
		var iter:ArrayIterator			= new ArrayIterator( orig );
		var temp:Array					= new Array();
		while(iter.hasNext())
		{
			var item:ClonableValueObject = iter.next() as ClonableValueObject;
			temp.push( item.clone() );
		}	
		cl.occorrenze					= this.occorrenze;
		cl.iteratorEsenzioni			= new ArrayIterator( temp ); 	
		return cl;
	}
	private function getList(listXml:XMLList):Array
	{
		var temp:Array	= new Array();
		for(var i:uint = 0;i<listXml.length();i++)
		{
			var vo:VoEsenzioneImpl = new VoEsenzioneImpl( listXml[i] );
			temp.push( vo );
		}
		return temp;
	}
}

class VoEsenzioneImpl extends VoEsenzione
{
	public function VoEsenzioneImpl(esen:XML)
	{
		super();
		parsing(esen);
	}
	private function parsing(esen:XML):void
	{
		this.codiceEsenzione		= esen.child( "codiceEsenzione" );
		this.decorrenzaEsenzione	= esen.child( "decorrenzaEsenzione" );
		this.scadenzaEsenzione		= esen.child( "scadenzaEsenzione" );
	}
}