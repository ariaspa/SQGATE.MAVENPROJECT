package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFVaccinazioni;
	
	internal class ParserAFVaccinazioni
	{
		private var attributi:XML;
		public function ParserAFVaccinazioni(attributi:XML)
		{
			this.attributi = attributi;
		}
		public function execute():VoAFVaccinazioniImpl
		{
			return new VoAFVaccinazioniImpl(attributi);
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFVaccinazioni;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaErogazioneVaccinazioni;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoPatologie;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPatologia;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoVaccinazioni;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoVaccinazione;
	import mx.collections.ArrayCollection;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.utility.ArrayIterator;
	
class VoAFVaccinazioniImpl extends VoAFVaccinazioni
{
	public function VoAFVaccinazioniImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		if(attributi.length()==0)return;
		var struttura:XMLList = attributi.child( "strutturaErogazione" );
		if(struttura!=null && struttura.length()>0)
		{
			this.strutturaErogazione = new VoStrutturaErogazioneVaccinazioniImpl(struttura[0]);
		}
		var elencoXml:XMLList		= attributi.child( "elencoPatologie" );
		if(elencoXml!=null && elencoXml.length()>0)
		{
			var list:Array			= getPatologie(elencoXml[0]);
			this.elencoPatologie  	=  new VoElencoPatologieImpl(list);
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAFVaccinazioniImpl = new VoAFVaccinazioniImpl(new XML());
		if(this.strutturaErogazione!=null)
		{
			clone.strutturaErogazione = this.strutturaErogazione.clone() as VoStrutturaErogazioneVaccinazioni;
		}
		if(this.elencoPatologie !=null)
		{
			clone.elencoPatologie  	=  this.elencoPatologie.clone() as VoElencoPatologie;
		}
		return clone;
	}
	private function getPatologie(elenco:XML):Array
	{
		var temp:Array = new Array();
		var patologie:XMLList	= elenco.child( "patologia" );
		for(var i:uint = 0;i<patologie.length();i++)
		{
			var vo:VoPatologiaImpl = new VoPatologiaImpl(patologie[i]);
			temp.push( vo );
		}
		return temp;
	}
}
class VoElencoPatologieImpl extends VoElencoPatologie
{
	private var orig:Array;
	private var iter:ArrayIterator;
	public function VoElencoPatologieImpl(list:Array)
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
		var newiter:ArrayIterator = new ArrayIterator(orig);
		while(newiter.hasNext())
		{
			var item:ClonableValueObject = newiter.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		}
		return new VoElencoPatologieImpl( temp );
	}
}
class VoPatologiaImpl extends VoPatologia
{
	public function VoPatologiaImpl(patologia:XML)
	{
		super();
		parsing(patologia);
	}
	private function parsing(patologia:XML):void
	{
		if(patologia.length()==0)return;
		this.descrizionePatologia	= patologia.child( "descrizionePatologia" );
		this.idPatologia			= patologia.child( "idPatologia" );
		var listXml:XMLList			= patologia.child( "elencoVaccinazioni" );
		if(listXml!=null && listXml.length()>0)
		{
			var list:Array			= getVaccinazioni(listXml[0]);
			this.elencoVaccinazioni = new VoElencoVaccinazioniImpl(list);
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoPatologiaImpl = new VoPatologiaImpl(new XML());
		clone.descrizionePatologia	= this.descrizionePatologia;
		clone.idPatologia			= this.idPatologia;
		if(this.elencoVaccinazioni!=null)
		{
			clone.elencoVaccinazioni = this.elencoVaccinazioni.clone() as VoElencoVaccinazioni;
		}
		return clone;
	}
	private function getVaccinazioni(elenco:XML):Array
	{
		var temp:Array = new Array();
		var vaccinazioni:XMLList	= elenco.child( "vaccinazione" );
		for(var i:uint = 0;i<vaccinazioni.length();i++)
		{
			var vo:VoVaccinazioneImpl = new VoVaccinazioneImpl(vaccinazioni[i]);
			temp.push( vo );
		}
		return temp;
	}
}
class VoVaccinazioneImpl extends VoVaccinazione
{
	public function VoVaccinazioneImpl(vacc:XML)
	{
		super();
		parsing(vacc);
	}
	private function parsing(vacc:XML):void
	{
		if(vacc.length()==0)return;
		this.dataErogazione				= vacc.child( "dataErogazione" );
		this.descrizioneVaccinazione	= vacc.child( "descrizioneVaccinazione" );
		this.idVaccinazione				= vacc.child( "idVaccinazione" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoVaccinazioneImpl = new VoVaccinazioneImpl(new XML());
		clone.dataErogazione				= this.dataErogazione;
		clone.descrizioneVaccinazione	= this.descrizioneVaccinazione;
		clone.idVaccinazione				= this.idVaccinazione;
		return clone;
	}
}
class VoElencoVaccinazioniImpl extends VoElencoVaccinazioni
{
	private var orig:Array;
	private var iter:ArrayIterator
	public function VoElencoVaccinazioniImpl(list:Array)
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
			temp.push( item.clone() );
		}
		return new VoElencoVaccinazioniImpl( temp );
	}
}
class VoStrutturaErogazioneVaccinazioniImpl extends VoStrutturaErogazioneVaccinazioni
{
	public function VoStrutturaErogazioneVaccinazioniImpl(struttura:XML)
	{
		super();
		parsing(struttura);
	}
	private function parsing(struttura:XML):void
	{
		if(struttura.length()==0)return;
		this.idEnte				= struttura.child( "idEnte" );
		this.descrizioneEnte	= struttura.child( "descrizioneEnte" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoStrutturaErogazioneVaccinazioniImpl = new VoStrutturaErogazioneVaccinazioniImpl(new XML());
		clone.idEnte				= this.idEnte;
		clone.descrizioneEnte		= this.descrizioneEnte;
		return clone;
	}
}