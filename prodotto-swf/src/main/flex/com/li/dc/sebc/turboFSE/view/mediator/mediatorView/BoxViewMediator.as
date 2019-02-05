package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.UtilColor;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.view.builders.DirectorViste;
	import com.li.dc.sebc.turboFSE.view.nodeView.BoxView;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	import com.li.dc.sebc.turboFSE.view.viste.VistaDisciplina;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.help.HelpManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;

	public class BoxViewMediator extends Mediator
	{
		private var box:BoxView; 
		public function BoxViewMediator()
		{
			super();
		}
		override protected function finalize():void
		{}
		override protected function initialize( ):void
		{
			box = (this.view as BoxView);
			initializeData();
			initializeView();	
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
		 	model.retrieveProxy(ConstDataProxy.DATA_FOLDER_SELECT).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateFolderSelect);
		}
		private function onUpdateFolderSelect(e:DataProxyEvent):void
		{
			var model:FSEModel 		= FSEModel.getInstance();
			var dt:Object			= e.getData();
			var isNull:Boolean		= (dt==null);
			Debug.logDebug("BoxViewMediator.onUpdateFolderSelect isNull : "+isNull);
			var navLabel:String		= "";
			if(dt is FolderTree)
			{
				var listVisible:ArrayCollection	= model.retrieveProxy( ConstDataProxy.DATA_VISIBLE_UP_TREE).getData() as ArrayCollection;
				navLabel = getTextNavigationLabel( dt as FolderTree , listVisible.toArray() )
			}else if(dt is DataLabelTree)
			{
				navLabel = (dt as DataLabelTree).label;
			} 
			model.retrieveProxy(ConstDataProxy.TEXT_NAVIGATION_LABEL).update(  navLabel );
			/*Update del colore*/
			box.colorBackground		= isNull ? 0xFFFFFF : UtilColor.getColorBCK( dt );
			/*Creo la vista */
			box.currentVista		= isNull ? new Vista() : DirectorViste.getInstance().createVista( dt );
			/*Update della label del titolo*/
			box.labelTitle 			= isNull ? "" : getLabelTitle( dt );
		}
		
		private function initializeView():void
		{
			var model:FSEModel 		= FSEModel.getInstance();
			box.labelTitle 			= ""
			box.colorBackground 	= HTMLTabColor.ALICEBLUE;
			box.addEventListener("changeSelectButton",onChangeSelectButton);
			
			HelpManager.getInstance().addHelpTarget( box );
		}
		private function onChangeSelectButton(e:Event):void
		{
			var select:Boolean 		= box.selectButton;
			var who:UIComponent 	= box as UIComponent;
			var param:Object		= {select:select,who:who};
			Controller.getInstance().executeCommand(ConstCommand.EXPAND_VIEW,param);
		}
		////////////////
		private function getTextNavigationLabel(folder:FolderTree,visibleList:Array):String
		{
			return Utils.getNavigationLabel( folder,visibleList );
		}
		 
		private function getLabelTitle(folder:Object  = null):String
		{
			if(folder==null)return "";
			var lab:String = folder.label;
			if(folder is FolderTree && (folder as FolderTree).children!=null && (folder as FolderTree).children.length>0)
			{
				lab += ", documenti N° "+ (folder as FolderTree).children.length;
			}else if(folder is EventoTree && (folder as EventoTree).children!=null && (folder as EventoTree).children.length>0)
			{
				lab += ", documenti N° "+ (folder as FolderTree).children.length;
			}else if(folder is DataLabelTree)
			{
				var data:Object = box.currentVista.dataVista;
				if(data!=null && (folder as DataLabelTree).label.toUpperCase()==Costanti.DOCUMENTI.toUpperCase())
				{
					if(data.dataBody !=null &&  data.dataBody is Array){
						lab = "Documenti N° "+ ( data.dataBody as Array).length;
					}
				}else if(data!=null && (folder as DataLabelTree).label.toUpperCase()==Costanti.DISCIPLINA.toUpperCase())
				{
					if(box.currentVista is VistaDisciplina)
					{
						lab = "Elementi N° "+ (box.currentVista as VistaDisciplina).getListButton().length;
					}
				}
			} 
			return lab;
		}
	}
}