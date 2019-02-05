package it.lisit.siss.flex.utility
{
	public class CapacityQueue extends Queue
	{
		private var _capacity:uint;
		public function CapacityQueue(capacity:uint = 10)
		{
			super();
			this._capacity = capacity;
		}
		public function capacity():uint{return _capacity;}
		public function fullCapacity():Boolean{return (size()==capacity());}
		public override function offer(element:*,priority:uint = 0):Boolean
		{
			if(size() < capacity())
			{
				return super.offer(element,priority);
			}
			return false;
		}
		 
		public override function clone():Queue
		{
			var que:CapacityQueue = new CapacityQueue(this.capacity());
			for(var i:uint = 0;i<list.length;i++)
			{
				que.offer(list[i].element,list[i].priority);
			}
			return que;
		}
	}
}