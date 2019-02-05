package it.lisit.siss.flex.communication.impl.soap.icce
{
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoOutputIdentificaCittadinoEsteso2008_01;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoRispostaMultipla;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoRispostaSingola;
	import it.lisit.siss.flex.utility.debug.Debug;
	import it.lisit.siss.flex.utility.xml.XPathUtility;
	
	internal class ParserIdentificaCittadino
	{
		private var body:XML;
		public function ParserIdentificaCittadino(body:XML)
		{
			this.body = body;	
		}
		public function execute():VoOutputIdentificaCittadinoEsteso2008_01
		{
			var output:VoOutputIdentificaCittadinoEsteso2008_01 = new VoOutputIdentificaCittadinoEsteso2008_01();
			Debug.logInfo("ParserIdentificaCittadino body : " + body);
			var rSingola:XMLList
			if(body!=null)
			{
				rSingola		= XPathUtility.getNodeList(body,"//rispostaCittadinoIdentificato" );
				
			
				//var rSingola:XMLList = body.child("rispostaSingola");
				output.isRispostaSingola = false;
				if(rSingola!=null && rSingola.length()>0)
				{
					output.isRispostaSingola 				= true;
					var parserSingola:ParserSingola			= new ParserSingola( rSingola[0] );
					output.rispostaSingola					= new VoRispostaSingola();
					output.rispostaSingola.datiCittadino	= parserSingola.datiCittadino();
					output.rispostaSingola.datiMedico		= parserSingola.datiMedico();
					output.rispostaSingola.datiTesserino	= parserSingola.datiTesserino();
					output.rispostaSingola.esenzioniGodute	= parserSingola.esenzioniGodute();
					output.rispostaSingola.esitoServizio	= parserSingola.esitoServizio();
				}
				if(!output.isRispostaSingola)
				{
					var rMultipla:XMLList	= XPathUtility.getNodeList(body,"//rispostaListaAssistiti" );
					if(rMultipla!=null && rMultipla.length()>0)
					{
						output.rispostaMultipla = new VoRispostaMultiplaImpl( rMultipla[0] ); 
					}
				}
			}
			return output;
		}
	}
}
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoRispostaSingola;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoRispostaMultipla;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiCittadino;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiMedico;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiTesserino;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoEsenzioniGodute;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoListaAssistiti;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoAssistito;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoEsenzione;
	
class VoRispostaMultiplaImpl extends VoRispostaMultipla
{
	public function  VoRispostaMultiplaImpl(rMultipla:XML)
	{
		super();
		parsing(rMultipla);
	}
	private function parsing(rMultipla:XML):void
	{
		this.esitoServizio				= rMultipla.child( "esitoServizio" );
		var datiRispostaXml:XMLList		= rMultipla.child( "datiRisposta" );
		if(datiRispostaXml!=null && datiRispostaXml.length()>0)
		{
			var list:Array			= getAssistiti( datiRispostaXml[0] );
			this.listaAssistiti 	= new VoListaAssistitiImpl( list );
		}
	}
	private function getAssistiti( dati:XML ):Array
	{
		var temp:Array = new Array(); 
		var assistitoTrovatoXml:XMLList	= dati.child( "assistitoTrovato" );
		for(var i:uint = 0;i<assistitoTrovatoXml.length();i++)
		{
			var vo:VoAssistitoImpl = new VoAssistitoImpl( assistitoTrovatoXml[i] );
			temp.push( vo ); 
		}
		return temp;
	}
}
class VoAssistitoImpl extends VoAssistito
{
	public function VoAssistitoImpl(assitito:XML)
	{
		super();
		parsing(assitito);
	}
	private function parsing(assitito:XML):void
	{
		this.codiceFiscaleCittadino			= assitito.child( "codiceFiscaleCittadino" );
		this.codiceSanitarioCittadino		= assitito.child( "codiceSanitarioCittadino" );
		this.cognomeCittadino				= assitito.child( "cognomeCittadino" );
		this.comuneNascitaCittadino			= assitito.child( "comuneNascitaCittadino" );
		this.dataNascitaCittadino			= assitito.child( "dataNascitaCittadino" );
		
		this.idComuneNascitaCittadino		= assitito.child( "idComuneNascitaCittadino" );
		this.idProvenienza					= assitito.child( "idProvenienza" );
		this.idProvenienza					= assitito.child( "idProvenienza" );
		this.nomeCittadino					= assitito.child( "nomeCittadino" );
		this.sessoCittadino					= assitito.child( "sessoCittadino" );
		this.statoAssistito					= assitito.child( "statoAssistito" );
		this.dataUltimaVariazioneAnagrafici	= assitito.child( "dataUltimaVariazioneAnagrafici" );
		this.siglaAslAppartenenza			= assitito.child( "siglaAslAppartenenza" );
		this.origineDati					= assitito.child( "origineDati" );
	}
}
class VoListaAssistitiImpl extends VoListaAssistiti
{
	private var orig:Array;
	public function VoListaAssistitiImpl(list:Array)
	{
		super();
		orig = list;
		this.iterator = new ArrayIterator( orig );
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array	= new Array();
		var iter:ArrayIterator	= new ArrayIterator( orig );
		while(iter.hasNext())
		{
			var item:ClonableValueObject = iter.next() as ClonableValueObject;
			temp.push( item.clone() );
		}
		return new VoListaAssistitiImpl( temp );
	}
}