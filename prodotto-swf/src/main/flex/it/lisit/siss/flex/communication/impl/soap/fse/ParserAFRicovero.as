package it.lisit.siss.flex.communication.impl.soap.fse
{
	internal class ParserAFRicovero
	{
		private var attributi:XML;
		public function ParserAFRicovero(attributi:XML)
		{
			this.attributi = attributi;
		}
		public function execute():VoAFRicoveroImpl
		{
			return new VoAFRicoveroImpl(attributi);
		}
	}
}
/////////////////////////////////////////////////////////////////////////
import it.lisit.siss.flex.communication.ClonableValueObject;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFRicovero;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAccettazione;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoDiagnosi;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoDimissione;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoDiagnosi;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoInterventi;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoTrasferimenti;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoIntervento;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaErogazione;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoTrasferimento;
import it.lisit.siss.flex.utility.ArrayIterator;
import it.lisit.siss.flex.utility.IIterator;
class VoAFRicoveroImpl extends VoAFRicovero
{
	public function VoAFRicoveroImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{	
		
		var dtneon:String 				= attributi.child( "dataNascitaNeonato" );
		if(dtneon!=null && dtneon.length>0)
		{
			this.dataNascitaNeonato 	= dtneon;
		}
		this.dataOraRicovero			= attributi.child( "dataOraRicovero" );
		var datiAccettazioneList:XMLList= attributi.child( "datiAccettazione" );
		if(datiAccettazioneList!=null && datiAccettazioneList.length()>0)
		{
			this.datiAccettazione		= new VoAccettazioneImpl( datiAccettazioneList[0] );
		}
		var datiDimissioneList:XMLList	= attributi.child( "datiDimissione" );
		if(datiDimissioneList!=null && datiDimissioneList.length()>0)
		{
			this.datiDimissione = new VoDimissioneImpl( datiDimissioneList[0] );
		}
		
		this.descrizioneRepartoRicovero	= attributi.child( "descrizioneRepartoRicovero" );
		var listTrasf:XMLList			= attributi.child( "elencoTrasferimenti" );
		if(listTrasf!=null && listTrasf.length()>0)
		{
			var list:Array					= getListTrasferimenti( listTrasf[0] );
			this.elencoTrasferimenti		= new VoElencoTrasferimentiImpl( list );
		}
		this.idRepartoRicovero				= attributi.child( "idRepartoRicovero" );
		this.numeroNosologico				= attributi.child( "numeroNosologico" );
		var strutEro:XMLList				= attributi.child( "strutturaErogazione" );
		if(strutEro!=null&& strutEro.length()>0)
		{
			this.strutturaErogazione		= new VoStrutturaErogazioneImpl( strutEro[0] );
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAFRicoveroImpl 			= new VoAFRicoveroImpl( new XML() );
		clone.dataNascitaNeonato 			= this.dataNascitaNeonato;
		clone.dataOraRicovero				= this.dataOraRicovero;
		if(this.datiAccettazione!=null)
		{
			clone.datiAccettazione			= this.datiAccettazione.clone() as VoAccettazione;
		}
		if(this.datiDimissione!=null)
		{
			clone.datiDimissione 			= this.datiDimissione.clone() as VoDimissione;
		}
		clone.descrizioneRepartoRicovero	= this.descrizioneRepartoRicovero;
		if(this.elencoTrasferimenti!=null)
		{
			clone.elencoTrasferimenti		= this.elencoTrasferimenti.clone() as VoElencoTrasferimenti;
		}
		clone.idRepartoRicovero				= this.idRepartoRicovero;
		clone.numeroNosologico				= this.numeroNosologico;
		if(this.strutturaErogazione!=null)
		{
			clone.strutturaErogazione		= this.strutturaErogazione.clone() as VoStrutturaErogazione;
		}
		return clone;
	}
	private function getListTrasferimenti(elenco:XML):Array
	{
		var temp:Array = new Array();
		var trasferimenti:XMLList = elenco.child( "trasferimento" );
		for(var i:uint = 0;i<trasferimenti.length();i++)
		{
			var vo:VoTrasferimentoImpl = new VoTrasferimentoImpl(trasferimenti[i]);
			temp.push( vo );
		}
		return temp;
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
		var clone:VoStrutturaErogazioneImpl = new VoStrutturaErogazioneImpl( new XML() );
		clone.descrizioneEnte		= this.descrizioneEnte;
		clone.descrizionePresidio	= this.descrizionePresidio;	
		clone.idEnte				= this.idEnte;
		clone.idPresidio			= this.idPresidio;
		return clone;
	} 
}
class VoTrasferimentoImpl extends VoTrasferimento
{
	public function VoTrasferimentoImpl(trasferimento:XML)
	{
		super();
		parsing(trasferimento);
	}
	private function parsing(trasferimento:XML):void
	{
		if(trasferimento.length()==0)return;
		this.dataTrasferimento				= trasferimento.child( "dataTrasferimento" );
		this.descrizioneRepartoDestinazione	= trasferimento.child( "descrizioneRepartoDestinazione" );
		this.descrizioneRepartoOrigine		= trasferimento.child( "descrizioneRepartoOrigine" );
		this.idRepartoDestinazione			= trasferimento.child( "idRepartoDestinazione" );
		this.idRepartoOrigine				= trasferimento.child( "idRepartoOrigine" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoTrasferimentoImpl 		= new VoTrasferimentoImpl( new XML() );
		this.dataTrasferimento				= this.dataTrasferimento;
		this.descrizioneRepartoDestinazione	= this.descrizioneRepartoDestinazione;
		this.descrizioneRepartoOrigine		= this.descrizioneRepartoOrigine;
		this.idRepartoDestinazione			= this.idRepartoDestinazione;
		this.idRepartoOrigine				= this.idRepartoOrigine;
		return clone;
	} 
}
class VoElencoTrasferimentiImpl extends VoElencoTrasferimenti
{
	private var orig:Array; 
	private var iter:ArrayIterator; 
	public function VoElencoTrasferimentiImpl(list:Array)
	{
		super();
		orig = list;
		iter = new ArrayIterator( orig );
	}
	override public function get iterator():IIterator
	{
		return iter;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newIterator:ArrayIterator = new ArrayIterator( orig);
		while(newIterator.hasNext())
		{
			var item:ClonableValueObject = newIterator.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		}
		return new VoElencoTrasferimentiImpl( temp ); 
	}
}
class VoAccettazioneImpl extends VoAccettazione
{
	public function VoAccettazioneImpl(accettazione:XML)
	{
		super();
		parsing(accettazione);
	}
	private function parsing(accettazione:XML):void
	{
		if(accettazione.length()==0)return;
		var codDiaIngr:String				= accettazione.child( "codiceDiagnosiIngresso" );
		if(codDiaIngr!=null && codDiaIngr.length>0)
		{
			this.codiceDiagnosiIngresso		= codDiaIngr;
		}
		var descDiaIngr:String				= accettazione.child( "descrizioneDiagnosiIngresso" );
		if(descDiaIngr!=null && descDiaIngr.length>0)
		{
			this.descrizioneDiagnosiIngresso= descDiaIngr;
		}
		var descModTra:String				= accettazione.child( "descrizioneModalitaTrauma" );
		if(descModTra!=null && descModTra.length>0)
		{
			this.descrizioneModalitaTrauma	= descModTra;
		}
		var descOnedeg:String				= accettazione.child( "descrizioneOnereDegenza" );
		if(descOnedeg!=null && descOnedeg.length>0)
		{
			this.descrizioneOnereDegenza	= descOnedeg;
		}
		this.descrizioneProvenienzaPaziente	= accettazione.child( "descrizioneProvenienzaPaziente" );
		this.descrizioneRegimeRicovero		= accettazione.child( "descrizioneRegimeRicovero" );
		var descTipRic:String				= accettazione.child( "descrizioneTipoRicovero" );
		if(descTipRic!=null && descTipRic.length>0)
		{
			this.descrizioneTipoRicovero	= descTipRic;	
		}
		var idModTra:String					= accettazione.child( "idModalitaTrauma" );
		if(idModTra!=null && idModTra.length>0)
		{
			this.idModalitaTrauma			= idModTra;
		}	
		var idOnerDeg:String				= accettazione.child( "idOnereDegenza" );
		if(idOnerDeg!=null && idOnerDeg.length>0)
		{
			this.idOnereDegenza				= idOnerDeg;
		}
		this.idProvenienzaPaziente			= accettazione.child( "idProvenienzaPaziente" );
		this.idRegimeRicovero				= accettazione.child( "idRegimeRicovero" );
		var idTipRic:String					= accettazione.child( "idTipoRicovero" );
		if(idTipRic!=null && idTipRic.length>0)
		{
			this.idTipoRicovero				= idTipRic;
		}
		var _iup:String						= accettazione.child( "IUP" );
		if(_iup!=null && _iup.length>0)
		{
			this.IUP						= _iup;
		}
		var motRic:String					= accettazione.child( "motivoRicoveroDH" );
		if(motRic!=null && motRic.length>0)
		{
			this.motivoRicoveroDH			= motRic;
		}
		var prtPs:String					= accettazione.child( "numeroPraticaPS" );
		if(prtPs!=null && prtPs.length>0)
		{
			this.numeroPraticaPS			= prtPs;
		}	
		var numpre:String					= accettazione.child( "numeroPrericovero" );
		if(numpre!=null && numpre.length>0)
		{
			this.numeroPrericovero			= numpre;
		}	
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAccettazioneImpl 	= new VoAccettazioneImpl(new XML());
		clone.codiceDiagnosiIngresso		= this.codiceDiagnosiIngresso;
		clone.descrizioneDiagnosiIngresso= this.descrizioneDiagnosiIngresso;
		clone.descrizioneModalitaTrauma	= this.descrizioneModalitaTrauma;
		clone.descrizioneOnereDegenza	= this.descrizioneOnereDegenza;
		clone.descrizioneProvenienzaPaziente	= this.descrizioneProvenienzaPaziente;
		clone.descrizioneRegimeRicovero	= this.descrizioneRegimeRicovero;
		clone.descrizioneTipoRicovero	= this.descrizioneTipoRicovero;	
		clone.idModalitaTrauma			= this.idModalitaTrauma;	
		clone.idOnereDegenza				= this.idOnereDegenza;
		clone.idProvenienzaPaziente		= this.idProvenienzaPaziente;
		clone.idRegimeRicovero			= this.idRegimeRicovero;
		clone.idTipoRicovero				= this.idTipoRicovero;
		clone.IUP						= this.IUP;
		clone.motivoRicoveroDH			= this.motivoRicoveroDH;
		clone.numeroPraticaPS			= this.numeroPraticaPS;	
		clone.numeroPrericovero			= this.numeroPrericovero;
		return clone;
	}
}
class VoDimissioneImpl extends VoDimissione
{
	public function VoDimissioneImpl(dimissioni:XML)
	{
		super();
		parsing(dimissioni)
	}
	private function parsing(dimissioni:XML):void
	{
		this.codiceDiagnosiPrincipaleDimissione			= dimissioni.child( "codiceDiagnosiPrincipaleDimissione" );
		var dtEvind:String								= dimissioni.child( "dataEventoIndice" );
		if(dtEvind!=null && dtEvind.length>0)
		{
			this.dataEventoIndice						= dtEvind;
		}
		this.dataOraDimissione							= dimissioni.child( "dataOraDimissione" );
		var descCitt:String								= dimissioni.child( "descrizioneCittadinanza" );
		if(descCitt!=null && descCitt.length>0)
		{
			this.descrizioneCittadinanza				= descCitt;
		}
		var descRes:String								= dimissioni.child( "descrizioneComuneResidenza" );
		if(descRes!=null && descRes.length>0)
		{
			this.descrizioneComuneResidenza				= descRes;
		}	
		this.descrizioneDiagnosiPrincipaleDimissione	= dimissioni.child( "descrizioneDiagnosiPrincipaleDimissione" );	
		this.descrizioneModalitaDimissione				= dimissioni.child( "descrizioneModalitaDimissione" );
		var descProf:String								= dimissioni.child( "descrizionePosizioneProfessionale" );
		if(descProf!=null && descProf.length>0)
		{
			this.descrizionePosizioneProfessionale		= descProf;
		}
		this.descrizioneRepartoDimissione				= dimissioni.child( "descrizioneRepartoDimissione" );
		var descStatoCiv:String							= dimissioni.child( "descrizioneStatoCivile" );
		if(descStatoCiv!=null && descStatoCiv.length>0)
		{
			this.descrizioneStatoCivile					= descStatoCiv;
		}
		var elencoDiaList:XMLList						= dimissioni.child( "elencoDiagnosi" );
		if(elencoDiaList!=null && elencoDiaList.length()>0)
		{
			var list:Array								= getElencoDiagnosi(elencoDiaList[0]);
			this.elencoDiagnosi							= new VoElencoDiagnosiImpl(list);
		}
		var elencoInt:XMLList							= dimissioni.child( "elencoInterventi" );
		if(elencoInt!=null && elencoInt.length()>0)
		{
			var listaa:Array							= getListInterventi(elencoInt[0]);
			this.elencoInterventi						= new VoElencoInterventiImpl( listaa );
		}
		//////////////////////////////////////
		var flAut:String								= dimissioni.child( "flagAutoptico" );
		if(flAut!=null && flAut.length>0)
		{
			this.flagAutoptico							= flAut;
		}
		var girnDgnz:String								= dimissioni.child( "giorniDegenzaOrdinaria" );
		if(girnDgnz!=null && girnDgnz.length>0)
		{
			this.giorniDegenzaOrdinaria					= girnDgnz;
		}
		var girnPrs:String								= dimissioni.child( "giorniPresenzaDH" );
		if(girnPrs!=null && girnPrs.length>0)
		{
			this.giorniPresenzaDH						= girnPrs;
		}
		var idCitt:String								= dimissioni.child( "idCittadinanza" );
		if(idCitt!=null && idCitt.length>0)
		{
			this.idCittadinanza							= idCitt;
		}
		var idComm:String								= dimissioni.child( "idComuneResidenza" );
		if(idComm!=null && idComm.length>0)
		{
			this.idComuneResidenza						= idComm;
		}
		this.idModalitaDimissione						= dimissioni.child( "idModalitaDimissione" );
		var idPosProf:String							= dimissioni.child( "idPosizioneProfessionale" );
		if(idPosProf!=null && idPosProf.length>0)
		{
			this.idPosizioneProfessionale				= idPosProf;
		}
		this.idRepartoDimissione						= dimissioni.child( "idRepartoDimissione" );
		var neonato:XMLList								= dimissioni.child( "neonato" );
		if(neonato!=null && neonato.length()>0)
		{
			this.pesoNascita							= neonato[0].child( "pesoNascita" );
		}
	}
	private function getListInterventi(interventi:XML):Array
	{
		var temp:Array = new Array();
		var elenco:XMLList		= interventi.child( "intervento" );
		for(var i:uint = 0;i<elenco.length;i++)
		{
			var vo:VoInterventoImpl = new VoInterventoImpl( elenco[i] );
			temp.unshift( vo );
		}
		return temp;
	}
	private function getElencoDiagnosi(diagnosi:XML):Array
	{
		var temp:Array = new Array();
		var elenco:XMLList		= diagnosi.child( "diagnosi" );
		for(var i:uint = 0;i<elenco.length();i++)
		{
			var vo:VoDiagnosiImpl = new VoDiagnosiImpl( elenco[i] );
			temp.unshift( vo );
		}
		return temp;
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoDimissioneImpl = new VoDimissioneImpl(new XML());
		clone.codiceDiagnosiPrincipaleDimissione		= this.codiceDiagnosiPrincipaleDimissione;
		clone.dataEventoIndice							= this.dataEventoIndice	;
		clone.dataOraDimissione							= this.dataOraDimissione;
		clone.descrizioneCittadinanza					= this.descrizioneCittadinanza;	
		clone.descrizioneComuneResidenza				= this.descrizioneComuneResidenza;
		clone.descrizioneDiagnosiPrincipaleDimissione	= this.descrizioneDiagnosiPrincipaleDimissione;	
		clone.descrizioneModalitaDimissione				= this.descrizioneModalitaDimissione;
		clone.descrizionePosizioneProfessionale			= this.descrizionePosizioneProfessionale;
		clone.descrizioneRepartoDimissione				= this.descrizioneRepartoDimissione;
		clone.descrizioneStatoCivile					= this.descrizioneStatoCivile;
		if(this.elencoDiagnosi!=null)
		{
			clone.elencoDiagnosi						= this.elencoDiagnosi.clone() as VoElencoDiagnosi;
		}
		if(this.elencoInterventi!=null )
		{
			clone.elencoInterventi						= this.elencoInterventi.clone() as VoElencoInterventi;
		}
		clone.flagAutoptico								= this.flagAutoptico;
		clone.giorniDegenzaOrdinaria					= this.giorniDegenzaOrdinaria;
		clone.giorniPresenzaDH							= this.giorniPresenzaDH;
		clone.idCittadinanza							= this.idCittadinanza;
		clone.idComuneResidenza							= this.idComuneResidenza;
		clone.idModalitaDimissione						= this.idModalitaDimissione;
		clone.idPosizioneProfessionale					= this.idPosizioneProfessionale;
		clone.idRepartoDimissione						= this.idRepartoDimissione;
		clone.pesoNascita								= this.pesoNascita;
		return clone;
	}
}
class VoElencoDiagnosiImpl extends VoElencoDiagnosi
{
	private var orig:Array;
	private var iter:ArrayIterator;
	
	public function VoElencoDiagnosiImpl(list:Array)
	{
		super();
		orig = list;
		iter = new ArrayIterator( orig );
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newIter:ArrayIterator = new ArrayIterator( orig ); 
		while(newIter.hasNext())
		{
			var item:ClonableValueObject = newIter.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		}
		return new VoElencoDiagnosiImpl( temp );
	}
	override public function get iterator():IIterator
	{
		return iter;
	} 
}
//////////////////////////////////////////////
class VoDiagnosiImpl extends VoDiagnosi
{
	public function VoDiagnosiImpl(diagnosi:XML)
	{
		super();
		parsing(diagnosi);		
	}
	 
	private function parsing(diagnosi:XML):void
	{
		if(diagnosi.length()==0)return;
		this.dataFormulazioneDiagnosi 	= diagnosi.child( "dataFormulazioneDiagnosi" ); 
		this.descrizioneDiagnosi		= diagnosi.child( "descrizioneDiagnosi" ); 
		this.idDiagnosi					= diagnosi.child( "idDiagnosi" ); 
		///
		var diagn:String				=  diagnosi.child( "noteDiagnosi" );
		if(diagn!=null && diagn.length>0)
		{
			this.noteDiagnosi			= diagn;
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoDiagnosiImpl 		= new VoDiagnosiImpl( new XML() );
		this.dataFormulazioneDiagnosi 	= this.dataFormulazioneDiagnosi; 
		this.descrizioneDiagnosi		= this.descrizioneDiagnosi; 
		this.idDiagnosi					= this.idDiagnosi; 
		this.noteDiagnosi				= this.noteDiagnosi;
		return clone;
	} 
	
}
class VoInterventoImpl extends VoIntervento
{
	public  function VoInterventoImpl(intervento:XML)
	{
		super();
		parsing(intervento);
	}
	private function parsing(intervento:XML):void
	{
		if(intervento.length()==0)return;
		this.dataIntervento			= intervento.child( "dataIntervento" );
		this.descrizioneIntervento 	= intervento.child( "descrizioneIntervento" );
		this.idIntervento			= intervento.child( "idIntervento" );
		var intr:String				= intervento.child( "noteIntervento" );
		if(intr!=null && intr.length>0)
		{
			this.noteIntervento		= intr;
		}	
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoInterventoImpl		= new VoInterventoImpl( new XML() );
		clone.dataIntervento			= this.dataIntervento;
		clone.descrizioneIntervento 	= this.descrizioneIntervento;
		clone.idIntervento				= this.idIntervento;
		clone.noteIntervento			= this.noteIntervento;
		return clone;
	}
}
class VoElencoInterventiImpl extends VoElencoInterventi
{
	private var orig:Array;
	private var iter:ArrayIterator;
	public function VoElencoInterventiImpl(list:Array)
	{
		super();
		orig = list;
		iter = new ArrayIterator( orig );
	}
	override public function get iterator():IIterator
	{
		return iter;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var nwiterator:ArrayIterator = new ArrayIterator(orig);
		while(nwiterator.hasNext())
		{
			var item:ClonableValueObject = nwiterator.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		} 
		return new VoElencoInterventiImpl(temp);
	} 
}

