package it.lisit.siss.flex.utility
{
	public class Cache
	{
		private var hash:HashTable;
		public function Cache()
		{
			hash = new HashTable();
		}
		public function size():int
		{
			refresh();
			return hash.size();
		}
		
		/*  time if == 0, then undefined live */				
		public function put(key:*,value:*,live:uint=0):void
		{
			var o :Object = {value:value,born:new Date().getMilliseconds(),live:live};
			hash.put(key , o );
		}
		public function remove(key:*):void
		{
			if(hash.containsKey(key))
				hash.removeFromKey( key );
		}
		public function getValue( key:* ):*
		{
			refresh();
			if(hash.containsKey(key))
				return  hash.getValue( key ).value; 
			return null;
		}
		public function refresh():void
		{
			var thisIstant:int = new Date().getMilliseconds();
			var keys:Array = hash.getKeys();
			for(var i:uint = 0;i<keys.length;i++)
			{
				var k:* = keys[i];
				var value:Object = hash.getValue(k);
				if(value.live>0)
				{
					var dead:uint =  value.born + value.live;
					if(thisIstant>=dead)
					{
						hash.removeFromKey( k );
					}
				} 
			}
		}
	}
}