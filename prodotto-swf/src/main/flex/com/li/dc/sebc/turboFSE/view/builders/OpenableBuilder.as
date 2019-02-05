package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.viste.OpenableVista;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	import com.li.dc.sebc.turboFSE.view.viste.VistaBodyAgregazione;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadVista;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	public class OpenableBuilder extends Builder
	{
		public function OpenableBuilder()
		{
			super();
		}
		override protected function transformData(obj:Object):Object
		{
			return {dataHeader:getDataHeader(obj),dataBody:getDataBody(obj),label:getDataLabel(obj),tooltip:getDataTooltip(obj)};
		} 
		
		protected function getDataTooltip( data:Object ):Object
		{
			if(data!=null)
			{
				var folder:FolderTree = data as FolderTree;
				return folder.tooltip;
			}
			return "";
		}
		protected function getDataLabel( data:Object ):Object
		{
			if(data!=null)
			{
				var folder:FolderTree = data as FolderTree;
				return folder.label;
			}
			return "";
		}
		protected function getDataHeader( data:Object ):Object
		{
			if(data!=null)
			{
				if(data is FolderTree)
				{
					var folder:FolderTree = data as FolderTree;
					if(folder.attributiSpecificiFolder !=null && folder.attributiSpecificiFolder.tipo>=0)
					{
						return folder.attributiSpecificiFolder;
					}
				}
				if(data is EventoTree)
				{
					var evento:EventoTree = data as EventoTree;
					if(evento.attributiSpecificiFolder !=null && evento.attributiSpecificiFolder.tipo>=0)
					{
						return evento.attributiSpecificiFolder;
					}
				}
			}
			return null;
		}
		protected function getDataBody( data:Object ):Object
		{
			if(data!=null)
			{
				var folder:FolderTree = data as FolderTree;
				if(folder.listaDCE !=null && folder.listaDCE.length>0)
				{
					if(folder.listDataAgregazione==null)
					{
						/* tutto questo verrà sostituito, anzi cancellato perchè spostato sul server, in un secondo momento */
						folder.listDataAgregazione = getListDataAgregazione( Utils.getOrdinaAgregazioni( folder.listaDCE ) );
					}
					return folder.listDataAgregazione;
				}
			}
			return null;
		}
		/*list = Array di array  mmmm*/
		protected function getListDataAgregazione(list:Array ):Array
		{
			var t:Array = new Array();
			for(var i:uint = 0;i<list.length;i++)
			{
				var agregazione:Array		= list[i] as Array;
				
				var idAgregazione:String	= ( agregazione[0] as SetDocumentale).idAggregazioneDocumento;
				
				if(!containsKey( idAgregazione ))
				{	
					var dataAgregazione:DataAgregazione = new DataAgregazione( agregazione );
					putAgregazione( idAgregazione , dataAgregazione);
					t.push( dataAgregazione );
				}else
				{
					t.push( getValue( idAgregazione ) );
				}
			}
			return t;
		}
		 
		override protected function getVista():Vista
		{
			Debug.logInfo("getVista");
			return new OpenableVista(getHeadVistaClass(),getBodyVistaClass());
		}
		protected function getBodyVistaClass():Class
		{
			return VistaBodyAgregazione;
		}
		protected function getHeadVistaClass():Class
		{
			return HeadVista;
		}
		override protected function createMediator( v:Vista ):void
		{
			//Debug.logInfo("I make a mediator");
			if(v !=null && !containsKey( v ))
			{
				var nameMediator:String	= v.name;
				Debug.logInfo("The mediator is named :: "+nameMediator);
				TurboView.getInstance().createMediator(ConstMediator.OPENABLE_VISTA, nameMediator , v as OpenableVista);
				var m:Mediator	= TurboView.getInstance().retriveMediator( nameMediator );
				Debug.logInfo("here it is! :: "+m);
				putMediator( v , m );
			}
		}
	}
}