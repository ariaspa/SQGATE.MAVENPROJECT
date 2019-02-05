package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.WrapData;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.view.viste.ListVistaCronologico;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.utils.DateFormat;
	
	import mx.collections.ArrayCollection;
	
	public class CronologicoBuilder extends Builder
	{
		private var counter:int;
		private var oldFlussi:ArrayCollection;
		private var keyVista:String;
		private var lista:ArrayCollection;
		private var dataCrono:ArrayCollection; 
		public function CronologicoBuilder()
		{
			super();
			counter = 0;
		}
		override protected function getVista():Vista
		{
			return new ListVistaCronologico();
		}
		
		override protected function getKey():Object
		{
			var m:FSEModel				= FSEModel.getInstance();
			var flussi:ArrayCollection 	= m.retrieveProxy(ConstDataProxy.DATA_VISIBLE_UP_FLUSSI).getData() as ArrayCollection;
			if(flussi!=lista)
			{
				// cancellare il vecchio
				Debug.logWarning("TODO:cancellare la vecchia vista (CronologicoBuilder) ");
				keyVista = "key_"+(counter++);
			}
			lista = flussi;
			return keyVista;
		}
		override protected function transformData( obj:Object ):Object
		{
			var label:String	= (obj as DataLabelTree).label;
			var toolTip:String	= (obj as DataLabelTree).toolTip;
			var temp:Array		= new Array();
			if(lista != null)
			{
				var iter:IIterator 	= new ArrayCollectionIterator( lista );
				while(iter.hasNext())
				{
					var evento:EventoTree = iter.next() as EventoTree;
					if(evento.children!=null && evento.children.length>0)
					{
						var children:IIterator = new ArrayCollectionIterator( evento.children );
						while( children.hasNext() )
						{
							var wrap:WrapData = new WrapData( children.next() );
							var vista:Vista = DirectorViste.getInstance().createVista( wrap );
							wrap.vista      = vista;
							temp.push(  wrap  );
						}		
					} 
				}
				temp = temp.sort( sortFunction );
			}
			var result:Object = {dataBody:temp,label:label,tooltip:toolTip};
			FSEModel.getInstance().retrieveProxy( ConstDataProxy.DATA_FOLDER_SELECT ).update( null );
			return result;
		} 
		private function sortFunction(a:WrapData,b:WrapData):int
		{
			var dataErogazioneA:String	= (a.data as EventoTree).dataErogazioneEvento; 
			var dataErogazioneB:String	= (b.data as EventoTree).dataErogazioneEvento; 
			if(dataErogazioneA !=null && dataErogazioneA.length>0 
				&& dataErogazioneB!=null && dataErogazioneB.length>0)
				{
					var ad:Date	= DateFormat.stringToDate( dataErogazioneA );
					var bd:Date	= DateFormat.stringToDate( dataErogazioneB );
					
					if( UtilDate.isMajor( ad , bd ) )
					{
						return -1;
					}else if( UtilDate.isMajor( bd , ad  ) )
					{
						return 1;
					}
				}
			return 0;
		}
	}
}