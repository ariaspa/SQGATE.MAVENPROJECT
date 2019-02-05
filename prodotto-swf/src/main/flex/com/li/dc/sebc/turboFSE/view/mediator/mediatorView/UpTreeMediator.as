package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.events.WrapDragEvent;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.ConstImageTree;
	import com.li.dc.sebc.turboFSE.view.component.UpTree;
	import com.li.dc.sebc.turboFSE.view.skin.ItemRenderFSE;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderPDT;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.collections.ArrayCollection;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.ClassFactory;
	import mx.events.DragEvent;
	import mx.managers.DragManager;

	public class UpTreeMediator extends Mediator
	{
		private var upTree:UpTree;
		/////////////////////////////////////////////////////
		 
		public function UpTreeMediator()
		{
			super();
			Debug.logDebug("UpTreeMediator instance");
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			Debug.logDebug("UpTreeMediator initialize");
			upTree = (this.view as UpTree);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
		
		}
		private function initializeView():void
		{
			Debug.logDebug("UpTreeMediator initializeView");
			upTree.styleName	 		= "canvasViewAndTree";
			upTree.showDataTips	 		= true;
			upTree.iconFunction 		= iconFunctionTreeUp;
			upTree.dataTipFunction 		= tipFunctionTreeUp;
			upTree.itemRenderer			= new ClassFactory( ItemRenderFSE );
			
			upTree.setStyle("disclosureOpenIcon",ConstImageTree.DISCLOSUREOPEN); 
			upTree.setStyle("disclosureClosedIcon",ConstImageTree.DISCLOSURECLOSE); 
			//
			upTree.addEventListener(WrapDragEvent.DRAG_DROP,onDragDropUpTree); 
			upTree.addEventListener(WrapDragEvent.DRAG_ENTER,onDragEnterUpTree); 
			 
 
		}
		private function onDragDropUpTree(e:WrapDragEvent):void
		{
			var dragEvent:DragEvent = e.getEvent() as DragEvent;
			 
		}
		private function existsDCE(idSetDoc:String, listaDce:ArrayCollection):Boolean 
		{
			if (listaDce == null || idSetDoc == null)
				return false;
			for (var i:uint = 0; i < listaDce.length; i++)  
			{
				if (idSetDoc == (listaDce[i] as SetDocumentale).idSetDocumenti)
					return true;	
			}
			return false;
		}
		private function tipoDCEInList(dce:SetDocumentale):Boolean 
		{
			/*var listTipiDce:Array = GlobalModel.getInstance().config.listCopyDCEInPdt;
			for (var i:uint = 0; i < listTipiDce.length; i++)
			{
				if (dce.idTipoDocumento == listTipiDce[i])
					return true;
			}*/
			return true;
		}
		private function onDragEnterUpTree(e:WrapDragEvent):void
		{
			var dragEvent:DragEvent 	= e.getEvent() as DragEvent;
			var item:IListItemRenderer 	= dragEvent.target as IListItemRenderer;
			var data:FolderTree = item.data as FolderTree; 
			upTree.expandItem(data, true, true);
			upTree.scrollToIndex( upTree.getItemIndex(data) );
			////
			if (dragEvent.dragSource.hasFormat('value')) 
            {
            	if (isPDT(data) && isPDTOpen(data))
            	{
            		var dce:SetDocumentale = dragEvent.dragSource.dataForFormat('value') as SetDocumentale;
            		 
            		if (!existsDCE(dce.idSetDocumenti, data.listaDCE) && tipoDCEInList(dce))
                	{
                		item.addEventListener(DragEvent.DRAG_DROP, executeCopy)
                		DragManager.acceptDragDrop( item );
                	}
            	}
            }
		}
		private function executeCopy(event:DragEvent):void 
		{
			var item:IListItemRenderer 	= event.target as IListItemRenderer;
			item.removeEventListener(DragEvent.DRAG_DROP, executeCopy);
			
        //	currentFolder = item.data;
		//	var dce:SetDocumentale = dragEvent.dragSource.dataForFormat('value') as SetDocumentale;
			
		//	Alert.yesLabel = "SI";
		//	var body:String		= "Sei sicuro di voler copiare il documento selezionato nella cartella " + (event.target.data as VoFolders).label + "?"
		//	var title:String	= "Conferma";
			//ViewMessageManager.getInstance().showAlert( body,title,(Alert.YES | Alert.NO)
		 
			 
			//Alert.show("", "Conferma", (Alert.YES | Alert.NO),   confermaCopia, null, Alert.YES);
			
		}
		
		
		private function tipFunctionTreeUp(item:Object):String
		{
			if(item is FolderTree)
			{
				var folder:FolderTree = item as FolderTree;
				return folder.tooltip;
			}
			if(item.toolTip !=null)
			{
				return item.toolTip;
			}
			return "";
		}
		private function iconFunctionTreeUp(item:Object):void
		{
			Debug.logDebug("UpTreeMediator iconFunctionTreeUp (item is FolderTree): "+(item is FolderTree));
			if(!(item is FolderTree))return;
			var folder:FolderTree = item as FolderTree;
			var classOpen:Class ;
			var classClose:Class ;
			/*  */
			var figli:Boolean 		= (folder.children !=null && folder.children.length>0);
			var dce:Boolean			= (folder.listaDCE !=null && folder.listaDCE.length>0);
			var attFolder:Boolean	= (folder.attributiSpecificiFolder != null);
			var stato:Boolean 		= (folder.idStatoFolder != null && folder.idStatoFolder.toUpperCase() == "OK");
			var c:String			= Number(figli).toString() + Number(stato).toString();
			switch(c)
			{
				case "00":
					//classOpen 	= ConstImageTree.ICONARANCIOFOGLIA;
					//classClose 	= ConstImageTree.ICONARANCIOFOGLIA;
					//break;
				case "01":
					classOpen 	= ConstImageTree.ICONVERDEFOGLIA;
					classClose 	= ConstImageTree.ICONVERDEFOGLIA;
					break;	
				case "10":
					//classOpen 	= ConstImageTree.ICONARANCIOOPEN;
					//classClose 	= ConstImageTree.ICONARANCIOCLOSE;
					//break;
				case "11":
					classOpen 	= ConstImageTree.ICONVERDEOPEN;
					classClose 	= ConstImageTree.ICONVERDECLOSE;
					break;
			}
			Debug.logDebug("iconFunctionTreeUp c :: "+c);
			Debug.logDebug("iconFunctionTreeUp classOpen :: "+classOpen);
			Debug.logDebug("iconFunctionTreeUp classClose :: "+classClose);
			if(classOpen!=null && classClose!=null)
			{ 
				upTree.setItemIcon( item,classClose,classOpen);
			}
		}
		private function isPDT(folder:FolderTree):Boolean 
		{
			if (folder.idTipoFolderPadre == "50" || folder.idTipoFolderPadre =="#50") 
			{
				return true;
			}
			return false;
		}
		private function isPDTOpen(folder:FolderTree):Boolean 
		{
			if(folder.attributiSpecificiFolder != null && folder.attributiSpecificiFolder is AttributiFolderPDT)
			{
				var pdt:PercorsoDiagnosticoTerapeutico = (folder.attributiSpecificiFolder  as AttributiFolderPDT).datiPDT;
				return (pdt.dataChiusura == null || pdt.dataChiusura.length==0 );
			}
			return false;	
		}
	}
}