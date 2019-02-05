package it.lisit.siss.flex.communication.impl.soap.fse
{
	internal class ParserAFAmbulatoriale
	{
		private var attributi:XML;
		public function ParserAFAmbulatoriale(attributi:XML)
		{
			this.attributi = attributi;
		}
		public function execute():VoAFAmbulatorialeImpl
		{
			return new VoAFAmbulatorialeImpl( attributi );
		}
	}
}
///////////////////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFAmbulatoriale;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazioniAssociate;
	
class VoAFAmbulatorialeImpl extends VoAFAmbulatoriale
{
	public function VoAFAmbulatorialeImpl(attributi:XML)
	{
		super();
		parsing(attributi);
	}
	private function parsing(attributi:XML):void
	{
		if(attributi.length()==0)return;
		//==============================================================================  
		var codDia:String							 =  attributi.child( "codiceDiagnosi" );
		if(codDia!=null && codDia.length>0)
			this.codiceDiagnosi			 			 =  codDia;
		//==============================================================================		
		this.dataAccettazione                    =  attributi.child( "dataAccettazione" );     
		this.dataPrenotazione                    =  attributi.child( "dataPrenotazione" );    
		//==============================================================================     
		var dtpre:String							 =  attributi.child( "dataPrescrizione" );
		if(dtpre!=null && dtpre.length>0)	    
			this.dataPrescrizione                    = 	dtpre;
		//==============================================================================	
		var dscclpr:String							 =  attributi.child( "descrizioneClassePriorita" );
		if(dscclpr!=null && dscclpr.length>0)         
			this.descrizioneClassePriorita           =  dscclpr; 
		//==============================================================================    
		var dscdia:String							 =  attributi.child( "descrizioneDiagnosi" );
		if(dscdia!=null && dscdia.length>0)	     
			this.descrizioneDiagnosi                 =  dscdia;
		 //==============================================================================
		this.descrizioneEnte                     =  attributi.child( "descrizioneEnte" );   
		//==============================================================================
		var dscESE:String							 =  attributi.child( "descrizioneEsenzione" );
		if(dscESE!=null && dscESE.length>0)	 
			this.descrizioneEsenzione                =  dscESE;
		//==============================================================================
		this.descrizionePresidio                 =  attributi.child( "descrizionePresidio" );
		//==============================================================================     
		var dscPrvPz:String							 =  attributi.child( "descrizioneProvenienzaPaziente" );
		if(dscPrvPz!=null && dscPrvPz.length>0)	    
			this.descrizioneProvenienzaPaziente      =  dscPrvPz;
		//==============================================================================
		var dscRGER:String							 =  attributi.child( "descrizioneRegimeErogazione" );
		if(dscRGER!=null && dscRGER.length>0)	
			this.descrizioneRegimeErogazione         =  dscRGER;
		//==============================================================================     
		var dscTipPre:String							 =  attributi.child( "descrizioneTipoPrestazione" );
		if(dscTipPre!=null && dscTipPre.length>0)	
			this.descrizioneTipoPrestazione          =  dscTipPre;
		//==============================================================================     
		var idclpr:String							 =  attributi.child( "idClassePriorita" );
		if(idclpr!=null && idclpr.length>0)
			this.idClassePriorita                    = idclpr;
		//==============================================================================
		this.idEnte                              =  attributi.child( "idEnte" );  
		//==============================================================================     
		var idES:String							 =  attributi.child( "idEsenzione" );
		if(idES!=null && idES.length>0)           
			this.idEsenzione                         =  idES;
		//==============================================================================     
		var idRur:String							 =  attributi.child( "idPrescrizioneRUR" );
		if(idRur!=null && idRur.length>0)	    
			this.idPrescrizioneRUR                   =  idRur;    
		//==============================================================================
		this.idPresidio                          =  attributi.child( "idPresidio" );      
		//============================================================================== 
		var idPrvPz:String							 =  attributi.child( "idProvenienzaPaziente" );
		if(idPrvPz!=null && idPrvPz.length>0)	    
			this.idProvenienzaPaziente               =  idPrvPz;
		//============================================================================== 
		var idrGeR:String							 =  attributi.child( "idRegimeErogazione" );
		if(idrGeR!=null && idrGeR.length>0)	
			this.idRegimeErogazione                  =  idrGeR;  
		//============================================================================== 	
		var codTipP:String							 = attributi.child( "idTipoPrestazione" );
		if(codTipP!=null && codTipP.length>0)
			this.idTipoPrestazione                   = codTipP; 
		//==============================================================================
		this.IUP                             	 	 =  attributi.child( "IUP" );
		//============================================================================== 
		var medicoRic:XMLList						 = attributi.child( "medicoRichiedente" );
		if(medicoRic!=null && medicoRic.length()>0)
		{
			var codFisc:String							 =  medicoRic[0].child( "codiceFiscale" );
			if(codFisc!=null && codFisc.length>0)	                  
				this.medicoRichiedente_codiceFiscale     = codFisc
			//============================================================================== 
			var codReg:String							 =  medicoRic[0].child( "codiceRegionale" );
			if(codReg!=null && codReg.length>0)	
				this.medicoRichiedente_codiceRegionale   =  codReg;
		}
		
		//============================================================================== 
		var ip:String							 =  attributi.child( "numeroCartellaAmbulatoriale" );
		if(ip!=null && ip.length>0)	
			this.numeroCartellaAmbulatoriale     =  ip;
		//==============================================================================
		var pAssociate:XMLList					 = 	attributi.child( "prestazioniAssociate" );
		if(pAssociate!=null && pAssociate.length()>0)
		{
			var listPrestazioni:Array				 =  getPrestazioniAssociate(pAssociate[0]);
			this.prestazioniAssociate                =  new VoPrestazioniAssociateImpl ( listPrestazioni );	
		}
		//============================================================================== 
		var ques:String							 =  attributi.child( "quesitoDiagnostico" );
		if(ques!=null && ques.length>0)	
			this.quesitoDiagnostico                  = ques;   

	}
	private function getPrestazioniAssociate(prestazioni:XML):Array
	{
		var temp:Array = new Array();
		var listPrestazioni:XMLList = prestazioni.child( "prestazione" );
		for(var i:uint	= 0;i<listPrestazioni.length();i++)
		{
			var voPrestazione:VoPrestazione = new VoPrestazioneImpl(listPrestazioni[i]);
			temp.unshift( voPrestazione );
		}
		return temp;
	} 
	override public function clone():ClonableValueObject
	{
		var clone:VoAFAmbulatorialeImpl 		  =  new VoAFAmbulatorialeImpl(new XML());
		clone.codiceDiagnosi			 		  =  this.codiceDiagnosi		
		clone.dataAccettazione                    =  this.dataAccettazione     
		clone.dataPrenotazione                    =  this.dataPrenotazione     
		clone.dataPrescrizione                    =  this.dataPrescrizione     
		clone.descrizioneClassePriorita           =  this.descrizioneClassePriorita
		clone.descrizioneDiagnosi                 =  this.descrizioneDiagnosi  
		clone.descrizioneEnte                     =  this.descrizioneEnte      
		clone.descrizioneEsenzione                =  this.descrizioneEsenzione 
		clone.descrizionePresidio                 =  this.descrizionePresidio  
		clone.descrizioneProvenienzaPaziente      =  this.descrizioneProvenienzaPaziente
		clone.descrizioneRegimeErogazione         =  this.descrizioneRegimeErogazione
		clone.descrizioneTipoPrestazione          =  this.descrizioneTipoPrestazione
		clone.idClassePriorita                    =  this.idClassePriorita     
		clone.idEnte                              =  this.idEnte               
		clone.idEsenzione                         =  this.idEsenzione          
		clone.idPrescrizioneRUR                   =  this.idPrescrizioneRUR    
		clone.idPresidio                          =  this.idPresidio           
		clone.idProvenienzaPaziente               =  this.idProvenienzaPaziente
		clone.idRegimeErogazione                  =  this.idRegimeErogazione   
		clone.idTipoPrestazione                   =  this.idTipoPrestazione    
		clone.IUP                                 =  this.IUP                  
		clone.medicoRichiedente_codiceFiscale     =  this.medicoRichiedente_codiceFiscale
		clone.medicoRichiedente_codiceRegionale   =  this.medicoRichiedente_codiceRegionale
		clone.numeroCartellaAmbulatoriale         =  this.numeroCartellaAmbulatoriale
		
		if( this.prestazioniAssociate != null)
			clone.prestazioniAssociate            =  this.prestazioniAssociate.clone() as VoPrestazioniAssociate;
			 
		clone.quesitoDiagnostico                  =  this.quesitoDiagnostico   
		return clone;
	}
}

	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazioniAssociate;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazione;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFClassificazioneCittadino;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoSottoCategorie;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoSottoCategoria;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFRicovero;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazione;
	
class VoPrestazioniAssociateImpl extends VoPrestazioniAssociate
{
	private var orig:Array; 
	private var list:ArrayIterator; 
	public function VoPrestazioniAssociateImpl(prestazioni:Array)
	{
		super();
		orig = prestazioni;
		list = new ArrayIterator(orig);
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newiterator:ArrayIterator = new ArrayIterator(orig);
		while(newiterator.hasNext())
		{
			var item:ClonableValueObject = newiterator.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		}
		return new VoPrestazioniAssociateImpl(temp);
	}
	override public function get iterator():IIterator
	{
		return list;
	}
}
////////////////////
class VoPrestazioneImpl extends VoPrestazione
{
	public function VoPrestazioneImpl(prestazione:XML)
	{
		super();
		parsing(prestazione);
	}
	private function parsing(prestazione:XML):void
	{
		if(prestazione.length()==0)return;
		this.descrizionePrestazioneSISS	= prestazione.child( "descrizionePrestazioneSISS" );
		this.flagAggiuntiva				= prestazione.child( "flagAggiuntiva" );				
		this.idPrestazioneSISS			= prestazione.child( "idPrestazioneSISS" );	
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoPrestazioneImpl 		= new VoPrestazioneImpl(new XML());
		clone.descrizionePrestazioneSISS 	= this.descrizionePrestazioneSISS;
		clone.flagAggiuntiva				= this.flagAggiuntiva;
		clone.idPrestazioneSISS				= this.idPrestazioneSISS;		
		return clone;
	}
}
////////////////////