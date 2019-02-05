package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.Utils;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.middleground.entity.Ambulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderAmbulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderRicovero;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.DatoSanitario;
	import it.lispa.siss.sebc.middleground.entity.ProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.Ricovero;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.collections.ArrayCollection;
	/**
	 * Aggiorno la lista dei visibili e creo le liste dei filtri 
	 * chiamato quando si carica un nuovo tree
	 * @author Marco Salonia
	 * 
	 */	
	public class UpdateFolderCommand extends Command
	{
		public function UpdateFolderCommand()
		{
			super();  
		}
		
		override public function execute(data:Object=null):void
		{
			if(data != null)
			{
				var model:FSEModel 					= FSEModel.getInstance();
				var tree:Tree 						= data as Tree;
				var originalList:ArrayCollection 	= tree.listaFolder;
				/* Elimina i folder invisibili (magari arrivati cosi dal server ) preservando l'originale(filtrati) */
				//var visibleList:ArrayCollection		= Utils.clearListFolderVisible( originalList );
				/* creo le nuove liste di filtri */
				createListFilter( originalList );
				/* Finalmente aggiorno l'albero grafico  */ 
				model.retrieveProxy(ConstDataProxy.DATA_VISIBLE_UP_TREE).update( originalList );
				/* creo le liste dei pdt per i pannelli */
				Controller.getInstance().executeCommand(ConstCommand.UPDATE_PDT);
			}
		}
		private function createListFilter(list:ArrayCollection):void
		{
			
			var erogazione:Dictionary 	= new Dictionary();
			var folders:Dictionary 		= new Dictionary();
			var presidio:Dictionary 	= new Dictionary();
			var ente:Dictionary 		= new Dictionary();
			
			findFilter(list,erogazione,folders,presidio,ente);
			
			var model:FSEModel 		= FSEModel.getInstance();
			
			model.retrieveProxy(ConstDataProxy.LIST_EROGAZIONE).update( getListArray(erogazione) );
			model.retrieveProxy(ConstDataProxy.LIST_FOLDER).update( getListArray(folders) );
			model.retrieveProxy(ConstDataProxy.LIST_PRESIDIO).update( getListArray(presidio) );
			model.retrieveProxy(ConstDataProxy.LIST_ENTE).update( getListArray(ente) );
			
		}
		private function findFilter( list:ArrayCollection,
						erogazione:Dictionary,
						folders:Dictionary,
						presidio:Dictionary,
						ente:Dictionary):void
		{
			var iter:IIterator      = new ArrayCollectionIterator( list );
			while( iter.hasNext() )
			{
				//===============================================================
				var f:FolderTree 	= iter.next() as FolderTree;
				extractErogazione( f,erogazione );
				extractPresidio( f,presidio );
				extractFolder( f,folders );
				extractEnte( f,ente );
				
			 	if(f.children!=null && f.children.length>0)
			 	{
			 		findFilter(f.children,erogazione,folders,presidio,ente);
			 	}
			}
		}
		private function extractErogazione(f:FolderTree,erogazione:Dictionary):void
		{
			var iter:IIterator = new ArrayCollectionIterator(f.listaDCE);
			while(iter.hasNext())
			{
				var setDoc:SetDocumentale	= iter.next() as SetDocumentale;
				try{
					var descrizione:String		= setDoc.disciplinaErogazione.descrizione.toUpperCase(); 
					 
					if(descrizione != null && descrizione.length>0 && erogazione[descrizione]==null)
					{
						erogazione[descrizione] = true;
					}
				}catch(e:Error){}
			}
		}
		// it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder
		private function extractPresidio(f:FolderTree,presidio:Dictionary):void
		{
			if(f.attributiSpecificiFolder != null)
			{
				var candidate:AttributiSpecificiFolder = f.attributiSpecificiFolder;
				var descrizione:String	= null;
				switch(candidate.tipo)
				{
					case ConstAttributiSpecificiFolder.ATTRIBUTI_PS :
						var ps:ProntoSoccorso = AttributiFolderProntoSoccorso(candidate).datiProntoSoccorso;
						descrizione = getDescrizione(ps as DatoSanitario);	
						break; 
					case ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO:
						var ric:Ricovero = AttributiFolderRicovero(candidate).datiRicovero;
						descrizione =  getDescrizione(ric as DatoSanitario);
						break; 
					case ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE:
						var att:Ambulatoriale = AttributiFolderAmbulatoriale(candidate).attributiAmbulatoriale;
					 	descrizione =  getDescrizione(att as DatoSanitario);
					 	break; 	    
				}	
				if(descrizione!=null && presidio[descrizione]==null)
				{
					presidio[descrizione] = true;
				}
			}
			//it.lispa.siss.sebc.middleground.entity::AttributiFolderRicovero@e3a5301 in it.lispa.siss.sebc.middleground.entity.AttributiFolderAmbulatoriale.
		}
		private function extractFolder(f:FolderTree,folders:Dictionary):void
		{
			if(f.children!=null && f.children.length>0)return;
			if(f!=null && f.folder!=null && f.folder.descrizione!=null && f.folder.descrizione.length>0)
			{
				  var descrizione:String = f.folder.descrizione.toUpperCase();
				 if(folders[descrizione] == null)
				 {
				 	folders[descrizione] = true;
				 }
			}
		}
		private function extractEnte(f:FolderTree,ente:Dictionary):void
		{
			if(f.attributiSpecificiFolder != null)
			{
				var candidate:AttributiSpecificiFolder = f.attributiSpecificiFolder;
				var descrizione:String	= null;
				switch(candidate.tipo)
				{
					case ConstAttributiSpecificiFolder.ATTRIBUTI_PS :
						var ps:ProntoSoccorso = AttributiFolderProntoSoccorso(candidate).datiProntoSoccorso;
						descrizione =  getDescrizione(ps as DatoSanitario);	 
						break; 
					case ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO:
						var ric:Ricovero = AttributiFolderRicovero(candidate).datiRicovero;
						descrizione =  getDescrizione(ric as DatoSanitario);
						break; 
					case ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE:
						var att:Ambulatoriale = AttributiFolderAmbulatoriale(candidate).attributiAmbulatoriale;
					 	descrizione =  getDescrizione(att as DatoSanitario);	 
					 	break;    
				}
				if(descrizione!=null && ente[descrizione]==null)
				{
					ente[descrizione] = true;
				}
			} 
		}
		private function getDescrizione(dc:DatoSanitario):String
		{
			if(dc!=null
			&& dc.struttura!=null 
			&& dc.struttura.ente !=null
			&& dc.struttura.ente.descrizione.length>0)
			{
				return dc.struttura.ente.descrizione.toUpperCase();
			}	  
		 	return null;
		}
		private function getListArray(dict:Dictionary):Array
		{
			var t:Array = new Array();
			for(var s:String in dict)if(dict[s])t.push( s );
			return t;
		}
	}
}