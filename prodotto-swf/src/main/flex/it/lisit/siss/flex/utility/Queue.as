package it.lisit.siss.flex.utility
{
	public class Queue
	{
		protected var list:Array;
		private var _minPriority:uint;
		private var _maxPriority:uint;
		public function get maxPriority():uint
		{
			refreshPriority();
			return _maxPriority;
		}
		public function get minPriority():uint
		{
			refreshPriority();
			return _minPriority;
		}
		public function Queue( )
		{
			list = new Array();
			_maxPriority = 0;
			_minPriority = Number.MAX_VALUE;
		}
		public function size():int
		{
			return list.length;
		}
		public function empity():Boolean
		{
			return (size() == 0);
		}
		/**
		 * ritorna true se l'inserimento è andato a buon fine
		 * più è alta la priorità più vicino alla testa della coda 
		 * viene messo l'elemento, gli elementi con la stessa priorità
		 * vengono accodati in ordine di inserimento  
		 * @param element
		 * @param priority
		 * @return Boolean
		 * 
		 */	
		private function refreshPriority():void
		{
			var priority:uint;
			for(var i:uint = 0;i<list.length;i++){
				priority = list[i].priority;
				if(priority<_minPriority)_minPriority = priority;
				if(priority>_maxPriority)_maxPriority = priority;
			}
		} 	
		public function offer(element:*,priority:uint = 0):Boolean
		{
			var o:Object = {priority:priority,element:element};
			list.push( o );
			list = list.sort(funSort);
			return true;
		}
		protected function funSort(a:Object,b:Object):int
		{
			if(a.priority>b.priority)
			{
				return -1;
			}else if(a.priority<b.priority)
			{
				return 1;
			}
			return 0;
		}
		public function peek():*
		{
			if(empity()) throw new Error();
			var el:* = list[0].element;
			return el;
		}
		public function clear():void
		{
			list = new Array();
		}
		// Retrieves and removes the head of this queue 
		public function poll():*
		{
			if(empity()) throw new Error("Queue is empity");
			var el:* = list.shift().element;
			return el;
		} 
		public function exist(element:*):Boolean
		{
			for(var i:uint = 0;i<list.length;i++)
			{
				var elm:* = list[i].element;
				if(elm == element)
				{
					return true;
				}
			}
			return false;
		}
		public function remove(element:*):Boolean
		{
			for(var i:uint = 0;i<list.length;i++)
			{
				var elm:* = list[i].element;
				if(elm == element)
				{
					list.splice(i,1);
					return true;
				}
			}
			return false;
		}
		public function clone():Queue
		{
			var que:Queue = new Queue();
			for(var i:uint = 0;i<list.length;i++)
			{
				que.offer(list[i].element,list[i].priority);
			}
			return que;
		}
	}
}