package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.model.vo.WrapDataDocument;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.DictionaryIteratorKey;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.graphic.timeline.model.DataDocument;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	public class TransformDataTimeLine extends TransformDataTimeLineBase
	{
		private var tipologieDati:Dictionary;
		private var tipologieDCE:Dictionary;
		private var elencoPDT:ArrayCollection;
		private var elencoFarmaci:ArrayCollection;	
		private var elencoDiscipline:Dictionary;	
		private var elencoPrestazione:Dictionary;	
		private var listWrap:Array;
		
		public function TransformDataTimeLine(tmli:Array)
		{
			super(tmli);
		}
		
		public function getTipologieDati():Array
		{
			var a:Array = new Array();
			var iter:IIterator = new DictionaryIteratorKey(tipologieDati);
			while(iter.hasNext())a.push(iter.next());
			return a;
		}
		
		public function getTipologieDCE():Array
		{
			var a:Array = new Array();
			var iter:IIterator = new DictionaryIteratorKey(tipologieDCE);
			while(iter.hasNext())a.push(iter.next());
			return a;
		}
		
		public function getElencoPDT():Array
		{
			var a:Array 		= new Array();
			var d:Dictionary	= new Dictionary();
			var iter:IIterator 	= new ArrayIterator(elencoPDT.toArray());
			while(iter.hasNext())
			{
				var s:String = iter.next() as String;
				if(d[s]==null)
				{
					d[s] = s;
					a.push( s.toUpperCase() );
				}
			}
			return a;
		}
		public function getElencoFarmaci():Array
		{
			var a:Array 		= new Array();
			var d:Dictionary	= new Dictionary();
			var iter:IIterator 	= new ArrayIterator(elencoFarmaci.toArray());
			while(iter.hasNext())
			{
				var s:String = iter.next() as String;
				if(d[s]==null)
				{
					d[s] = s;
					a.push( s.toUpperCase() );
				}
			}
			return a;
		}
		public function getElencoDiscipline():Array
		{
			var a:Array = new Array();
			var iter:IIterator = new DictionaryIteratorKey(elencoDiscipline);
			while(iter.hasNext())a.push(iter.next());
			return a;
		}
		public function getElencoPrestazione():Array
		{
			var a:Array = new Array();
			var iter:IIterator = new DictionaryIteratorKey(elencoPrestazione);
			while(iter.hasNext())a.push(iter.next());
			return a;
		}
		
		public function getListWrap():Array
		{
			return listWrap;
		}
		override protected function setFilter(doc:DataDocument):void
		{
			var wrap:WrapDataDocument = new WrapDataDocument(doc);
			var strTrim:String = "";
			var iter:IIterator;
			if(wrap.tipologiaDati!=null && wrap.tipologiaDati.length>0)
			{ 
				strTrim = StringUtil.trim( wrap.tipologiaDati );
				tipologieDati[strTrim] = strTrim;
			} 
			if(wrap.tipologiaDCE!=null && wrap.tipologiaDCE.length>0)
			{ 
				strTrim = StringUtil.trim( wrap.tipologiaDCE );
				tipologieDCE[ strTrim ] = strTrim;
			}
			
			if(wrap.PDT!=null && wrap.PDT.length>0)
			{
				iter = new ArrayIterator(wrap.PDT.toArray());
				var pdt:ArrayCollection	= new ArrayCollection();
				while(iter.hasNext())
				{
					pdt.addItem( StringUtil.trim( iter.next() as String ) );
				}
				elencoPDT.addAll( pdt );
			}
			if(wrap.farmaco!=null && wrap.farmaco.length>0)
			{
				iter = new ArrayIterator(wrap.farmaco.toArray());
				var farm:ArrayCollection	= new ArrayCollection();
				while(iter.hasNext())
				{
					farm.addItem( StringUtil.trim( iter.next() as String ) );
				}
				elencoFarmaci.addAll( farm );
			}
			if(wrap.disciplina!=null && wrap.disciplina.length>0)
			{
				strTrim = StringUtil.trim( wrap.disciplina );
				elencoDiscipline[ strTrim ] = strTrim;
			}
			 
			if(wrap.prestazione!=null && wrap.prestazione.length>0)
			{
				strTrim = StringUtil.trim( wrap.prestazione );
				elencoPrestazione[ strTrim ] = strTrim;
			}
			listWrap.push( wrap );
		}
		override public function execute():Array
		{
			listWrap 			= new Array();
			tipologieDati 		= new Dictionary();
			tipologieDCE 		= new Dictionary();
			elencoPDT 			= new ArrayCollection();
			elencoFarmaci 		= new ArrayCollection();
			elencoDiscipline 	= new Dictionary();
			elencoPrestazione 	= new Dictionary();
			return super.execute();
		}
	}
}

 
  






