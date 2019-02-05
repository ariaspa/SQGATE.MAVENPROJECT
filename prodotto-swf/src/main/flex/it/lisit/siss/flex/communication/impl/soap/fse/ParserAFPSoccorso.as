package it.lisit.siss.flex.communication.impl.soap.fse
{
	internal class ParserAFPSoccorso
	{
		private var attributi:XML;
		public function ParserAFPSoccorso(attributi:XML)
		{
			this.attributi = attributi;
		}
		public function execute():VoAFPSoccorsoImpl
		{
			return new VoAFPSoccorsoImpl(attributi);
		}
	}
}
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFPSoccorso;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAccettazionePSoccorso;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoDimissionePS;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoPrestazioni;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazionePS;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaErogazione;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
	
class VoAFPSoccorsoImpl extends VoAFPSoccorso
{
	public function VoAFPSoccorsoImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		if(attributi.length()==0)return;
		this.dataOraIngresso		= attributi.child( "dataOraIngresso" );
		var dtAccettazione:XMLList	= attributi.child( "datiAccettazione" );
		if(dtAccettazione!=null && dtAccettazione.length()>0)
		{
			this.datiAccettazione 	= new VoAccettazionePSoccorsoImpl(dtAccettazione[0]);
		}
		var dtDimissione:XMLList	= attributi.child( "datiDimissione" );
		if(dtDimissione!=null && dtDimissione.length()>0)
		{
			this.datiDimissione 	= new VoDimissionePSImpl( dtDimissione[0] );
		}
		
		this.numeroPraticaPS		= attributi.child( "numeroPraticaPS" );
		var strErr:XMLList			= attributi.child( "strutturaErogazione" );
		if(strErr!=null && strErr.length()>0)
		{
			this.strutturaErogazione= new VoStrutturaErogazioneImpl( strErr[0] );
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAFPSoccorsoImpl = new VoAFPSoccorsoImpl(new XML());
		clone.dataOraIngresso		= this.dataOraIngresso;
		if(this.datiAccettazione!=null)
		{
			clone.datiAccettazione 	= this.datiAccettazione.clone() as VoAccettazionePSoccorso;
		}
		if(this.datiDimissione!=null)
		{
			clone.datiDimissione 	= this.datiDimissione.clone() as VoDimissionePS;
		}
		clone.numeroPraticaPS		= this.numeroPraticaPS;
		if(this.strutturaErogazione!=null)
		{
			clone.strutturaErogazione= this.strutturaErogazione.clone() as VoStrutturaErogazione;
		}
		return clone;
	}
}
class VoStrutturaErogazioneImpl extends VoStrutturaErogazione
{
	public function VoStrutturaErogazioneImpl(struttura:XML)
	{
		super();
		parsing(struttura);
	}
	private function parsing(struttura:XML):void
	{
		if(struttura.length()==0)return;
		this.descrizioneEnte		= struttura.child( "descrizioneEnte" );
		this.descrizionePresidio	= struttura.child( "descrizionePresidio" );
		this.idEnte					= struttura.child( "idEnte" );	
		this.idPresidio				= struttura.child( "idPresidio" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoStrutturaErogazioneImpl = new VoStrutturaErogazioneImpl(new XML());
		clone.descrizioneEnte				= this.descrizioneEnte;
		clone.descrizionePresidio			= this.descrizionePresidio;
		clone.idEnte						= this.idEnte;	
		clone.idPresidio					= this.idPresidio;
		return clone;
	}
}
class VoDimissionePSImpl extends VoDimissionePS
{
	public function VoDimissionePSImpl(dimissioniPs:XML)
	{
		super();
		parsing(dimissioniPs);
	}
	private function parsing(dimissioniPs:XML):void
	{
		if(dimissioniPs.length()==0)return;
		var	codDia:String						= dimissioniPs.child( "codiceDiagnosiDimissione" );
		if(codDia!=null && codDia.length>0)
		{
			this.codiceDiagnosiDimissione		= codDia;
		}
		this.dataOraUscita						= dimissioniPs.child( "dataOraUscita" );
		var	codDiaDim:String					= dimissioniPs.child( "descrizioneDiagnosiDimissione" );
		if(codDiaDim!=null && codDiaDim.length>0)
		{
			this.descrizioneDiagnosiDimissione	= codDiaDim;
		}
		var	codModDim:String					= dimissioniPs.child( "descrizioneModalitaDimissione" );
		if(codModDim!=null && codModDim.length>0)
		{
			this.descrizioneModalitaDimissione	= codModDim;
		}
		var elencoPres:XMLList					= dimissioniPs.child( "elencoPrestazioni" );
		if(elencoPres!=null && elencoPres.length()>0)
		{
			var list:Array						= getElencoPrestazioni( elencoPres[0] );
			this.elencoPrestazioni				= new VoElencoPrestazioniImpl( list );
		}
		var	idModDim:String						= dimissioniPs.child( "idModalitaDimissione" );
		if(idModDim!=null && idModDim.length>0)
		{
			this.idModalitaDimissione			= idModDim;
		}
		var	note:String							= dimissioniPs.child( "noteDimissione" );
		if(note!=null && note.length>0)
		{
			this.noteDimissione					= note;
		}
		var	pro:String							= dimissioniPs.child( "prognosi" );
		if(pro!=null && pro.length>0)
		{
			this.prognosi						= pro;
		}
	} 
	
	private function getElencoPrestazioni(elenco:XML):Array
	{
		var temp:Array = new Array();
		var prestazioni:XMLList = elenco.child( "prestazione" );
		for(var i:uint = 0;i<prestazioni.length();i++)
		{
			var vo:VoPrestazionePSImpl = new VoPrestazionePSImpl(prestazioni[i]);
			temp.push( vo );
		}
		return temp;
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoDimissionePSImpl		= new VoDimissionePSImpl(new XML());
		clone.codiceDiagnosiDimissione		= this.codiceDiagnosiDimissione
		clone.dataOraUscita					= this.dataOraUscita	
		clone.descrizioneDiagnosiDimissione	= this.descrizioneDiagnosiDimissione
		clone.descrizioneModalitaDimissione	= this.descrizioneModalitaDimissione;
		if(this.elencoPrestazioni!=null)
		{
			clone.elencoPrestazioni				= this.elencoPrestazioni.clone() as VoElencoPrestazioni;
		}
		clone.idModalitaDimissione			= this.idModalitaDimissione;
		clone.noteDimissione				= this.noteDimissione;
		clone.prognosi						= this.prognosi;
		return clone;
	}
}
class VoPrestazionePSImpl extends VoPrestazionePS
{
	public function VoPrestazionePSImpl(presta:XML)
	{
		super();
		parsing(presta);		
	}
	private function parsing(presta:XML):void
	{
		if(presta.length()==0)return;
		this.descrizionePrestazioneSISS = presta.child( "descrizionePrestazioneSISS" );
		this.idPrestazioneSISS			= presta.child( "idPrestazioneSISS" );
		this.quantitaErogata			= presta.child( "quantitaErogata" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoPrestazionePSImpl 		= new VoPrestazionePSImpl(new XML());
		clone.descrizionePrestazioneSISS 	= this.descrizionePrestazioneSISS;
		clone.idPrestazioneSISS				= this.idPrestazioneSISS;
		clone.quantitaErogata				= this.quantitaErogata;
		return clone;
	}
}
class VoElencoPrestazioniImpl extends VoElencoPrestazioni
{
	private var orig:Array;
	private var iter:ArrayIterator;
	public function VoElencoPrestazioniImpl(list:Array)
	{
		super();
		orig = list;
		iter = new ArrayIterator(orig);
	}
	override public function get iterator():IIterator
	{
		return iter;
	} 
	override public function clone():ClonableValueObject
	{
		var temp:Array 				= new Array();
		var newIter:ArrayIterator	= new ArrayIterator(orig);
		while(newIter.hasNext())
		{
			var item:ClonableValueObject	= newIter.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		}
		return new VoElencoPrestazioniImpl( temp );
	}
}
class VoAccettazionePSoccorsoImpl extends VoAccettazionePSoccorso
{
	public function VoAccettazionePSoccorsoImpl(datiaccettazione:XML)
	{
		super();
		parsing(datiaccettazione);
	}
	private function parsing(datiaccettazione:XML):void
	{
		if(datiaccettazione.length()==0)return;
		var descClPrTr:String							= datiaccettazione.child( "descrizioneClassePrioritaTriage" );
		if(descClPrTr!=null && descClPrTr.length>0)
		{
			this.descrizioneClassePrioritaTriage		= descClPrTr;
		}
		var descDisc:String								= datiaccettazione.child( "descrizioneDisciplina" );
		if(descDisc!=null && descDisc.length>0)
		{
			this.descrizioneDisciplina					= descDisc;
		}
		var descModIng:String							= datiaccettazione.child( "descrizioneModalitaIngresso" );
		if(descModIng!=null && descModIng.length>0)
		{
			this.descrizioneModalitaIngresso			= descModIng;
		}
		var descModTr:String							= datiaccettazione.child( "descrizioneModalitaTrauma" );
		if(descModTr!=null && descModTr.length>0)
		{
			this.descrizioneModalitaTrauma				= descModTr;
		}		
		var idClTR:String								= datiaccettazione.child( "idClassePrioritaTriage" );
		if(idClTR!=null && idClTR.length>0)
		{
			this.idClassePrioritaTriage					= idClTR;
		}
		var iddisc:String								= datiaccettazione.child( "idDisciplina" );
		if(iddisc!=null && iddisc.length>0)
		{
			this.idDisciplina							= iddisc;
		}
		var idModIng:String								= datiaccettazione.child( "idModalitaIngresso" );
		if(idModIng!=null && idModIng.length>0)
		{
			this.idModalitaIngresso						= idModIng;
		}
		var idModTra:String								= datiaccettazione.child( "idModalitaTrauma" );
		if(idModTra!=null && idModTra.length>0)
		{
			this.idModalitaTrauma						= idModTra;
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAccettazionePSoccorsoImpl 	= new VoAccettazionePSoccorsoImpl(new XML());
		clone.descrizioneClassePrioritaTriage	= this.descrizioneClassePrioritaTriage;
		clone.descrizioneDisciplina				= this.descrizioneDisciplina;
		clone.descrizioneModalitaIngresso		= this.descrizioneModalitaIngresso;
		clone.descrizioneModalitaTrauma			= this.descrizioneModalitaTrauma;
		clone.idClassePrioritaTriage			= this.idClassePrioritaTriage;
		clone.idDisciplina						= this.idDisciplina;
		clone.idModalitaIngresso				= this.idModalitaIngresso;	
		clone.idModalitaTrauma					= this.idModalitaTrauma;
		return clone;
	}
}