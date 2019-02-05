package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.BoxTree;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.flex.help.HelpManager;
	
	import mx.collections.ArrayCollection;
	/**
	 * Mediator del box dei tree 
	 * @author marco
	 * 
	 */	
	public class BoxFlussiMediator extends Mediator
	{
		private var boxTree:BoxTree;
		private var lastSelectItem:EventoTree;
		public function BoxFlussiMediator()
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
			model.retrieveProxy( ConstDataProxy.DATA_VISIBLE_UP_FLUSSI ).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateUpTree);
		}
		private function onUpdateUpTree(e:DataProxyEvent):void
		{
			boxTree.reset();
			boxTree.dataProviderUpTree  = e.getData();
		}
		private function initializeView():void
		{
			var model:FSEModel 				= FSEModel.getInstance();
			boxTree.idHelp					= "boxTreeFlussi";
			boxTree.title 					= "EVENTI";
			boxTree.tooltipTitle 			= "Albero degli eventi";
			boxTree.colorBackGroundTitle	= HTMLTabColor.WHITE;
			//
			boxTree.addEventListener("changeSelectItemDownTree",onChangeSelectItemDownTree);
			boxTree.addEventListener("changeSelectItemUpTree",onChangeSelectItemUpTree);
			boxTree.addEventListener("changeSelectButton",onChangeSelectButton);
			///////////////////
			//boxTree.addEventListener(DragEvent.DRAG_ENTER,onDragEnter);
			//boxTree.addEventListener(DragEvent.DRAG_EXIT,onDragExit);
			
			HelpManager.getInstance().addHelpTarget( boxTree );
			
			TurboView.getInstance().createMediator(ConstMediator.UP_TREE_FLUSSI, ConstMediator.UP_TREE_FLUSSI, boxTree.upTree);
			
			TurboView.getInstance().createMediator(ConstMediator.DOWN_TREE_FLUSSI, ConstMediator.DOWN_TREE_FLUSSI, boxTree.downTree);
			/* il menù sotto    
				
				What the hell kind of language is this anyway? 
				It sounds like gibberish
				Speak english! We rule the world, don't we?
				
			*/
			 
			var root:DataLabelTree 	= new DataLabelTree();
			root.children			= new ArrayCollection();
			root.label 				= "Viste";
			root.toolTip 			= "Viste";
			root.value				= "root";
			root.children.addItem( new DataLabelTree( "Cronologico","Vista cronologica" , Costanti.CRONOLOGICO) );
			boxTree.dataProviderDownTree = root;
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
			if(boxTree.selectItemUpTree!=null && boxTree.selectItemUpTree is EventoTree)
			{
				lastSelectItem = boxTree.selectItemUpTree as EventoTree;
				//Controller.getInstance().executeCommand(ConstCommand.UPDATE_CONTENT_FOLDER ,lastSelectItem);
				/*al conrtrario dei folder, gli eventi sono già completi, non hanno bisogno di un command di update */
				var model:FSEModel = FSEModel.getInstance();
		 		model.retrieveProxy(ConstDataProxy.DATA_FLUSSI_SELECT).update( lastSelectItem );
			}
		}
		private function onChangeSelectItemDownTree(e:Event):void
		{
			Debug.logDebug("onChangeSelectItemDownTree "+ boxTree.selectItemDownTree);
			if(boxTree.selectItemDownTree!=null && boxTree.selectItemDownTree is DataLabelTree)
			{
				lastSelectItem = null;
				var datalabel:DataLabelTree	= boxTree.selectItemDownTree as DataLabelTree;
				Controller.getInstance().executeCommand(ConstCommand.UPDATE_DOWN_ITEM_TREE ,datalabel);
			}
		}
	}
}