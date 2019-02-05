package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	import com.li.dc.sebc.turboFSE.view.viste.VistaDisciplina;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.ProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.collections.ArrayCollection;
	
	public class DisciplinaBuilder extends OpenableBuilder
	{
		private var lastData:Object;
		private var lastLength:int;
		public function DisciplinaBuilder()
		{
			super();
		}
		private function getNameFromAttributi(folder:FolderTree):String
		{
			var attributi:AttributiSpecificiFolder =  folder.attributiSpecificiFolder;
			if(attributi!=null && attributi.tipo>=0)
			{
				var tipo:int = attributi.tipo;
				if(tipo==ConstAttributiSpecificiFolder.ATTRIBUTI_PS)
				{
					var ps:ProntoSoccorso = (attributi as AttributiFolderProntoSoccorso).datiProntoSoccorso;
					//ps.datiAccettazione.disciplina
					if(ps!=null && ps.datiAccettazione!=null && ps.datiAccettazione.disciplina!=null)
					{
						var dc:DatoCodificato = ps.datiAccettazione.disciplina;
						if(dc.descrizione!=null && dc.descrizione.length>0)
						{
							return dc.descrizione;
						}
					}
				}
			}
			return null;
		}
		
		/*private function recursiveExtractDiscipline(discipline:Dictionary,list:Array):void
		{
			var iter:IIterator	= new ArrayIterator( list );
			while(iter.hasNext())
			{
				var folder:FolderTree = iter.next() as FolderTree;
				if(folder.children!=null && folder.children.length>0)
				{
					recursiveExtractDiscipline(discipline,folder.children.toArray());
				} 
				if(folder.listaDCE !=null && folder.listaDCE.length>0)
				{
					var dc:DatoCodificato	= folder.folder;
					if(dc!=null && dc.codice!=null && dc.codice.length>0)
					{
						var codice:String			= dc.codice;
						var nameDisciplina:String 	= getNameFromAttributi( folder );
						if(nameDisciplina!=null && nameDisciplina.length>0)
						{
						 	nameDisciplina = nameDisciplina.toUpperCase();	
						 	if(discipline[nameDisciplina]==null)
							{
								discipline[nameDisciplina] = new Dictionary();
							}
						 	discipline[nameDisciplina][codice] = folder;
						}else
						{
						 	var iterDCE:IIterator	= new ArrayIterator(folder.listaDCE.toArray());
							while(iterDCE.hasNext())
							{
								var doc:SetDocumentale		= iterDCE.next() as SetDocumentale;
								var sdc:DatoCodificato		= doc.disciplinaErogazione;
								if(sdc !=null && sdc.descrizione != null && sdc.descrizione.length>0)
								{
									nameDisciplina = sdc.descrizione.toUpperCase();	
									if(discipline[nameDisciplina]==null)
									{
										discipline[nameDisciplina] = new Dictionary();
									}
								 	discipline[nameDisciplina][codice] = folder;
								}  
							}
						}	
					}
				}
			}	
		}*/
		
		private function recursiveExtractDiscipline(discipline:Dictionary,list:Array):void
		{
			var iter:IIterator	= new ArrayIterator( list );
			while(iter.hasNext())
			{
				var folder:FolderTree = iter.next() as FolderTree;
				if(folder.children!=null && folder.children.length>0)
				{
					recursiveExtractDiscipline(discipline,folder.children.toArray());
				} 
				
				if(folder.listaDCE !=null && folder.listaDCE.length>0)
				{
					var dc:DatoCodificato	= folder.folder;
					
					if(dc!=null && dc.codice!=null && dc.codice.length>0){
						var codice:String			= dc.codice;
						
						var iterDCE:IIterator	= new ArrayIterator(folder.listaDCE.toArray());
						while(iterDCE.hasNext()){
							var doc:SetDocumentale		= iterDCE.next() as SetDocumentale;
							var docId:String = doc.idSetDocumenti;
							var sdc:DatoCodificato		= doc.disciplinaErogazione;
							
							if(sdc !=null && sdc.descrizione != null && sdc.descrizione.length>0){
								var nameDisciplina:String = sdc.descrizione.toUpperCase();	
								if(discipline[nameDisciplina]==null)
								{
									discipline[nameDisciplina] = new Dictionary();
								}
								discipline[nameDisciplina][docId] = doc;
							}
						}
					}	
				}
			}
		}
		
		private function getOrdine(dict:Dictionary):Array 
		{
			var temp:Array = new Array();
			for(var s:String in dict)
			{
				temp.push(s);
			}
			temp = temp.sort(Array.DESCENDING);
			return temp.reverse();
		}
		
		private function getListDCE(listDce:Dictionary):Array
		{
			var t:Array = new Array();
			
			for (var k:String in listDce) {
				var value:SetDocumentale = listDce[k];
				
				t.push(value);
			}
			
			return t;
		}
		
		
		
		/*private function getListDCE(listFolder:Dictionary):Array
		{
			var t:Array = new Array();
			for(var s:Object in listFolder)
			{
				var f:FolderTree = listFolder[s];
				if(f.listaDCE!=null && f.listaDCE.length>0) 
				{
					t = t.concat( f.listaDCE.toArray() );
				}
			}
			return t;
		} */
		/* 
		 * è la prima function chiamata e serve per generare un chiave per conservare la vista generata corrispondente
		 * la variabile currentData contiene l'oggetto di dati passato dal DirectorViste, il quale è un oggetto, in questo caso,
		 * contenente poche informazioni e non corrispondente ai veri dati che servono a generare la vista, quindi il legame chiave vista
		 * risulta non più veritiero. Bisogna quindi settare il valore di currentData al vero stato dei dati poi utilizzati 
		*/
		override protected function getKey():Object
		{ 
			return createCurrentData();
		}
		/* solo con questa istanza di array (currentData) ho questa vista */
		private function createCurrentData():Object
		{
			var dataTree:Object			= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TREE).getData();
			if(dataTree!=null)
			{
				var list:ArrayCollection 	= ( dataTree as Tree).listaFolder;
				
				Debug.logDebug("DISCIPLINA BUILDER createCurrentData currentData "+currentData );
				Debug.logDebug("DISCIPLINA BUILDER createCurrentData (lastData != list) "+(lastData != list));
				Debug.logDebug("DISCIPLINA BUILDER createCurrentData (list.length!=lastLength) "+( list.length!=lastLength) );
				
				/* list inteso come istanza potrebbe essere uguale ad lastData ma avere meno o più item e quindi diverso*/
				if(lastData != list || list.length!=lastLength)
				{
					lastLength 	= list.length;
					lastData 	= list;
					/* mi assicuro che sia una nuova istanza di array */
					currentData = intTransformData(list.toArray());
				}
				return currentData;
			}
			return null;
		} 
		public override function setParam(obj:Object):void
		{
			if(currentData==null)
			{
				currentData = obj;
			}
		}
		
		private function intTransformData(list:Array):Object
		{
			var result:Dictionary		= new Dictionary();
			var discipline:Dictionary	= new Dictionary();
			/*  estraggo da currentData le discipline*/
			recursiveExtractDiscipline( discipline, list);
			var iterName:IIterator		= new ArrayIterator( getOrdine( discipline ) );
			while(iterName.hasNext())
			{
				var name:String 		= iterName.next() as String;
				
				result[name]			= getListDataAgregazione( Utils.getOrdinaAgregazioni( new ArrayCollection( getListDCE( discipline[name] ) ) ) );
			}
			return result;
		}
		override protected function transformData(obj:Object):Object
		{
			/*  il currentData ritornato è quello creato con la chiamata getKey() */
			return currentData;
		}
		override protected function getVista():Vista
		{
			return new VistaDisciplina();
		}
		 
		override protected function createMediator( v:Vista ):void
		{
			Debug.logDebug("DISCIPLINA BUILDER createMediator vista : "+ (v!=null) );
			/* è una nuova vista */
			if( v !=null && !containsKey( v ) )
			{
				Debug.logDebug("DISCIPLINA BUILDER createMediator vista : "+v.name );
				var nameMediator:String	= v.name;
				var m:Mediator;
				try{
					m	= TurboView.getInstance().retriveMediator( nameMediator );
					/*  vuol dire che con questo nome era già registrato un altro mediator */
					if(m!=null)
					{
						TurboView.getInstance().destroyMediator( nameMediator );
					}
				}catch(e:Error){}
				TurboView.getInstance().createMediator(ConstMediator.DISCIPLINA_VISTA, nameMediator , v as VistaDisciplina);
				m = TurboView.getInstance().retriveMediator( nameMediator );
				putMediator( v , m );
			} 
		}
	}
}