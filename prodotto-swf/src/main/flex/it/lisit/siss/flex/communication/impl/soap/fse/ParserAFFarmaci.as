package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFFarmaci;
	
	internal class ParserAFFarmaci
	{
		private var attributi:XML;
		public function ParserAFFarmaci(attributi:XML)
		{
			this.attributi = attributi;
		}
		public function execute():VoAFFarmaciImpl
		{
			return new VoAFFarmaciImpl(attributi);
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFFarmaci;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoFarmaciErogati;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoFarmaco;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaErogazioneFarmaci;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaErogazione;
	
class VoAFFarmaciImpl extends VoAFFarmaci
{
	public function VoAFFarmaciImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		trace("parsingparsingparsing VoAFFarmaci ");
		if(attributi.length()==0)return;
		this.dataErogazione 			= attributi.child( "dataErogazione" );
		this.IUP						= attributi.child( "IUP" );
		var elenco:XMLList				= attributi.child( "elencoFarmaciErogati" );
		if(elenco!=null && elenco.length()>0)
		{
			trace("elenco farmaci "+elenco);
			
			var list:Array				= getListfarmaci(elenco[0]);
			this.elencoFarmaciErogati	= new VoElencoFarmaciErogatiImpl(list);
		}
		var strut:XMLList				= attributi.child( "strutturaErogazione" );
		if(strut!=null && strut.length()>0)
		{
			this.strutturaErogazione	= new VoStrutturaErogazioneFarmaciImpl(strut[0]);
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAFFarmaciImpl 		= new VoAFFarmaciImpl(new XML());
		clone.dataErogazione 			= this.dataErogazione;
		clone.IUP						= this.IUP;
		if(this.elencoFarmaciErogati!=null)
		{
			clone.elencoFarmaciErogati	= this.elencoFarmaciErogati.clone() as VoElencoFarmaciErogati;
		}
		if(this.strutturaErogazione!=null)
		{
			clone.strutturaErogazione	= this.strutturaErogazione.clone() as VoStrutturaErogazioneFarmaci;
		}
		return clone;
	}
	private function getListfarmaci(elenco:XML):Array
	{
		var temp:Array 				= new Array();
		var listXM:XMLList 			= elenco.children();
		for(var i:uint = 0;i<listXM.length();i++)
		{
			//trace("-getListfarmaci-> elenco[i] ::: "+listXM[i]);
			var vo:VoFarmacoImpl = new VoFarmacoImpl(listXM[i]);
			temp.push( vo );
		}
		return temp;
	}
}
class VoStrutturaErogazioneFarmaciImpl extends VoStrutturaErogazioneFarmaci
{
	public function  VoStrutturaErogazioneFarmaciImpl(struttura:XML)
	{
		super();
		parsing(struttura);
	}	
	private function parsing(struttura:XML):void
	{
		if(struttura.length()==0)return;
		this.descrizioneASLAppartenenza	= struttura.child( "descrizioneASLAppartenenza" );
		this.descrizioneFarmacia		= struttura.child( "descrizioneFarmacia" );	
		this.idASLAppartenenza			= struttura.child( "idASLAppartenenza" );
		this.idFarmacia					= struttura.child( "idFarmacia" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoStrutturaErogazioneFarmaciImpl = new VoStrutturaErogazioneFarmaciImpl(new XML());
		clone.descrizioneASLAppartenenza	= this.descrizioneASLAppartenenza;
		clone.descrizioneFarmacia			= this.descrizioneFarmacia;	
		clone.idASLAppartenenza				= this.idASLAppartenenza;
		clone.idFarmacia					= this.idFarmacia;
		return clone;
	}
}

/*
<farmaco>
	<idFarmaco>F2</idFarmaco>
	<denominazioneCommercialeFarmaco>CARDIOASPIRIN</denominazioneCommercialeFarmaco>
	<idPrincipioAttivoFarmaco>dsasdsd</idPrincipioAttivoFarmaco>
	<descrizionePrincipioAttivoFarmaco>ACIDO ACETILSALICITICO</descrizionePrincipioAttivoFarmaco>
	<idClasseTerapeuticaFarmaco>12</idClasseTerapeuticaFarmaco>
	<descrizioneClasseTerapeuticaFarmaco>ANTITROMBOTICI</descrizioneClasseTerapeuticaFarmaco>
	<quantitaConfezioni>1</quantitaConfezioni>
	<unitaMisura/>
</farmaco>
*/
class VoFarmacoImpl extends VoFarmaco
{
	public function VoFarmacoImpl(farmaco:XML)
	{
		super();
		parsing(farmaco);
	}
	private function parsing(farmaco:XML):void
	{
		if(farmaco.length()==0)return;
		
		this.idFarmaco								= farmaco.child( "idFarmaco" );
		this.denominazioneCommercialeFarmaco		= farmaco.child( "denominazioneCommercialeFarmaco" );
		this.descrizioneClasseTerapeuticaFarmaco	= farmaco.child( "descrizioneClasseTerapeuticaFarmaco" );
		this.descrizionePrincipioAttivoFarmaco		= farmaco.child( "descrizionePrincipioAttivoFarmaco" );
		this.idClasseTerapeuticaFarmaco				= farmaco.child( "idClasseTerapeuticaFarmaco" );
		
		this.idPrincipioAttivoFarmaco				= farmaco.child( "idPrincipioAttivoFarmaco" );
		this.quantitaConfezioni						= farmaco.child( "quantitaConfezioni" );
		this.unitaMisura							= farmaco.child( "unitaMisura" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoFarmacoImpl 					= new VoFarmacoImpl(new XML());
		clone.denominazioneCommercialeFarmaco		= this.denominazioneCommercialeFarmaco;
		clone.descrizioneClasseTerapeuticaFarmaco	= this.descrizioneClasseTerapeuticaFarmaco;
		clone.descrizionePrincipioAttivoFarmaco		= this.descrizionePrincipioAttivoFarmaco;
		clone.idClasseTerapeuticaFarmaco			= this.idClasseTerapeuticaFarmaco;
		clone.idFarmaco								= this.idFarmaco;
		clone.idPrincipioAttivoFarmaco				= this.idPrincipioAttivoFarmaco;
		clone.quantitaConfezioni					= this.quantitaConfezioni;
		return clone;
	}
}
class VoElencoFarmaciErogatiImpl extends VoElencoFarmaciErogati
{
	private var orig:Array;
	private var iter:ArrayIterator;
	public function VoElencoFarmaciErogatiImpl(list:Array)
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
		var temp:Array = new Array();
		var newIter:ArrayIterator = new ArrayIterator(orig);
		while(newIter.hasNext())
		{
			var item:ClonableValueObject = newIter.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		}
		return new VoElencoFarmaciErogatiImpl( temp );
	}
}



