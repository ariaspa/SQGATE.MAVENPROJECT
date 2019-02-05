/**
* The Stack class represents a last-in-first-out (LIFO) stack of objects. 
* The usual push and pop operations are provided, as well as a method to peek at the top item on the stack, 
* a method to test for whether the stack is empty, and a method 
* to search the stack for an item and discover how far it is from the top.
* When a stack is first created, it contains no items. 
*/
package it.lisit.siss.flex.utility
{
	public class Stack
	{
		private var list:Array;
		public function Stack()
		{
			list = new Array();
		}
		public function empty():Boolean
		{
			return (size() == 0);
		}
		public function peek():*
		{
			if(empty())throw new Error("Stack is empty");
			return list[list.length-1];
		}
		public function pop():*
		{
			if(empty())throw new Error();
			return list.pop();
		}
		public function contains(value:*):Boolean
		{
			for(var i:uint = 0;i<list.length;i++)
			{
				if(list[i]==value) return true;
			}
			return false;
		}
		public function push(value:*):void
		{
			list.push( value );
		}
		/**
		 * Returns the 1-based position where an object is on this stack. 
		 * @param value
		 * @return 
		 * 
		 */		
		public function search(value:*):int
		{
			if(empty())throw new Error();
			for(var i:uint = 0;i<list.length;i++)
			{
				if(list[i]==value)
				{
					return list.length - i;
				}
			}
			throw new Error();
		}
		public function size():int{return list.length;}
		public function clear():void{list = new Array()}
		public function toArray():Array{return list.slice();}
		public function clone():Stack
		{
			var ar:Array = toArray();
			var st:Stack = new Stack();
			for(var i:uint = 0;i<ar.length;i++)
			{
				st.push( ar[i] );
			}
			return st;
		}
	}
}