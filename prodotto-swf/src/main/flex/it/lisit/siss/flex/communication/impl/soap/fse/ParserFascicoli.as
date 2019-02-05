package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaFolder;
	
	internal class ParserFascicoli
	{
		private var fascicoli:XMLList;
		public function ParserFascicoli(fascicoli:XMLList)
		{
			this.fascicoli = fascicoli;
		}
		public function execute():VoListaFolder
		{
			var temp:Array = new Array();
			var parserAttributi:ParserAttributiFolder 	= new ParserAttributiFolder();	
			var parserDce:IParserAttributiDCE			= new ParserAttributiSpecificiDCE();		
			for(var i:uint = 0;i<fascicoli.length();i++)
			{
				var fasc:XML = fascicoli[i];
				var voFolder:VoFolderImpl = new VoFolderImpl(fasc,parserAttributi,parserDce);  
				temp.unshift( voFolder );
			}
			return new VoListaFolderImpl(temp);
		}
		
		public function executeParserIndice():VoListaFolder
		{
			var temp:Array = new Array();
			var parserAttributi:ParserAttributiFolderIndice 	= new ParserAttributiFolderIndice();	
			//var parserDce:IParserAttributiDCE			= new ParserAttributiSpecificiDCE();		
			for(var i:uint = 0;i<fascicoli.length();i++)
			{
				var fasc:XML = fascicoli[i];
				var voFolder:VoFolderImpl = new VoFolderImpl(fasc,parserAttributi,null);  
				temp.unshift( voFolder );
			}
			return new VoListaFolderImpl(temp);
		}
		
		public function executeParser2009():VoListaFolder
		{
			var temp:Array = new Array();
			var parserAttributi:ParserAttributiFolder 		= new ParserAttributiFolder();
			var parserDce:IParserAttributiDCE				= new ParserAttributiSpecificiDCE2009();		
			for(var i:uint = 0;i<fascicoli.length();i++)
			{
				var fasc:XML = fascicoli[i];
				var voFolder:VoFolderImpl = new VoFolderImpl(fasc,parserAttributi,parserDce);  
				temp.unshift( voFolder );
			}
			return new VoListaFolderImpl(temp);
		}
		
		public function createListaDce2009(dceList:XML):VoListaDCE
		{
			var list:XMLList = dceList.child( "setDocumentale" );
			var temp:Array	= new Array();	
			var parserDce:IParserAttributiDCE			= new ParserAttributiSpecificiDCE2009();
			for(var i:uint = 0;i <list.length();i++)
			{
				var setDocumentale:XML = list[i];
				var voSetDoc:VoSetDocumentale2009Impl 	= new VoSetDocumentale2009Impl(setDocumentale,parserDce);
				temp.unshift(  voSetDoc );
			}
			if(temp.length==0)return null;
			return new VoListaDCE2009Impl( temp );
		}
	}
}
////////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaFolder;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
/**
 * Implementa l'iteratore della lista dei folder;
 * @author Marco Salonia
 * 
 */	
class VoListaFolderImpl extends VoListaFolder
{
	private var lista:ArrayIterator;
	public function VoListaFolderImpl(listaFolder:Array)
	{
		lista = new ArrayIterator( listaFolder );
	}
	override public function get iterator():IIterator
	{
		return lista;
	}
}
////////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoFolder;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiFolder;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoSetDocumentale;
class VoFolderImpl extends VoFolder
{
	private var parserAttributiFolder:IParserAttributiFolder;
	private var parserDCE:IParserAttributiDCE;
	public function VoFolderImpl(folder:XML,parserAttributiFolder:IParserAttributiFolder,parserDCE:IParserAttributiDCE)
	{
		super();
		this.parserAttributiFolder = parserAttributiFolder;
		this.parserDCE			   = parserDCE;
		parsing(folder);
	}
	private function parsing(folder:XML):void
	{
		if(folder.length()>0)
		{
			var idfld:String		=  folder.child( "idFolder" );
			if(idfld!=null && idfld.length>0)
				this.idFolder			= idfld;
			//===========================================================	
			var idFldPdr:String		= folder.child( "idTipoFolderPadre" );
			if(idFldPdr!=null && idFldPdr.length>0)
				this.idTipoFolderPadre	= idFldPdr;
			//===========================================================
			this.idTipoFolder		= folder.child( "idTipoFolder" );
			this.attributiFolder 	= createAttributiFolder( folder.child( "attributiSpecificiFolder" ) );
			this.descrizioneFolder	= folder.child( "descrizioneFolder" );
			this.etichettaFolder	= folder.child( "etichettaFolder" );
			this.idStatoFolder		= folder.child( "idStatoFolder" );
			this.nLivelloFolder		= folder.child( "nLivelloFolder" );
			var lstDce:XMLList		= folder.child( "listaDCE" );
			if(lstDce!=null && lstDce.length()>0)
			{
				// Consulta fascicolo 2008
				//this.listaDCE			= createListaDce( lstDce[0] );
				/**
				* per le modifiche alla consultaFascicolo2009 cambia il parsing della
				* lista DCE
				*/
				this.listaDCE = createListaDce2009(lstDce[0]);			
			}
		}
	}
	private function createListaDce(dceList:XML):VoListaDCE
	{
		var list:XMLList = dceList.child( "setDocumentale" );
		var temp:Array	= new Array();	
		for(var i:uint = 0;i <list.length();i++)
		{
			var setDocumentale:XML = list[i];
			var voSetDoc:VoSetDocumentaleImpl = new VoSetDocumentaleImpl(setDocumentale,parserDCE);
			temp.unshift(  voSetDoc );
		}
		if(temp.length==0)return null;
		return new VoListaDCEImpl( temp );
	}
	private function createListaDce2009(dceList:XML):VoListaDCE
	{
		var list:XMLList = dceList.child( "setDocumentale" );
		var temp:Array	= new Array();	
		for(var i:uint = 0;i <list.length();i++)
		{
			var setDocumentale:XML = list[i];
			var voSetDoc:VoSetDocumentale2009Impl = new VoSetDocumentale2009Impl(setDocumentale,parserDCE);
			temp.unshift(  voSetDoc );
		}
		if(temp.length==0)return null;
		return new VoListaDCE2009Impl( temp );
	}
	private function createAttributiFolder(attributiList:XMLList = null):VoAttributiFolder
	{
	if(attributiList==null || attributiList.length()==0) return null;
		var attributi:XML 	= attributiList[0];
		var voAttributi:VoAttributiFolder = parserAttributiFolder.getAttributi( attributi );
		return voAttributi;
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoFolderImpl 	= new VoFolderImpl(new XML(),parserAttributiFolder,parserDCE);
		if(this.attributiFolder!=null)
			clone.attributiFolder	= this.attributiFolder.clone() as VoAttributiFolder;
		clone.descrizioneFolder = this.descrizioneFolder;
		clone.etichettaFolder	= this.etichettaFolder;
		if(this.idFolder!=null)
			clone.idFolder			= this.idFolder;
		clone.idStatoFolder		= this.idStatoFolder;
		clone.idTipoFolder		= this.idTipoFolder;
		if(this.idTipoFolderPadre!=null)
			clone.idTipoFolderPadre	= this.idTipoFolderPadre;
		if(this.listaDCE!=null)
			clone.listaDCE			= this.listaDCE.clone() as VoListaDCE;
		clone.nLivelloFolder		= this.nLivelloFolder;
		return clone;
	}
}
////////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaDCE;
/**
 * 
 * @author Marco Salonia
 * 
 */
class VoListaDCEImpl extends VoListaDCE
{
	private var listIterator:ArrayIterator;
	private var originalList:Array;
	public function VoListaDCEImpl(list:Array)
	{
		super();
		originalList = list;
		listIterator = new ArrayIterator(originalList);
	}
	override public function get iterator():IIterator
	{
		return listIterator;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var tempIterator:ArrayIterator = new ArrayIterator(originalList);
		while(tempIterator.hasNext())
		{
			var item:VoSetDocumentaleImpl 	= tempIterator.next() as VoSetDocumentaleImpl;
			var clone:VoSetDocumentaleImpl 	= item.clone() as VoSetDocumentaleImpl;
			temp.unshift(  clone );
		} 
		return new VoListaDCEImpl(temp);
	}
}
////////////////////////////////////////////////////////////////////////////

class VoListaDCE2009Impl extends VoListaDCE
{
	private var listIterator:ArrayIterator;
	private var originalList:Array;
	public function VoListaDCE2009Impl(list:Array)
	{
		super();
		originalList = list;
		listIterator = new ArrayIterator(originalList);
	}
	override public function get iterator():IIterator
	{
		return listIterator;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var tempIterator:ArrayIterator = new ArrayIterator(originalList);
		while(tempIterator.hasNext())
		{
			var item:VoSetDocumentale2009Impl 	= tempIterator.next() as VoSetDocumentale2009Impl;
			var clone:VoSetDocumentale2009Impl 	= item.clone() as VoSetDocumentale2009Impl;
			temp.unshift(  clone );
		} 
		return new VoListaDCE2009Impl(temp);
	}
}
////////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoSetDocumentale;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAutoreDocumento;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiSpecificiDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoDocumento;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaCreazione;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaAllegati;
/**
 * 
 * @author Marco Salonia
 * 
 */
class VoSetDocumentaleImpl extends VoSetDocumentale
{
	private var parserDce:IParserAttributiDCE;
	public function VoSetDocumentaleImpl(setDocumentale:XML,parserDce:IParserAttributiDCE)
	{
		super();
		this.parserDce = parserDce;
		parsing(setDocumentale);
	}
	private function parsing(setDocumentale:XML):void
	{
		if(setDocumentale.length()==0)return;
		//===================================================
		
		var atrSpcf:XMLList						= setDocumentale.child( "attributiSpecificiDCE" );
		if(atrSpcf!=null && atrSpcf.length()>0)
		{
			this.attributiSpecificiDCE			= getAttributiSpecificiDce(atrSpcf[0]);	
		}
		
		var autDoc:XMLList						= setDocumentale.child( "autoreDocumento" );
		if(autDoc!=null && autDoc.length()>0)
		{
			this.autoreDocumento				= new VoAutoreDocumentoImpl(autDoc[0]);
		} 
		
		var crtClnc:XMLList						= setDocumentale.child( "caratterizzazioniCliniche" );
		if(crtClnc!=null && crtClnc.length()>0)
		{
			this.caratterizzazioniCliniche		= getCaratterizzazioniCliniche(crtClnc[0]);
		}
		this.dataOraCreazione					= setDocumentale.child( "dataOraCreazione" );
		
		//===================================================
		var dscDscEr:String						= setDocumentale.child( "descrizioneDisciplinaErogazione" );
		if(dscDscEr!=null &&  dscDscEr.length>0)	
			this.descrizioneDisciplinaErogazione= dscDscEr;
		//===================================================
		
		var dscRtPt:String						= setDocumentale.child( "descrizioneReteDiPatologia" );
		if(dscRtPt!=null && dscRtPt.length>0)
			this.descrizioneReteDiPatologia		= dscRtPt;
		//===================================================
			
		this.descrizioneTipoDocumento			=  setDocumentale.child( "descrizioneTipoDocumento" );
		var listDoc:XMLList						=  setDocumentale.child( "listaDocumenti" );
		if(listDoc!=null && listDoc.length()>0)
		{
			createListDoc(listDoc);
		}
		
		this.idAggregazioneDocumento			= setDocumentale.child( "idAggregazioneDocumento" );
		//===================================================
		var idDisperog:String					= setDocumentale.child( "idDisciplinaErogazione" );
		if(idDisperog!=null && idDisperog.length>0)
			this.idDisciplinaErogazione			= idDisperog;
		//===================================================
		
		var idDocRif:String						= setDocumentale.child( "idDocumentoRiferimento" );
		if(idDocRif!=null && idDocRif.length>0)
			this.idDocumentoRiferimento			= idDocRif;
		//===================================================
		this.idTipoDocumento					= setDocumentale.child( "idTipoDocumento" );
		this.idTipoDocumentoLOINC				= setDocumentale.child( "idTipoDocumentoLOINC" );
		this.idSetDocumenti						= setDocumentale.child( "idSetDocumenti" );
		//===================================================
		
		this.listaAllegati						= getListaAllegati( setDocumentale.child( "listaAllegati" ) );
		//===================================================
		var ntrAgg:String						= setDocumentale.child( "naturaAggiornamento" );
		if(ntrAgg!=null && ntrAgg.length>0)
			this.naturaAggiornamento			= ntrAgg;
		//===================================================
		
		var ntRep:String						= setDocumentale.child( "noteReperibilita" );
		if(ntRep!=null && ntRep.length>0)
			this.noteReperibilita				= ntRep;
		//===================================================
		this.nVersione							= setDocumentale.child( "nVersione" );
		var nmVrdoc:String						= setDocumentale.child( "nVersioneDocumentoRiferimento" );
		if(nmVrdoc!=null && nmVrdoc.length>0)
			this.nVersioneDocumentoRiferimento	= nmVrdoc;
		//===================================================
		
		this.reteDiPatologia					= setDocumentale.child( "reteDiPatologia" );
		this.statoAutorizzazioneDocumento		= setDocumentale.child( "statoAutorizzazioneDocumento" );
		this.strutturaCreazione					= getStrutturaCreazione( setDocumentale.child( "strutturaCreazione" ) );
		
	}
	private function  getCaratterizzazioniCliniche(crtClnc:XML):VoCaratterizzazioniClinicheImpl
	{
		var temp:Array = new Array();
		var caratterizzazioni:XMLList	= crtClnc.child( "caratterizzazione" );
		if(caratterizzazioni!=null && caratterizzazioni.length()>0)
		{
			for(var i:uint = 0;i<caratterizzazioni.length();i++)
			{
				var car:XML = caratterizzazioni[i];
				var vocar:VoCaratterizzazioneImpl = new VoCaratterizzazioneImpl(car);
				temp.unshift( vocar );
			}
		}
		return new VoCaratterizzazioniClinicheImpl( temp );
	}
	
	
	private function getStrutturaCreazione( strutturaCreazione:XMLList = null):VoStrutturaCreazione
	{
		if(strutturaCreazione==null || strutturaCreazione.length()==0)return null;
		return new VoStrutturaCreazioneImpl(strutturaCreazione[0]);
	}
	private function getListaAllegati( listAllegati:XMLList = null):VoListaAllegati
	{
		if(listAllegati==null || listAllegati.length()==0)return null;
		var temp:Array = new Array();
		var allegati:XMLList =  listAllegati.child( "allegato" );
		if(allegati!=null && allegati.length()>0)
		{
			for(var i:uint = 0;i<allegati.length();i++)
			{
				var all:XML = allegati[i];
				var voAlle:VoAllegatoImpl = new VoAllegatoImpl( all );
				temp.unshift( voAlle );
			}
		}
		return new VoListaAllegatiImpl( temp );
	}
	private function createDoc( doc:XML = null):VoDocumento
	{
		if(doc==null)return null;
		return new VoDocumentoImpl( doc );
	}
	private function createListDoc(listDoc:XMLList):void
	{
		var docs:XMLList						= listDoc[0].child( "documento" );
		if(docs!=null && docs.length()>0)
		{
			this.documento_1					= createDoc( docs[0] );
			this.documento_2					= createDoc( docs[1] );
		}
	}
	private function getAttributiSpecificiDce(atrSpcf:XML):VoAttributiSpecificiDCE
	{
		return parserDce.getAttributi( atrSpcf );
	}
	//=======================================================
	override public function clone():ClonableValueObject
	{
		var clone:VoSetDocumentaleImpl  		= new VoSetDocumentaleImpl(new XML(),parserDce);
		if(this.attributiSpecificiDCE!=null)
			clone.attributiSpecificiDCE				= this.attributiSpecificiDCE.clone() as VoAttributiSpecificiDCE;
		clone.autoreDocumento					= this.autoreDocumento;
		if(this.caratterizzazioniCliniche!=null)
			clone.caratterizzazioniCliniche			= this.caratterizzazioniCliniche.clone() as VoCaratterizzazioniCliniche;
		clone.dataOraCreazione					= this.dataOraCreazione;
		clone.descrizioneDisciplinaErogazione	= this.descrizioneDisciplinaErogazione;	
		clone.descrizioneReteDiPatologia		= this.descrizioneReteDiPatologia;
		clone.descrizioneTipoDocumento			= this.descrizioneTipoDocumento;
		if(this.documento_1!=null)
			clone.documento_1						= this.documento_1.clone() as VoDocumento;
		if(this.documento_2!=null)
			clone.documento_2						= this.documento_2.clone() as VoDocumento;
		clone.idAggregazioneDocumento			= this.idAggregazioneDocumento;
		clone.idDisciplinaErogazione			= this.idDisciplinaErogazione;
		clone.idDocumentoRiferimento			= this.idDocumentoRiferimento;
		clone.idSetDocumenti					= this.idSetDocumenti;
		clone.idTipoDocumento					= this.idTipoDocumento;
		clone.idTipoDocumentoLOINC				= this.idTipoDocumentoLOINC;	
		if(this.listaAllegati!=null)
			clone.listaAllegati						= this.listaAllegati.clone() as VoListaAllegati;
		clone.naturaAggiornamento				= this.naturaAggiornamento;
		clone.noteReperibilita					= this.noteReperibilita;
		clone.nVersione							= this.nVersione;
		clone.nVersioneDocumentoRiferimento		= this.nVersioneDocumentoRiferimento;
		clone.reteDiPatologia					= this.reteDiPatologia;
		clone.statoAutorizzazioneDocumento		= this.statoAutorizzazioneDocumento;
		if(this.strutturaCreazione!=null)
			clone.strutturaCreazione				= this.strutturaCreazione.clone() as VoStrutturaCreazione;
			
		return clone;
	}
}
///////////////////////////////////////////////////////////////////
// S.C.
class VoSetDocumentale2009Impl extends VoSetDocumentale2009
{
	private var parserDce:IParserAttributiDCE;
	public function VoSetDocumentale2009Impl(setDocumentale:XML,parserDce:IParserAttributiDCE)
	{
		super();
		this.parserDce = parserDce;
		parsing(setDocumentale);
	}
	private function parsing(setDocumentale:XML):void
	{
		if(setDocumentale.length()==0)return;
		//===================================================
		
		var atrSpcf:XMLList						= setDocumentale.child( "attributiSpecificiDCE" );
		var asdce:String = atrSpcf.toString();
		if(atrSpcf!=null && atrSpcf.length()>0 && asdce.length > 0)
		{
			this.attributiSpecificiDCE			= getAttributiSpecificiDce(atrSpcf[0]);	
		}
		
		var autDoc:XMLList						= setDocumentale.child( "autoreDocumento" );
		if(autDoc!=null && autDoc.length()>0)
		{
			this.autoreDocumento				= new VoAutoreDocumentoImpl(autDoc[0]);
		} 
		
		var crtClnc:XMLList						= setDocumentale.child( "caratterizzazioniCliniche" );
		if(crtClnc!=null && crtClnc.length()>0)
		{
			this.caratterizzazioniCliniche		= getCaratterizzazioniCliniche(crtClnc[0]);
		}
		this.dataOraCreazione					= setDocumentale.child( "dataOraCreazione" );
		
		//===================================================
		var dscDscEr:String						= setDocumentale.child( "descrizioneDisciplinaErogazione" );
		if(dscDscEr!=null &&  dscDscEr.length>0)	
			this.descrizioneDisciplinaErogazione= dscDscEr;
		//===================================================
		
		var dscRtPt:String						= setDocumentale.child( "descrizioneReteDiPatologia" );
		if(dscRtPt!=null && dscRtPt.length>0)
			this.descrizioneReteDiPatologia		= dscRtPt;
		//===================================================
			
		this.descrizioneTipoDocumento			=  setDocumentale.child( "descrizioneTipoDocumento" );
		var listDoc:XMLList						=  setDocumentale.child( "listaDocumenti" );
		if(listDoc!=null && listDoc.length()>0)
		{
			createListDoc(listDoc);
		}
		
		this.idAggregazioneDocumento			= setDocumentale.child( "idAggregazioneDocumento" );
		//===================================================
		var idDisperog:String					= setDocumentale.child( "idDisciplinaErogazione" );
		if(idDisperog!=null && idDisperog.length>0)
			this.idDisciplinaErogazione			= idDisperog;
		//===================================================
		
		var idDocRif:String						= setDocumentale.child( "idDocumentoRiferimento" );
		if(idDocRif!=null && idDocRif.length>0)
			this.idDocumentoRiferimento			= idDocRif;
		//===================================================
		this.idTipoDocumento					= setDocumentale.child( "idTipoDocumento" );
		this.idTipoDocumentoLOINC				= setDocumentale.child( "idTipoDocumentoLOINC" );
		this.idSetDocumenti						= setDocumentale.child( "idSetDocumenti" );
		//===================================================
		//consultaFascicolo2008
		//this.listaAllegati						= getListaAllegati( setDocumentale.child( "listaAllegati" ) );
		//consultaFascicolo2009
		this.listaAllegati						= getListaAllegati2009( setDocumentale.child( "listaAllegati" ) );
		//===================================================
		var ntrAgg:String						= setDocumentale.child( "naturaAggiornamento" );
		if(ntrAgg!=null && ntrAgg.length>0)
			this.naturaAggiornamento			= ntrAgg;
		//===================================================
		
		var ntRep:String						= setDocumentale.child( "noteReperibilita" );
		if(ntRep!=null && ntRep.length>0)
			this.noteReperibilita				= ntRep;
		//===================================================
		this.nVersione							= setDocumentale.child( "nVersione" );
		var nmVrdoc:String						= setDocumentale.child( "nVersioneDocumentoRiferimento" );
		if(nmVrdoc!=null && nmVrdoc.length>0)
			this.nVersioneDocumentoRiferimento	= nmVrdoc;
		//===================================================
		
		this.reteDiPatologia					= setDocumentale.child( "reteDiPatologia" );
		this.statoAutorizzazioneDocumento		= setDocumentale.child( "statoAutorizzazioneDocumento" );
		this.strutturaCreazione					= getStrutturaCreazione( setDocumentale.child( "strutturaCreazione" ) );
		this.flagCopiato						= setDocumentale.child("flagCopiato");
		this.strutturaArchiviazione				= getStrutturaArchiviazione (setDocumentale.child("strutturaArchiviazione"))
		this.oscuramento						= getStrutturaOscuramento(setDocumentale.child("oscuramento")[0]);
		
	}
	private function getStrutturaArchiviazione(strArch:XMLList):VoStrutturaArchiviazione {
		var struttura:VoStrutturaArchiviazione 	= new VoStrutturaArchiviazione();
		struttura.idEnte 						= strArch[0].child("idEnte");
		struttura.descrizioneEnte 				= strArch[0].child("descrizioneEnte");
		return struttura	
	}
	private function getStrutturaOscuramento(oscur:XML):VoListaOscuramento {
		var temp:Array = new Array();
		var listaOsc:XMLList = oscur.child("tipoOscuramento");
		if (listaOsc != null && listaOsc.length() > 0) {
			for (var i:uint = 0; i < listaOsc.length(); i++) {
				var voOscuramento:VoOscuramento 	= new VoOscuramento();
				voOscuramento.idCausaleOscuramento 	= listaOsc[i].child("idCausaleOscuramento");
				voOscuramento.valoreOscuramento 	= listaOsc[i].child("valoreOscuramento");
				temp.unshift(voOscuramento);
			}
		}
		return new VoListaOscuramentoImpl(temp);
	}
	private function  getCaratterizzazioniCliniche(crtClnc:XML):VoCaratterizzazioniClinicheImpl
	{
		var temp:Array = new Array();
		var caratterizzazioni:XMLList	= crtClnc.child( "caratterizzazione" );
		if(caratterizzazioni!=null && caratterizzazioni.length()>0)
		{
			for(var i:uint = 0;i<caratterizzazioni.length();i++)
			{
				var car:XML = caratterizzazioni[i];
				var vocar:VoCaratterizzazioneImpl = new VoCaratterizzazioneImpl(car);
				temp.unshift( vocar );
			}
		}
		return new VoCaratterizzazioniClinicheImpl( temp );
	}
	
	
	private function getStrutturaCreazione( strutturaCreazione:XMLList = null):VoStrutturaCreazione
	{
		if(strutturaCreazione==null || strutturaCreazione.length()==0)return null;
		return new VoStrutturaCreazioneImpl(strutturaCreazione[0]);
	}
	private function getListaAllegati( listAllegati:XMLList = null):VoListaAllegati
	{
		if(listAllegati==null || listAllegati.length()==0)return null;
		var temp:Array = new Array();
		var allegati:XMLList =  listAllegati.child( "allegato" );
		if(allegati!=null && allegati.length()>0)
		{
			for(var i:uint = 0;i<allegati.length();i++)
			{
				var all:XML = allegati[i];
				var voAlle:VoAllegatoImpl = new VoAllegatoImpl( all );
				temp.unshift( voAlle );
			}
		}
		return new VoListaAllegatiImpl( temp );
	}
	private function getListaAllegati2009( listAllegati:XMLList = null):VoListaAllegati
	{
		if(listAllegati==null || listAllegati.length()==0)return null;
		var temp:Array = new Array();
		var allegati:XMLList =  listAllegati.child( "allegato" );
		if(allegati!=null && allegati.length()>0)
		{
			for(var i:uint = 0;i<allegati.length();i++)
			{
				var all:XML = allegati[i];
				var voAlle:VoAllegato2009Impl = new VoAllegato2009Impl( all );
				temp.unshift( voAlle );
			}
		}
		return new VoListaAllegatiImpl( temp );
	}
	private function createDoc( doc:XML = null):VoDocumento
	{
		if(doc==null)return null;
		return new VoDocumentoImpl( doc );
	}
	private function createListDoc(listDoc:XMLList):void
	{
		var docs:XMLList						= listDoc[0].child( "documento" );
		if(docs!=null && docs.length()>0)
		{
			this.documento_1					= createDoc( docs[0] );
			this.documento_2					= createDoc( docs[1] );
		}
	}
	private function getAttributiSpecificiDce(atrSpcf:XML):VoAttributiSpecificiDCE
	{
		return parserDce.getAttributi( atrSpcf );
	}
	//=======================================================
	override public function clone():ClonableValueObject
	{
		var clone:VoSetDocumentaleImpl  		= new VoSetDocumentaleImpl(new XML(),parserDce);
		if(this.attributiSpecificiDCE!=null)
			clone.attributiSpecificiDCE				= this.attributiSpecificiDCE.clone() as VoAttributiSpecificiDCE;
		clone.autoreDocumento					= this.autoreDocumento;
		if(this.caratterizzazioniCliniche!=null)
			clone.caratterizzazioniCliniche			= this.caratterizzazioniCliniche.clone() as VoCaratterizzazioniCliniche;
		clone.dataOraCreazione					= this.dataOraCreazione;
		clone.descrizioneDisciplinaErogazione	= this.descrizioneDisciplinaErogazione;	
		clone.descrizioneReteDiPatologia		= this.descrizioneReteDiPatologia;
		clone.descrizioneTipoDocumento			= this.descrizioneTipoDocumento;
		if(this.documento_1!=null)
			clone.documento_1						= this.documento_1.clone() as VoDocumento;
		if(this.documento_2!=null)
			clone.documento_2						= this.documento_2.clone() as VoDocumento;
		clone.idAggregazioneDocumento			= this.idAggregazioneDocumento;
		clone.idDisciplinaErogazione			= this.idDisciplinaErogazione;
		clone.idDocumentoRiferimento			= this.idDocumentoRiferimento;
		clone.idSetDocumenti					= this.idSetDocumenti;
		clone.idTipoDocumento					= this.idTipoDocumento;
		clone.idTipoDocumentoLOINC				= this.idTipoDocumentoLOINC;	
		if(this.listaAllegati!=null)
			clone.listaAllegati						= this.listaAllegati.clone() as VoListaAllegati;
		clone.naturaAggiornamento				= this.naturaAggiornamento;
		clone.noteReperibilita					= this.noteReperibilita;
		clone.nVersione							= this.nVersione;
		clone.nVersioneDocumentoRiferimento		= this.nVersioneDocumentoRiferimento;
		clone.reteDiPatologia					= this.reteDiPatologia;
		clone.statoAutorizzazioneDocumento		= this.statoAutorizzazioneDocumento;
		if(this.strutturaCreazione!=null)
			clone.strutturaCreazione				= this.strutturaCreazione.clone() as VoStrutturaCreazione;
			
		return clone;
	}
}
/////////////////////////////////////////////////////////////////////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoDocumento
class VoDocumentoImpl extends VoDocumento
{
		public function VoDocumentoImpl(doc:XML)
		{
			super();
			parsing(doc);
		}
		private function parsing(doc:XML):void
		{
			if(doc.length()==0)return;
			var alg:String			= doc.child( "algoritmoHash" );
			if(alg!=null && alg.length>0)
				this.algoritmoHash 		= alg; 
			this.firmato			= doc.child( "firmato" );
			this.formato			= doc.child( "formato" );
			this.hashDocumento		= doc.child( "hashDocumento" );
			var ling:String			= doc.child( "linguaggioDocumento" );
			if(ling!=null && ling.length>0)
				this.linguaggioDocumento = ling;
				
			var siz:String			= doc.child( "sizeDocumento" );
			if(siz!=null && siz.length>0)
				this.sizeDocumento = siz;
			// quando si decideranno switch con quello commentato	
			this.uri				= doc.child( "URI" );
			//this.uri				= doc.child( "uri" );
			var val:String			= doc.child( "validazioneSchema" );
			if(val!=null && val.length>0)
				this.validazioneSchema  = val;
		}
		override public function clone():ClonableValueObject
		{
			var clone:VoDocumentoImpl 	= new VoDocumentoImpl(new XML());
			clone.algoritmoHash 		= this.algoritmoHash; 
			clone.firmato				= this.firmato;
			clone.formato				= this.formato;
			clone.hashDocumento			= this.hashDocumento;
			clone.linguaggioDocumento 	= this.linguaggioDocumento; 
			clone.sizeDocumento 		= this.sizeDocumento; 
			clone.uri					= this.uri;	
			clone.validazioneSchema  	= this.validazioneSchema;	
			return clone; 
		}
}
////////////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAutoreDocumento
class VoAutoreDocumentoImpl extends VoAutoreDocumento
{
	public function VoAutoreDocumentoImpl(autore:XML)
	{
		super();
		parsing(autore);
	}
	private function parsing(autore:XML):void
	{
		if(autore==null || autore.length()==0)return;
		this.codiceFiscale			= autore.child( "codiceFiscale" );
		this.codiceFiscale			= this.codiceFiscale.toUpperCase();
		this.cognome				= autore.child( "cognome" );
		this.nome					= autore.child( "nome" );
		var rl:String				= autore.child( "ruolo" );
		if(rl!=null && rl.length>0)
			this.ruolo = rl;
		
		var autoriz:XMLList			= autore.child( "operatoreAutorizzante" );
		if(autoriz!=null && autoriz.length()>0)
			this.operatoreAutorizzante = new VoOperatoreAutorizzanteImpl(autoriz[0]);
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAutoreDocumentoImpl = new VoAutoreDocumentoImpl(new XML());
		clone.codiceFiscale				= this.codiceFiscale;
		clone.cognome					= this.cognome;
		clone.nome						= this.nome;
		if(this.operatoreAutorizzante!=null)
			clone.operatoreAutorizzante		= this.operatoreAutorizzante.clone() as VoOperatoreAutorizzante;	
		clone.ruolo						= this.ruolo;
		return clone;
	}
}
/////////////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoOperatoreAutorizzante;
class VoOperatoreAutorizzanteImpl extends VoOperatoreAutorizzante
{
	public function VoOperatoreAutorizzanteImpl(operatore:XML)
	{
		super();
		parsing(operatore);
	}
	private function parsing(operatore:XML):void
	{
		if(operatore==null || operatore.length()==0)return;
		this.codiceFiscaleAutorizzante = operatore.child( "codiceFiscaleAutorizzante" );
		this.cognomeAutorizzante	   = operatore.child( "cognomeAutorizzante" );
		this.nomeAutorizzante		   = operatore.child( "nomeAutorizzante" );	
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoOperatoreAutorizzanteImpl = new VoOperatoreAutorizzanteImpl(new XML());
		clone.codiceFiscaleAutorizzante	= this.codiceFiscaleAutorizzante;
		clone.cognomeAutorizzante		= this.cognomeAutorizzante;
		clone.nomeAutorizzante			= this.nomeAutorizzante;
		return clone;
	}
}
//////////////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCaratterizzazioniCliniche;
import it.lisit.siss.flex.utility.ArrayIterator;

class VoCaratterizzazioniClinicheImpl extends VoCaratterizzazioniCliniche
{
	private var list:ArrayIterator;
	private var original:Array;
	public function VoCaratterizzazioniClinicheImpl(caratterizzazioni:Array)
	{
		super();
		original = caratterizzazioni;
		list = new ArrayIterator( original ); 
	}
	override public function get iterator():IIterator
	{
		return list;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newIterator:ArrayIterator = new ArrayIterator( original ); 
		while(newIterator.hasNext())
		{
			var o:ClonableValueObject = newIterator.next() as ClonableValueObject;
			var clone:ClonableValueObject = o.clone();
			temp.unshift( clone );
		}
		return new VoCaratterizzazioniClinicheImpl( temp );
	}
}
//////////////////////
class VoListaOscuramentoImpl extends VoListaOscuramento
{
	private var list:ArrayIterator;
	private var original:Array;
	public function VoListaOscuramentoImpl(oscur:Array)
	{
		super();
		original = oscur;
		list = new ArrayIterator( original ); 
	}
	override public function get iterator():IIterator
	{
		return list;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newIterator:ArrayIterator = new ArrayIterator( original ); 
		while(newIterator.hasNext())
		{
			var o:ClonableValueObject = newIterator.next() as ClonableValueObject;
			var clone:ClonableValueObject = o.clone();
			temp.unshift( clone );
		}
		return new VoListaOscuramentoImpl( temp );
	}
}
/////////////////////////////////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCaratterizzazione;
class VoCaratterizzazioneImpl extends VoCaratterizzazione
{
	public function VoCaratterizzazioneImpl(cara:XML)
	{
		super();
		parsing(cara);
	}
	private function parsing(cara:XML):void
	{
		if(cara.length()==0)return;
		this.codice		= cara.child( "codice" );
		this.dizionario = cara.child( "dizionario" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoCaratterizzazioneImpl = new VoCaratterizzazioneImpl(new XML());
		clone.codice		= this.codice;
		clone.dizionario	= this.dizionario;
		return clone;	
	}
}
//////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaAllegati;
import it.lisit.siss.flex.utility.ArrayIterator;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAllegato;
class VoListaAllegatiImpl extends VoListaAllegati
{
	private var original:Array;
	private var lista:ArrayIterator;
	public function VoListaAllegatiImpl(list:Array)
	{
		super();
		original = list;
		lista = new ArrayIterator( original ); 
	}
	override public function get iterator():IIterator
	{
		return lista;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newIterator:ArrayIterator = new ArrayIterator( original );
		while(newIterator.hasNext()) 
		{
			var o:ClonableValueObject = newIterator.next() as ClonableValueObject;
			var clone:ClonableValueObject = o.clone();
			temp.unshift( clone );
		}
		return new VoListaAllegatiImpl( temp );
	}
}
////////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAllegato;
class VoAllegatoImpl extends VoAllegato
{
	public function VoAllegatoImpl(all:XML)
	{
		super();
		parsing(all);
	}
	private function parsing(all:XML):void
	{
		if(all.length()==0)return;
		this.formatoAllegato = all.child( "formatoAllegato" );
		this.linkAllegato	 = all.child( "linkAllegato" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAllegatoImpl = new VoAllegatoImpl(new XML());
		clone.linkAllegato		 = this.linkAllegato;
		clone.formatoAllegato	 = this.formatoAllegato;
		return clone;
	}
}	
///////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoAllegato2009;
class VoAllegato2009Impl extends VoAllegato2009
{
	public function VoAllegato2009Impl(all:XML)
	{
		super();
		parsing(all);
	}
	private function parsing(all:XML):void
	{
		if(all.length()==0)return;
		this.formatoAllegato 	= all.child( "formatoAllegato" );
		this.linkAllegato	 	= all.child( "linkAllegato" );
		this.etichettaAllegato	= all.child( "etichettaAllegato" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAllegato2009Impl 	= new VoAllegato2009Impl(new XML());
		clone.linkAllegato		 		= this.linkAllegato;
		clone.formatoAllegato	 		= this.formatoAllegato;
		clone.etichettaAllegato			= this.etichettaAllegato;
		return clone;
	}
}	
////////////////////////////
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaCreazione;
import it.lisit.siss.flex.communication.impl.soap.fse.IParserAttributiFolder;
import it.lisit.siss.flex.communication.impl.soap.fse.IParserAttributiDCE;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoSetDocumentale2009;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoAllegato2009;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoStrutturaArchiviazione;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoOscuramento;
import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoListaOscuramento;
class VoStrutturaCreazioneImpl extends VoStrutturaCreazione
{
	public function VoStrutturaCreazioneImpl(strut:XML)
	{
		super();
		parsing(strut);
	}
	private function parsing(strut:XML):void
	{
		if(strut.length()==0)return;
		this.descrizioneEnte					= strut.child( "descrizioneEnte" );
		this.descrizionePresidio				= strut.child( "descrizionePresidio" );
		this.descrizioneUnitaOperativaClinica	= strut.child( "descrizioneUnitaOperativaClinica" );
		this.idEnte								= strut.child( "idEnte" );
		this.idPresidio							= strut.child( "idPresidio" );
		this.idUnitaOperativaClinica			= strut.child( "idUnitaOperativaClinica" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoStrutturaCreazioneImpl 		= new VoStrutturaCreazioneImpl(new XML());
		clone.descrizioneEnte					= this.descrizioneEnte;
		clone.descrizionePresidio				= this.descrizionePresidio;
		clone.descrizioneUnitaOperativaClinica	= this.descrizioneUnitaOperativaClinica;
		clone.idEnte							= this.idEnte;
		clone.idPresidio						= this.idPresidio;
		clone.idUnitaOperativaClinica			= this.idUnitaOperativaClinica;
		return clone;
	}
}