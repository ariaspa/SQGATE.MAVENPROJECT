package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.dataProxy.DataDownTree;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.TurboDataDescriptor;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.view.component.UpTree;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.BoxTree;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.help.HelpManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.collections.ArrayCollection;
	import mx.events.DragEvent;

	public class BoxTreeMediator extends Mediator
	{
		private var boxTree:BoxTree;
		private var lastSelectItem:FolderTree;
		private var selectDown:Boolean = false;

		private var freezeExpande:Boolean = false;
		
		
		public function BoxTreeMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			boxTree = (this.view as BoxTree);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_VISIBLE_UP_TREE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateUpTree);
			model.retrieveProxy(ConstDataProxy.DATA_DOWN_TREE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateDownTree);
		 	model.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateFolderSelect);
		    (model.retrieveProxy(ConstDataProxy.DATA_DOWN_TREE) as DataDownTree).fillDefault();
		}
		private function onUpdateDownTree(e:DataProxyEvent):void
		{
			boxTree.dataProviderDownTree = e.getData();
		}
		private function onUpdateUpTree(e:DataProxyEvent):void
		{
			if(!selectDown)
			{
				boxTree.reset();
			}
			boxTree.dataProviderUpTree  =  e.getData() as ArrayCollection;
		}
		private function subtituteFolder(fld:FolderTree,dtProvider:ArrayCollection,select:FolderTree=null):void
		{
			if(dtProvider!=null && fld !=null && fld!=select)
			{
				for(var i:uint=0;i<dtProvider.length;i++)
				{
					var child:FolderTree = dtProvider.getItemAt(i) as FolderTree;
					if(child==fld)
					{
						dtProvider.setItemAt(select,i);
						break;
					}else if(child.children!=null && child.children.length>0)
					{
						subtituteFolder(fld,child.children,select);
					}
				}
			}
		}
		private function onUpdateFolderSelect(e:DataProxyEvent):void
		{
			//var select:FolderTree = e.getData() as FolderTree;
			//var dtProvider:ArrayCollection = boxTree.upTree.dataProvider as ArrayCollection;
			//if(boxTree.upTree.getCollection()!=null)
			//{
				//var collection:ICollectionView = boxTree.upTree.getCollection();
				   
			//}
			//subtituteFolder( lastSelectItem, dtProvider,select);
			
			//(boxTree.dataProviderUpTree as ArrayCollection).getItemAt(
			
			//boxTree.upTree.dataProvider
			/*
			if(select==null)return;
			if(select is FolderTree)
			{
				if(lastSelectItem != select)
				{
					lastSelectItem 	= select as FolderTree;
					
					//Later.doLater( openTree );
				}	
			}else if(select is DataLabelTree)
			{
					
			} */
			//Debug.logDebug( "BoxTreeMediator onUpdateFolderSelect :select:: " +select);
		}
		
		private function openTree():void
		{
			var tree:UpTree = boxTree.upTree;
			tree.openItems	= lastSelectItem;
            expandsList( getListExpands( lastSelectItem ) );     
			tree.selectedItem = lastSelectItem;
			tree.validateNow();  
		}
		private function expandsList(list:Array):void
		{
			var tree:UpTree = boxTree.upTree;
			var iter:IIterator = new ArrayIterator( list );
			while( iter.hasNext() )
			{
				var fld:FolderTree	= iter.next() as FolderTree;
				tree.expandItem( fld, true, true );
    			var idx:int = tree.getItemIndex( fld );
    			tree.scrollToIndex( idx );
    			tree.selectedIndex	= idx;
			}
		}
		private function getListExpands(node:FolderTree):Array
		{
			var temp:Array = new Array();
			findParents(node,temp);
			return temp.reverse(); 
		}
		private function findParents(node:FolderTree,list:Array):void
		{
			if(node)
			{
				list.push( node );
				var tree:UpTree 	= boxTree.upTree;
				if(node.idFolderPadre!=null && node.idFolderPadre.length>0 && tree.dataProvider!=null)
				{
					var lista:Array		= (tree.dataProvider as ArrayCollection).toArray();
	               	var nd:FolderTree 	=  Utils.getFolderFromId(node.idFolderPadre,lista);
	                findParents( nd, list );
				}
			}
		}
		 
		private function initializeView():void
		{
			var model:FSEModel 				= FSEModel.getInstance();
			//mx.controls.treeClasses
				
			boxTree.upTree.dataDescriptor   = new TurboDataDescriptor();	
			boxTree.title 					= "FASCICOLO";
			boxTree.tooltipTitle 			= "Albero dei folder";
			boxTree.colorBackGroundTitle	= HTMLTabColor.WHITE;
			//
			boxTree.addEventListener("changeSelectItemDownTree",onChangeSelectItemDownTree);
			boxTree.addEventListener("changeSelectItemUpTree",onChangeSelectItemUpTree);
			boxTree.addEventListener("changeSelectButton",onChangeSelectButton);
			///////////////////
			boxTree.addEventListener(DragEvent.DRAG_ENTER,onDragEnter);
			boxTree.addEventListener(DragEvent.DRAG_EXIT,onDragExit);
			
			HelpManager.getInstance().addHelpTarget( boxTree );
			
			TurboView.getInstance().createMediator(ConstMediator.UP_TREE, ConstMediator.UP_TREE, boxTree.upTree);
			
			TurboView.getInstance().createMediator(ConstMediator.DOWN_TREE, ConstMediator.DOWN_TREE, boxTree.downTree);
			  
		}
		 
		private function onRemove(e:Event):void
		{
			//TurboView.getInstance().destroyMediator( boxTree.name );
		}
		private function onDragExit(e:DragEvent):void
		{
		
		}
		private function onDragEnter(e:DragEvent):void
		{
		
		}
		
		private function onChangeSelectButton(e:Event):void
		{
			e.stopPropagation();
			var select:Boolean 		= boxTree.selectButton;
			var param:Object		= {select:select,who:boxTree};
			Controller.getInstance().executeCommand(ConstCommand.EXPAND_VIEW,param);
		}
		private function onChangeSelectItemUpTree(e:Event):void
		{
			Debug.logDebug("onChangeSelectItemUpTree "+ boxTree.selectItemUpTree);
			if(boxTree.selectItemUpTree!=null && boxTree.selectItemUpTree is FolderTree)
			{
				lastSelectItem = boxTree.selectItemUpTree as FolderTree;
				selectDown = false; 
				Controller.getInstance().executeCommand(ConstCommand.UPDATE_CONTENT_FOLDER ,lastSelectItem);
			}
		}
		private function onChangeSelectItemDownTree(e:Event):void
		{
			Debug.logDebug("onChangeSelectItemDownTree "+ boxTree.selectItemDownTree);
			
			if(boxTree.selectItemDownTree!=null && boxTree.selectItemDownTree is DataLabelTree )
			{
				lastSelectItem = null;
				var datalabel:DataLabelTree	= boxTree.selectItemDownTree as DataLabelTree;
				selectDown = true;
				Controller.getInstance().executeCommand(ConstCommand.UPDATE_DOWN_ITEM_TREE ,datalabel);
			}
		}
	}
}







