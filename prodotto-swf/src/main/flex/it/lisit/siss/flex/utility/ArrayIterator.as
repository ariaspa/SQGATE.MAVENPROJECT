package it.lisit.siss.flex.utility
{
	import mx.collections.ArrayCollection;

	public class ArrayIterator implements IIterator
	{
		private var list:Array;
		private var index:uint;
		public function ArrayIterator( array:Array = null )
		{
			list = array;
			if(list == null)
			{
				list = new Array();
			}
			index = 0;
		}
		public function hasNext():Boolean
		{
			return (index<list.length);
		}
		public function next():Object
		{
			var o:Object;
			if(hasNext())
				o = list[index++];
			 else
				throw new Error("Out of range");
					
			return o;
		}
		public function reset():void
		{
			index = 0;
		}
	}
}