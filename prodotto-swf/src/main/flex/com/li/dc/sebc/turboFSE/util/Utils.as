package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.model.vo.ConstAttributiFolder;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.model.vo.TreeEventi;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.middleground.entity.Ambulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderPDT;
	import it.lispa.siss.sebc.middleground.entity.AttributiReferto;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.ConstTipiAttributiDCE;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.Medico;
	import it.lispa.siss.sebc.middleground.entity.Oscuramento;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	import it.lispa.siss.sebc.middleground.entity.Prestazione;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.collections.ArrayCollection;
	
	public class Utils
	{
		private static function updateFolder(result:FolderTree,folder:FolderTree):void
		{
			result.attributiSpecificiFolder	= folder.attributiSpecificiFolder;
			result.children					= folder.children;
			result.complete					= folder.complete;
			result.listaDCE					= folder.listaDCE;
			result.listDataAgregazione		= folder.listDataAgregazione;
		}
		public static function filtraFlussi(tree:TreeEventi, startDate:Date,endDate:Date):TreeEventi
		{
			var newTree:TreeEventi 		= new TreeEventi();
			var lista:ArrayCollection	= new ArrayCollection()
			var iter:IIterator			= new ArrayCollectionIterator(tree.listaEventi);
			while(iter.hasNext())
			{
				/* primo livello */ 
				var evento:EventoTree 	= iter.next() as EventoTree;
				var children:IIterator	= new ArrayCollectionIterator( evento.children );
				var newChildren:ArrayCollection	= new ArrayCollection();
				while(children.hasNext())
				{
					var child:EventoTree 	= children.next() as EventoTree;
					if(child.dataErogazioneEvento!=null && child.dataErogazioneEvento.length>0)
					{
						var dataEvento:Date = UtilDate.fromStringToDate( child.dataErogazioneEvento );
						var startOk:Boolean	= UtilDate.isMajor(dataEvento,startDate) || UtilDate.isEquals(dataEvento, startDate);
						var endOk:Boolean	= UtilDate.isMajor(endDate,dataEvento) || UtilDate.isEquals(dataEvento, endDate);
						if(startOk && endOk)
						{
							newChildren.addItem( child );		
						}
					}
				}
				evento.children = newChildren;
				lista.addItem( evento );
			} 
			newTree.cittadino	= tree.cittadino;
			newTree.listaEventi = lista;
			return newTree;
		}
		public static function update(folder:FolderTree,listaFolder:ArrayCollection):FolderTree
		{
			if(folder!=null && folder.folder!=null && folder.folder.codice!=null)
			{
				var id:String			= folder.folder.codice;
				var result:FolderTree 	= recursiveFindFolderID(listaFolder.toArray(),id);
				if(result!=null)
				{
					updateFolder(result,folder);
					return result;
				}
			}
			return null;
		}
		
		/*
		 	Era usato solo in LoadContenFolderCommand sostituisce in quell'arraycollection l'ogetto
		 */		
		
		public static function substitute(folder:FolderTree,listaFolder:ArrayCollection):void
		{
		 
			var idFolder:String	= folder.folder.codice;
			for(var i:uint = 0;i<listaFolder.length;i++)
			{
				var fld:FolderTree 	= listaFolder.getItemAt( i ) as FolderTree;
				var id:String		= fld.folder.codice;
				if(id==idFolder)
				{
					 listaFolder.setItemAt(folder,i);
					 return;
				}else if(fld.children!=null && fld.children.length>0)
				{
					substitute(folder,fld.children);
				}
			}
			 
		}
		
		/* 	Lo aggiunge al padre tramite l'idPadre o l'idTipoPadre 
			Metodo usato solo in RefreshOpenFolderPDTCommand che lavora con la lista originale
		*/
		 
		 public static function addFolder(folder:FolderTree,list:ArrayCollection):void
		 {
		 	var idTipoPadre:String	= folder.idTipoFolderPadre;
		 	if(idTipoPadre==null || idTipoPadre.length==0)
		 	{
		 		list.addItem( folder );
		 	}else
		 	{
		 		var iter:IIterator	= new ArrayCollectionIterator( list );
		 		while(iter.hasNext()) 
		 		{
		 			var fld:FolderTree = iter.next() as FolderTree;
		 			/* è suo  padre */
		 			if(fld.idTipoFolder==idTipoPadre)
		 			{
		 				if(fld.children==null)
		 				{
		 					fld.children = new ArrayCollection();
		 				}
		 				fld.children.addItem( folder );
		 				break;
		 			}else if(fld.children!=null && fld.children.length>0)
		 			{
		 				addFolder(folder,fld.children);
		 			}
		 		}
		 	}
		 }
		 
		 
		  
		 private static function recursiveFindFolder(list:Array,idTipo:String):FolderTree
		 {
		 	if(idTipo==null || idTipo.length==0)return null;
		 	var iter:IIterator = new ArrayIterator(list);
		 	while(iter.hasNext())
		 	{
		 		var folder:FolderTree = iter.next() as FolderTree;
		 		if(folder.idTipoFolder == idTipo)
		 		{
		 			return folder;
		 		}else if(folder.children!=null && folder.children.length>0)
		 		{
		 			var temp:FolderTree = recursiveFindFolder(folder.children.toArray(),idTipo);
		 			if(temp!=null)
		 			{
		 				return temp;
		 			}
		 		}
		 	}
		 	return null;
		 }
		 private static function recursiveFindFolderID(list:Array,id:String):FolderTree
		 {
		 	if(id==null || id.length==0)return null;
		 	var iter:IIterator = new ArrayIterator(list);
		 	while(iter.hasNext())
		 	{
		 		var folder:FolderTree = iter.next() as FolderTree;
		 		if(folder.folder!=null &&  folder.folder.codice == id)
		 		{
		 			return folder;
		 		}else if(folder.children!=null && folder.children.length>0)
		 		{
		 			var temp:FolderTree = recursiveFindFolderID(folder.children.toArray(),id);
		 			if(temp!=null)
		 			{
		 				return temp;
		 			}
		 		}
		 	}
		 	return null;
		 }
		 public static function getNavString(list:Array):String
		 {
		 	const SEP:String 	= "> ";
		 	var str:String		= "";
		 	var iter:IIterator	= new ArrayIterator(list); 
		 	while(iter.hasNext())
		 	{
		 		var fld:FolderTree = iter.next() as FolderTree;
		 		str += fld.label + (iter.hasNext() ? SEP : "");
		 	}
		 	return str;
		 }
		 public static function getNavigationLabel(folder:FolderTree,list:Array = null):String
		 {
		 	var temp:Array	= new Array();
		 	temp.push( folder );
		 	if(list!=null)
		 		findListParents(folder,list,temp);
		 	return getNavString( temp.reverse() );
		 }
		 /**
		  * Cerca il folder recursivamente attraverso l'idTipo 
		  * @param idTipo
		  * @param listaFolder
		  * @return 
		  * 
		  */		 
		 public static function getFolderFromIdTipo(idTipo:String, listaFolder:ArrayCollection):FolderTree
		 {
		 	return recursiveFindFolder(listaFolder.toArray() , idTipo);
		 }
		 private static function findListParents(folder:FolderTree,list:Array,temp:Array):void
		 {
		 	var fld:FolderTree = getFolderFromId(folder.idFolderPadre,list);
		 	if(fld!=null)
		 	{
		 		temp.push( fld );
		 		if(fld.idFolderPadre!=null && fld.idFolderPadre.length>0)
			 	{
			 		findListParents(fld,list,temp);
			 	}
		 	} 
		 }
		 public static function getFolderFromId(id:String, listaFolder:Array):FolderTree
		 {
		 	return recursiveFindFolderID( listaFolder  , id);
		 }
		 public static function getListOpenPDT(listFolder:ArrayCollection/* di floderTree */):Array
		 {
		 	var result:Array		= new Array();
		 	var folderPdt:FolderTree = getFolderFromIdTipo("50",listFolder);
		 	if(folderPdt !=null && folderPdt.children!=null && folderPdt.children.length>0)
		 	{
				var iter:IIterator	= new ArrayCollectionIterator( folderPdt.children );
				while(iter.hasNext())
				{
					var f:FolderTree = iter.next() as FolderTree;
					if(f.attributiSpecificiFolder!=null && f.attributiSpecificiFolder.tipo==ConstAttributiSpecificiFolder.ATTRIBUTI_PDT)
					{
						var a:AttributiFolderPDT = f.attributiSpecificiFolder as AttributiFolderPDT;
						var hasApertura:Boolean = (a.datiPDT!=null && a.datiPDT.dataApertura!=null && a.datiPDT.dataApertura.length>0);
						var hasChiusura:Boolean = (a.datiPDT!=null && a.datiPDT.dataChiusura!=null && a.datiPDT.dataChiusura.length>0);
						if(hasApertura && !hasChiusura)
						{
							result.push( a.datiPDT.clone() ) ;
						}
					}
				}	 		
		 	}
		 	return result;
		 }
		 
		 public static function mergeListPdt(pdtDaChiudere:Array ,listPDTConf:Array ):Array
		 {
		 	var temp:Array = new Array();
		  	var iterConf:IIterator = new ArrayIterator(listPDTConf);
		  	var iterTree:IIterator = new ArrayIterator(pdtDaChiudere);
		  	while(iterConf.hasNext())
		  	{
		  		var pdtConf:PercorsoDiagnosticoTerapeutico = iterConf.next() as PercorsoDiagnosticoTerapeutico;
		  		iterTree.reset();
		  		var flag:Boolean = false;
		  		while(iterTree.hasNext())
		  		{
		  			var pdtTree:PercorsoDiagnosticoTerapeutico = iterTree.next() as PercorsoDiagnosticoTerapeutico;
		  			if(pdtConf.PDT != null && pdtTree.PDT!=null)
		  			{
		  				if(pdtTree.PDT.codice == pdtConf.PDT.codice)
		  				{
		  					flag = true;
		  					break; 
		  				}
		  			}	 
		  		}
		  		/*Non è nella lista dei pdt da chiudere  */
		  		if(!flag)
		  		{
		  			temp.push(pdtConf);
		  		}
		  	}
		 	return temp;
		 }
		 /**
		  * metodo Obsoleto, era usato in FilterDataTreeCommand e in UpdateFolderCommand  
		  * crea una nuova collezione escludendo i folder con la proprietà visible a false
		  * @param listFolder
		  * @return 
		  * 
		  */		 
		 public static function clearListFolderVisible(listFolder:ArrayCollection/* di floderTree */):ArrayCollection
		 {
		 	var result:ArrayCollection 	= new ArrayCollection();
		 	var iter:IIterator 			= new ArrayCollectionIterator( listFolder );
		 	while(iter.hasNext())
		 	{
		 		var folder:FolderTree = iter.next() as FolderTree;
		 		if(folder.visible)
		 		{
		 			if(folder.children!=null && folder.children.length>0)
		 			{
		 				folder.children = clearListFolderVisible(folder.children);
		 			}
		 			result.addItem( folder );
		 		}
		 		folder.visible = true;
		 	}
		 	return result;
		 }
		 /////////////////////////////////////////////////////
		 public static function getOrdinaAgregazioni(listDce:ArrayCollection):Array/*  di array di SetDocumentale */
		 {
		 	var controlloDCE:Dictionary	= new Dictionary();
		 	var controlloAGR:Dictionary	= new Dictionary();
		 	var resultTemp:Array		= new Array();
		 	var iter:IIterator 			= new ArrayCollectionIterator( listDce );
		 	while(iter.hasNext())
		 	{
		 		var setDoc:SetDocumentale 	= iter.next() as SetDocumentale;
		 		var idSetDoc:String			= setDoc.idSetDocumenti;
		 		var idAgereg:String			= setDoc.idAggregazioneDocumento;
		 		if(idSetDoc!=null && idSetDoc.length>0)
		 		{
		 			if(idAgereg==null || idAgereg.length==0)
			 		{
			 			idAgereg = idSetDoc;
			 		}
			 		/* dce non ancora catturato */
			 		if(controlloDCE[idSetDoc]==null)
			 		{
			 			if(controlloAGR[idAgereg]==null)
			 			{
			 				controlloAGR[idAgereg] = new Array();
			 				resultTemp.push( controlloAGR[idAgereg] );
			 			}
			 			controlloDCE[idSetDoc] = setDoc;
			 			(controlloAGR[idAgereg] as Array).push( setDoc );
			 		}
		 		}
		 	}
		 	var iterSort:IIterator 	= new ArrayIterator(resultTemp);
		 	var result:Array		= new Array();
		 	while(iterSort.hasNext())
		 	{
		 		var arr:Array = iterSort.next() as Array;
		 		result.push( arr.sort( sortRow ) );
		 	}
		 	return result.sort( sortColumn );
		 }
		 private static function sortRow(a:SetDocumentale,b:SetDocumentale):int
		 {	
		 	var dataA:Date 	= UtilDate.fromStringToDate( a.dataOraCreazione );
			var dataB:Date 	= UtilDate.fromStringToDate( b.dataOraCreazione );
			if(dataA!=null && dataB != null)
			{
				var majorA:Boolean = UtilDate.isMajor( dataA, dataB );
				var majorB:Boolean = UtilDate.isMajor( dataB,dataA );
				if( majorA && !majorB)
				{
					return 1;
				}else if( majorA == majorB )
				{
					return 0;
				}else if( !majorA && majorB)
				{
					return -1;
				}
			}
			return 0;
		 }
		 private static function sortColumn(a:Array,b:Array):int
		 {
		 	if(a!=null && b!=null && a.length>0 && b.length>0)
			{
				var ad:SetDocumentale 	= a[0];
				var bd:SetDocumentale 	= b[0];
				var res:int 			= sortRow(ad,bd); 
				return res*-1;
			}
			return 0;
		 
		 }
		 /////////////////
		 /* Label di descrizione dei dce */
		public static function getPrestazioni(vo:SetDocumentale):String
		{
			if(vo != null && vo.attributiSpecificiDCE!=null)
			{
				var type:int = vo.attributiSpecificiDCE.tipo;
				switch(type)
				{
					case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009:
					case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO:
					if(vo.attributiSpecificiDCE is AttributiReferto)
					{
						var prestazioni:Array = null;
						var ambulatoriale:Ambulatoriale	= (vo.attributiSpecificiDCE as AttributiReferto).ambulatoriale;
						if(ambulatoriale!=null && ambulatoriale.prestazioniAssociate!=null)
						{
							prestazioni = ambulatoriale.prestazioniAssociate.toArray();
						} 
						var outPut:String = "\n[";
						var virgola:String = "\n";
						var len:int = prestazioni.length;
						for(var i:uint = 0;i<len;i++)
						{
							var prest:Prestazione = prestazioni[i];
							if(i==len-1)
							{
								virgola = "";
							}
							if(prest.descrizione !=null)
							{
								outPut +=  prest.descrizione + virgola;
							}
						}
						outPut += "]";
						return outPut;
					}
				}
			}
			return "";
		
		}
		public static function getLabelButtonDocEntry(vo:SetDocumentale):String
		{
			if(vo==null) 				return "";
			
			var outPut:String 			= "";
			var sep:String 				= ", ";
			var tipoDoc:DatoCodificato	= vo.tipoDocumento;
			var descTipoDoc:String 		= (tipoDoc!=null && tipoDoc.descrizione!=null && tipoDoc.descrizione.length>0) ? tipoDoc.descrizione : ""; 	
			var data:String 			= (vo.dataOraCreazione!=null &&  vo.dataOraCreazione.length>0) ? UtilDate.getStringData(vo.dataOraCreazione) : "";
			 
			var descStruttura:String	= "";
			var presFlag:Boolean		= false;
			var descPresidio:String 	= "";
			var descRete:String			= ""; 
			var retFlag:Boolean			= false;
			
			if(tipoDoc != null && tipoDoc.codice!=null && tipoDoc.codice == ConstAttributiFolder.DCE_PATTIENT_SUMMARY && vo.autoreDocumento!=null)
			{
				var medico:Medico		= vo.autoreDocumento;
				descStruttura 			= "Autore : Dott. " + medico.cognome + " " +medico.nome;
			}else
			{ 
				if(vo.strutturaCreazione!=null 
				&& vo.strutturaCreazione.ente!=null 
				&& vo.strutturaCreazione.ente.descrizione!=null 
				&& vo.strutturaCreazione.ente.descrizione.length>0)
				{
					descStruttura = vo.strutturaCreazione.ente.descrizione;
					if(vo.strutturaCreazione.ente.codice!=null && vo.strutturaCreazione.ente.codice.length>0)
					{
						descStruttura 	+= " (" + vo.strutturaCreazione.ente.codice +")";
					}
				}
				descPresidio 			= (vo.strutturaCreazione !=null && vo.strutturaCreazione.primoPresidio !=null && vo.strutturaCreazione.primoPresidio.descrizione!=null) ?  vo.strutturaCreazione.primoPresidio.descrizione : "";
				descRete				= (vo.reteDiPatologia 	 !=null && vo.reteDiPatologia.descrizione!=null &&  vo.reteDiPatologia.descrizione.length>0) ? vo.reteDiPatologia.descrizione : "";
			}
			outPut 	= (descTipoDoc.length>0)? (descTipoDoc + ((data.length>0)? sep :"")) : "";
			outPut 	+= data + ((descStruttura.length>0)? sep :"");
			
			if(tipoDoc != null && tipoDoc.codice!=null && tipoDoc.codice == Costanti.TIPO_DOC_TACUINO ){
				outPut 	+= " Documenti Cittadino";
			}
			
			outPut 	+= descStruttura + ((descPresidio.length>0)? sep :"");
			outPut 	+= descPresidio + ((descRete.length>0)? sep :"");
			outPut 	+=descRete;
			return outPut;	
		}
		public static function isOscurato(listaOscurato:ArrayCollection):Boolean
		{
			if (listaOscurato != null) 
			{
				for (var i:uint = 0; i < listaOscurato.length; i++) 
				{
					if ((listaOscurato[i] as Oscuramento).idCausaleOscuramento == "50") 
					{
						if ((listaOscurato[i] as Oscuramento).valoreOscuramento.toUpperCase() == "SI") 
						{
							return true;
						}
					}
				}
			}
			return false;
		}
		
		public static function hasCodice(datoCod:DatoCodificato):Boolean
		{
			return (datoCod!=null && datoCod.codice!=null && datoCod.codice.length>0);
		}
		public static function hasDescrizione(datoCod:DatoCodificato):Boolean
		{
			return (datoCod!=null && datoCod.descrizione!=null && datoCod.descrizione.length>0);
		}
		public static function getDescrizione(datoCod:DatoCodificato):String
		{
			if(hasDescrizione(datoCod))
			{
				return datoCod.descrizione;
			}
			return "";
		}
		public static function getStringValue(value:String = null):String
		{
			if(value != null && value.length>0)
			{
				return value;
			}
			return ""; 
		}
		public static function getCodice(datoCod:DatoCodificato):String
		{
			if(hasCodice(datoCod))
			{
				return datoCod.codice;
			}
			return "";
		}
		
		public static function getDescrAndCod(datoCod:DatoCodificato):String
		{
			var cod:String	= getCodice( datoCod );
			var desc:String	= getDescrizione( datoCod );
			var codDiaExt:String = (cod.length>0) ? " ( "+cod+" )": ""; 	
			return desc + codDiaExt;
		}
		public static function createLabelFiltri(dtIni:String,dtEnd:String):String
		{
			var strini:String	= UtilDate.getStringData( dtIni );
			var strend:String	= UtilDate.getStringData( dtEnd );
			return "Eventi dalla data  : "+strini+" alla data : "+strend+". Puoi visualizzarne altri modificando l'intervallo date, mediante i 'filtri data'";
		}
		
		public static function getLabelFormato(frt:String):String
		{
			var out:String = frt.toUpperCase();
			switch(frt.toUpperCase())
			{
				case "PDF":  
					out = "PDF";
					break;
				case "TXT": 
					out = "TESTUALE";
					break;
				case "JPEG": 
					out = "IMMAGINE";
					break;
				case "CDA2": 
					out = "STRUTTURATO";
					break;
				case "TXTGEN": 
					out = "TXTGEN";
					break;
			}
			return out;
		}
		public static function getNaturaDoc(natura:String):String
		{
			var out:String = natura;
			if(out==null)return "";
			switch(natura.toUpperCase())
			{
				case "STD":
					//out = "STANDARD";
					/* se la natura è standard non deve vedersi nessun valore */
					out = "";
					break;
				case "XTND":
					out = "INTEGRATIVO";
					break;
				case "RPLC":
					out = "SOSTITUTIVO";
					break;
				case "CANCEL":
					out = "ANNULLATIVO";
					break;
				default:
				out = "";	
			}
			return out;
		}
		public static function isNotAutorizzato(vo:SetDocumentale):Boolean
		{
			if(vo.statoAutorizzazioneDocumento!=null && vo.statoAutorizzazioneDocumento.length>0 && vo.statoAutorizzazioneDocumento.toUpperCase() == "NO")
			{
				return true;
			}
			return false;
		}
	}
}