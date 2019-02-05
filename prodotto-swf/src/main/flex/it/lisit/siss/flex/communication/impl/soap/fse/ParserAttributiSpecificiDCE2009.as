package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.ConstTipiAttributiDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCEEvaluationNote;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCELDimissione;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiSpecificiDCE;
	import it.lisit.siss.flex.utility.ArrayIterator;
	
	internal class ParserAttributiSpecificiDCE2009 implements IParserAttributiDCE
	{
		private var listQName:Array;
		private var listQName_2:Array;
	 
		public function ParserAttributiSpecificiDCE2009()
		{
			listQName 	= getListQname();
			listQName_2 = getListQname2();
		}
		private function getListQname():Array
		{
			var temp:Array = new Array();
			temp[ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009]	= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/attributi_referto/","attributi_referto");
			temp[ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO]		= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_psoccorso/","attributi_psoccorso");
			temp[ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE]	= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_ldimissione/","attributi_ldimissione");
			temp[ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009]	= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/attributi_enote/","attributi_enote");								 								
			return temp;
		}
		private function getListQname2():Array
		{
			var temp:Array = new Array();
			temp[ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009]	= new QName("","attributi_referto");
			temp[ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO]		= new QName("","attributi_psoccorso");
			temp[ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE]	= new QName("","attributi_ldimissione");
			temp[ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009]	= new QName("","attributi_enote");										 								
			return temp;
		}
		private function getAttributiSpecifici(attributi:XML,count:int = -1):VoAttributiSpecificiDCE
		{
			switch(count)
			{
				case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009:
					return new VoADCERefertoImpl(attributi);
				case ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO:
					return new VoADCEPSoccorsoImpl(attributi);
				case ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE:
					return new VoADCELDimissioneImpl(attributi);
				case ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009:
					return new VoADCEEvaluationNoteImpl(attributi);
			}
			return null;
		}
		public function getAttributi(attributi:XML, param:Object=null):VoAttributiSpecificiDCE
		{
			var hasChild:Boolean	= (attributi.children().length()>0);
			var attSpecifici:VoAttributiSpecificiDCE = null;
			var attXmllist:XMLList;
			var qname:QName;
			for(var i:uint = ConstTipiAttributiDCE.ATTRIBUTI_REFERTO; i <= ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009+1; i++)
			{
				qname		=  listQName[i] as QName;
				if (qname == null) continue;
				attXmllist 	= attributi[qname];
				if(attXmllist!=null && attXmllist.length()>0)
				{
					attSpecifici = getAttributiSpecifici(attXmllist[0],i);
					break;
				}
			} 
			if(attSpecifici==null)
			{
				var urinamespace:String = QName(attributi.name()).uri;
				for(i = ConstTipiAttributiDCE.ATTRIBUTI_REFERTO; i <= ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009; i++)
				{
					qname		= listQName_2[i] as QName;
					if (qname == null) continue;
					qname		= new QName(urinamespace,qname.localName);
					attXmllist 	= attributi[qname];
					if(attXmllist!=null && attXmllist.length()>0)
					{
						attSpecifici = getAttributiSpecifici(attXmllist[0],i);
						break;
					}
				} 
			}
			// non è stato trovato un attributo specifico corrispondente, ma il tag contiene dei figli
			// istanzio quello generico			
		 	if(attSpecifici==null && hasChild)
		 	{
		 		attSpecifici = new VoAttributiSpecificiDCE();
		 	} 
			return attSpecifici;
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCEEvaluationNote;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCELDimissione;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCEPSoccorso;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoADCEReferto;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoMedicoRichiedente;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazioniAssociate;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazioneReferto;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoPrestazioni;
	
////////////////////////////////
class VoADCEEvaluationNoteImpl extends VoADCEEvaluationNote
{
	public function VoADCEEvaluationNoteImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		if(attributi.length()==0)return;
		var neon:XMLList			= attributi.child( "neonato" );
		if(neon!=null && neon.length()>0)
		{
			this.dataNascitaNeonato = neon[0].child( "dataNascitaNeonato" );
		}
		this.dataOraIngresso		= attributi.child( "dataOraIngresso" );
		this.idPresidio				= attributi.child( "idPresidio" );
		this.numeroNosologico		= attributi.child( "numeroNosologico" );
		this.numeroPrericovero		= attributi.child( "numeroPrericovero" );
		this.descrizionePresidio	= attributi.child( "descrizionePresidio" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoADCEEvaluationNoteImpl = new VoADCEEvaluationNoteImpl(new XML());
		clone.dataNascitaNeonato 	= this.dataNascitaNeonato;
		clone.dataOraIngresso		= this.dataOraIngresso;
		clone.idPresidio			= this.idPresidio;
		clone.numeroNosologico		= this.numeroNosologico;
		clone.numeroPrericovero		= this.numeroPrericovero;
		clone.descrizionePresidio	= this.descrizionePresidio;
		return clone;
	}
}
class VoADCELDimissioneImpl extends VoADCELDimissione
{
	public function VoADCELDimissioneImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		if(attributi.length()==0)return;
		var neon:XMLList			= attributi.child( "neonato" );
		if(neon!=null && neon.length()>0)
		{
			this.dataNascitaNeonato = neon[0].child( "dataNascitaNeonato" );
		}
		this.dataOraAccettazione 	= attributi.child( "dataOraAccettazione" );
		this.idPresidio				= attributi.child( "idPresidio" );
		var iuppi:String			= attributi.child( "IUP" );
		if(iuppi!=null && iuppi.length>0)
		{
			this.IUP = iuppi;
		}
		var nmnos:String			= attributi.child( "numeroNosologico" );
		if(nmnos!=null && nmnos.length>0)
		{
			this.numeroNosologico = nmnos;
		}
		this.descrizionePresidio	= attributi.child( "descrizionePresidio" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoADCELDimissioneImpl = new VoADCELDimissioneImpl(new XML());
		clone.dataNascitaNeonato 	= this.dataNascitaNeonato;
		clone.dataOraAccettazione 	= this.dataOraAccettazione;
		clone.idPresidio			= this.idPresidio;
		clone.IUP 					= this.IUP;
		clone.numeroNosologico 		= this.numeroNosologico;
		clone.descrizionePresidio	= this.descrizionePresidio;
		return clone; 	 
	}
}
class VoADCEPSoccorsoImpl extends VoADCEPSoccorso
{
	public function VoADCEPSoccorsoImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		if(attributi.length()==0)return;
		this.dataOraAccettazione	= attributi.child( "dataOraAccettazione" );
		this.idPresidio				= attributi.child( "idPresidio" );
		this.numeroPraticaPS		= attributi.child( "numeroPraticaPS" );	
		this.descrizionePresidio	= attributi.child( "descrizionePresidio" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoADCEPSoccorsoImpl = new VoADCEPSoccorsoImpl(new XML());
		clone.dataOraAccettazione	= this.dataOraAccettazione;
		clone.idPresidio			= this.idPresidio;
		clone.numeroPraticaPS		= this.numeroPraticaPS;
		clone.descrizionePresidio	= this.descrizionePresidio;
		return clone;
	}
}
class VoADCERefertoImpl extends VoADCEReferto
{
	public function VoADCERefertoImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		if(attributi.length()==0)return;
		var neon:XMLList					= attributi.child( "neonato" );
		if(neon!=null && neon.length()>0)
		{
			this.dataNascitaNeonato 		= neon[0].child( "dataNascitaNeonato" );
		}
		var dtRic:String					= attributi.child( "dataOraRichiesta" );
		if(dtRic!=null && dtRic.length>0)
		{
			this.dataOraRichiesta			= dtRic;
		}
		this.idPresidio						= attributi.child( "idPresidio" );
		var idUnop:String					= attributi.child( "idUnitaOperativaRichiedente" );
		if(idUnop!=null && idUnop.length>0)
		{
			this.idUnitaOperativaRichiedente=idUnop;
		}
		var medicoRic:XMLList				=  attributi.child( "medicoRichiedente" );
		if(medicoRic!=null && medicoRic.length()>0)
		{
			this.medicoRichiedente = new VoMedicoRichiedenteImpl(medicoRic[0]);
		}
		var numCartAmb:String					= attributi.child( "numeroCartellaAmbulatoriale" );
		if(numCartAmb!=null && numCartAmb.length>0)
		{
			this.numeroCartellaAmbulatoriale	=numCartAmb;
		}
		this.numeroNosologico					= attributi.child( "numeroNosologico" );
		this.numeroPraticaPS					= attributi.child( "numeroPraticaPS" );
		this.numeroPrericovero					= attributi.child( "numeroPrericovero" );
		var prestAss:XMLList					= attributi.child( "prestazioniAssociate" );
		if(prestAss!= null && prestAss.length()>0)
		{
			var list:Array				= getPrestazioni(prestAss[0]);
			this.prestazioniAssociate	= new VoElencoPrestazioniImpl(list);
		}
		this.descrizionePresidio						= attributi.child( "descrizionePresidio" );	
		this.descrizioneUnitaOperativaRichiedente		= attributi.child( "descrizioneUnitaOperativaRichiedente" );	
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoADCERefertoImpl = new VoADCERefertoImpl(new XML());
		clone.descrizionePresidio			= this.dataNascitaNeonato;
		clone.descrizioneUnitaOperativaRichiedente = this.descrizioneUnitaOperativaRichiedente;
		clone.dataNascitaNeonato 			= this.dataNascitaNeonato;
		clone.dataOraRichiesta				= this.dataOraRichiesta;
		clone.idPresidio					= this.idPresidio;
		clone.idUnitaOperativaRichiedente	= this.idUnitaOperativaRichiedente;
		if(this.medicoRichiedente!=null)
		{
			clone.medicoRichiedente 		= this.medicoRichiedente.clone() as VoMedicoRichiedente;
		}
		clone.numeroCartellaAmbulatoriale	= this.numeroCartellaAmbulatoriale;
		clone.numeroNosologico				= this.numeroNosologico;
		clone.numeroPraticaPS				= this.numeroPraticaPS;
		clone.numeroPrericovero				= this.numeroPrericovero;
		if(this.prestazioniAssociate!= null)
		{
			clone.prestazioniAssociate		= this.prestazioniAssociate.clone() as VoElencoPrestazioni;
		}
		return clone;
	}
	private function getPrestazioni(prestazioni:XML):Array
	{
		var temp:Array 		= new Array();
		var lista:XMLList	= prestazioni.child( "prestazione" );
		for(var i:uint = 0;i<lista.length();i++)
		{
			var vo:VoPrestazioneRefertoImpl = new VoPrestazioneRefertoImpl(lista[i]);
			temp.push( vo );
		}
		return temp;
	}
}

class VoPrestazioneRefertoImpl extends VoPrestazioneReferto
{
	public function VoPrestazioneRefertoImpl(prestazione:XML)
	{
		super();
		parsing(prestazione);
	}
	private function parsing(prestazione:XML):void
	{
		if(prestazione.length()==0)return;
		var flAgg:String			= prestazione.child( "flagAggiuntiva" );
		if(flAgg!=null && flAgg.length>0)
		{
			this.flagAggiuntiva			= flAgg;
		}
		this.descrizionePrestazioneSISS	= prestazione.child( "descrizionePrestazioneSISS" );
		var idpre:String				= prestazione.child( "idPrestazioneSISS" );
		
		if(idpre!=null && idpre.length>0)
		{
			this.idPrestazioneSISS	= idpre; 
		}
		var qua:String			= prestazione.child( "quantitaErogata" );
		if(qua!=null && qua.length>0)
		{
			this.quantitaErogata	= qua;  
		}
		this.IUP					= prestazione.child( "IUP" );		
		
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoPrestazioneRefertoImpl = new VoPrestazioneRefertoImpl(new XML());
		clone.flagAggiuntiva		= this.flagAggiuntiva;
		clone.idPrestazioneSISS		= this.idPrestazioneSISS;
		clone.IUP					= this.IUP;	
		clone.quantitaErogata		= this.quantitaErogata;
		clone.descrizionePrestazioneSISS	= this.descrizionePrestazioneSISS;
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
		var temp:Array	= new Array();
		var newiterator:ArrayIterator = new ArrayIterator(orig);
		while(newiterator.hasNext())
		{
			var item:ClonableValueObject = newiterator.next() as ClonableValueObject;
			temp.unshift( item.clone() );	
		}
		return new VoElencoPrestazioniImpl(temp);
	}
}
class VoMedicoRichiedenteImpl extends VoMedicoRichiedente
{
	public function VoMedicoRichiedenteImpl(medico:XML)
	{
		super();
		parsing(medico);
	}
	private function parsing(medico:XML):void
	{
		if(medico.length()==0)return;
		var cod:String			= medico.child( "codiceFiscale" );
		if(cod!=null && cod.length>0)
		{
			this.codiceFiscale = cod;
		}
		var cogn:String			=  medico.child( "cognome" );
		if(cogn!=null && cogn.length>0)
		{
			this.cognome = cogn;
		}
		var nm:String			= medico.child( "nome" );
		if(nm!=null && nm.length>0)
		{
			this.nome			= nm;
		} 
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoMedicoRichiedenteImpl = new VoMedicoRichiedenteImpl(new XML());
		clone.codiceFiscale 	= this.codiceFiscale;
		clone.cognome 			= this.cognome ;
		clone.nome				= this.nome;
		return clone;
	}
}