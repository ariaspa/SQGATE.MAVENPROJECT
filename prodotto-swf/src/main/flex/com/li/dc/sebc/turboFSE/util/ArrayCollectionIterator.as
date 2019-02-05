package com.li.dc.sebc.turboFSE.util
{
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	
	import mx.collections.ArrayCollection;
	
	public class ArrayCollectionIterator extends ArrayIterator 
	{
		public function ArrayCollectionIterator(list:ArrayCollection=null)
		{
			super((list!=null) ? list.toArray() : new Array() );
		}
	}
}