package com.li.dc.sebc.turboFSE.controller.commands.pdt
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.Utils;
	
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderPDT;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	
	import mx.collections.ArrayCollection;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */
	public class RefreshOpenFolderPDTCommand extends Command
	{
		private var reference:ISequenceReference;
		private static var counter:int	= 0;
		public function RefreshOpenFolderPDTCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data != null && data is ISequenceReference)
			{
				reference = data as ISequenceReference;
				var dt:Object	= reference.getData();
				if(dt is PercorsoDiagnosticoTerapeutico)
				{					
					var pdt:PercorsoDiagnosticoTerapeutico	= dt as PercorsoDiagnosticoTerapeutico;
					var isClose:Boolean			= getIsClose( pdt );
					var folderRoot:FolderTree 	= extractRootFolderTree();
					var folderPDT:FolderTree	= null;
					/* Sto arrivando da una apertura pdt */
					if(!isClose)
					{
						folderPDT							= createNewFolderPDT();
						folderPDT.attributiSpecificiFolder 	= getAttributiFolderPDT(  pdt );
						folderRoot.children.addItem( folderPDT );
					}else
					{
						folderPDT 	= sostituisciFolder(folderRoot, pdt );
					}
					if(folderPDT !=null)
					{
						updateTree( folderPDT );
					}
					//Controller.getInstance().executeCommand(ConstCommand.UPDATE_PDT);
					reference.nextCommand();
				}else
				{
					reference.nextCommand( dt );
				}
			}
		}
		private function sostituisciFolder( folderRoot:FolderTree, pdt:PercorsoDiagnosticoTerapeutico ):FolderTree
		{
			if(folderRoot.children!=null && folderRoot.children.length>0)
			{
				var iter:IIterator = new ArrayCollectionIterator( folderRoot.children );
				while(iter.hasNext()) 
				{
					var fld:FolderTree = iter.next() as FolderTree;
					if(fld.attributiSpecificiFolder.tipo ==  ConstAttributiSpecificiFolder.ATTRIBUTI_PDT)
					{
						var pdtOld:PercorsoDiagnosticoTerapeutico = (fld.attributiSpecificiFolder as AttributiFolderPDT).datiPDT;
						if(pdt.dataApertura!=null 
						&& (pdtOld.dataChiusura == null || pdtOld.dataChiusura.length==0)
						&& pdtOld.dataApertura == pdt.dataApertura )
						{
							(fld.attributiSpecificiFolder as AttributiFolderPDT).datiPDT = pdt;
							return fld;
						}
					}
				}
			}
			return null;
		}
		private function updateTree( folder:FolderTree ):void
		{
			var m:FSEModel		= FSEModel.getInstance();
		 	var tree:Tree 		= m.retrieveProxy(ConstDataProxy.DATA_TREE).getData() as Tree;
		 	var newTree:Tree	= new Tree();
		 	newTree.cittadino	= tree.cittadino;
		 	newTree.listaFolder	= new ArrayCollection(tree.listaFolder.toArray());
		 	/* sul mediator BoxTreeMediator arriverà l'evento di update */
		 	m.retrieveProxy(ConstDataProxy.DATA_TREE).update( newTree );
		 	m.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).update( null );
		 	m.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).update( folder );
		}
		private function getIsClose(pdt:PercorsoDiagnosticoTerapeutico):Boolean
		{
			return (pdt.dataApertura != null && pdt.dataApertura.length > 0) && (pdt.dataChiusura !=null && pdt.dataChiusura.length>0); 
		}
		private function updateListPDT(pdt:PercorsoDiagnosticoTerapeutico):void
		{
			var findPdt:PercorsoDiagnosticoTerapeutico;
			var m:FSEModel			= FSEModel.getInstance();
			var listOpen:Array 		= m.retrieveProxy(ConstDataProxy.DATA_PDT_OPEN).getData() as Array;
			for(var i:uint = 0; i<listOpen.length;i++)
			{
				findPdt = listOpen[i] as PercorsoDiagnosticoTerapeutico;
				if(findPdt.PDT!=null && findPdt.PDT.codice!=null)
				{
					if(findPdt.PDT.codice == pdt.PDT.codice)
					{
						listOpen.splice(i,1); 
						break;		
					}
				}
			}
			/* creo un nuovo array cosi viene spedito un eventUpdate */
			m.retrieveProxy(ConstDataProxy.DATA_PDT_OPEN).update( listOpen.slice() );
			/* aggiorno la lista di chiusura */
			var listClose:Array	= m.retrieveProxy(ConstDataProxy.DATA_PDT_CLOSE).getData() as Array;
			listClose.push( pdt );
			m.retrieveProxy(ConstDataProxy.DATA_PDT_CLOSE).update( listClose.slice() );
		}
		
		private function getAttributiFolderPDT(pdt:PercorsoDiagnosticoTerapeutico):AttributiFolderPDT
		{
			var afpdt:AttributiFolderPDT 	= new AttributiFolderPDT();
			afpdt.tipo						= ConstAttributiSpecificiFolder.ATTRIBUTI_PDT;
			afpdt.datiPDT					= pdt;
			return afpdt;
		}
		private function extractRootFolderTree():FolderTree
		{
			var m:FSEModel			= FSEModel.getInstance();
		 	var tree:Tree 			= m.retrieveProxy(ConstDataProxy.DATA_TREE).getData() as Tree;
			var folder:FolderTree 	= Utils.getFolderFromIdTipo("50",tree.listaFolder);
			if(folder==null)
			{
				folder = createFolderRoot();
				/* lo aggiunge al proprio padre */
				Utils.addFolder(folder , tree.listaFolder);
			}
			return folder;
		}
		private function createNewFolderPDT():FolderTree
		{
			var folder:FolderTree 		= new FolderTree();
			folder.idTipoFolder			= "51"; 
			folder.idTipoFolderPadre	= "50";	
			folder.idStatoFolder		= "OK";
			folder.nLivelloFolder		= "2";
			folder.idFolderPadre		= "folderPdtRoot";
			folder.complete				= true;
			folder.etichettaFolder		= "PERCORSO DIAGNOSTICO TERAPEUTICO";
			folder.label				= "NUOVO FOLDER PDT";
			folder.folder.descrizione	= "PNUOVO FOLDER PDT";
			folder.folder.codice		= "temp_"+(++counter);
			return folder;
		}
		private function createFolderRoot():FolderTree
		{
			var folder:FolderTree 		= new FolderTree();
			folder.idTipoFolder			= "50"; 
			folder.idStatoFolder		= "OK";
			folder.nLivelloFolder		= "1";
			folder.complete				= true;
			folder.etichettaFolder		= "PERCORSO DIAGNOSTICO TERAPEUTICO";
			folder.label				= "PERCORSO DIAGNOSTICO TERAPEUTICO";
			folder.folder.codice		= "folderPdtRoot";
			folder.folder.descrizione	= "PERCORSO DIAGNOSTICO TERAPEUTICO";
			return folder;
		}
	}
}			