package it.lisit.siss.flex.utility
{
	import flash.utils.Dictionary;
	/**
	 * porting java
	 * @author Marco Salonia
	 * 
	 */	
	public class HashTable
	{
		private var table:Dictionary;
		private var valueDict:Dictionary;
		private var length:int;
		public function HashTable()
		{
			table = new Dictionary();
			valueDict = new Dictionary();
			length = 0;
		}
		//
		public function put(key:*, value:*) : void
        {
        	if(!containsKey(key))
        		length++;
        		
            table[key] = value;
            valueDict[value] = key;
        }
        public function putEntry(entry:HashEntry) : void
        {
        	put(entry.key,entry.value);
        }
        public function removeFromKey(key:*) : void
        {
        	if(!containsKey(key))throw new Error();
        	delete valueDict[table[key]];
            delete table[key];
            length--;
        }
        public function removeFromValue(value:*) : void
        {
        	if(!containsValue(value))throw new Error();
        	delete table[valueDict[value]];
        	delete valueDict[value];
        	length--;
        }
        public function containsKey(key:*) : Boolean
        {
            return table[key] != null;
        }
        public function containsValue(value:*) : Boolean
        {
        	return valueDict[value] != null;
        }
        public function getKey(value:*) : *
        {
        	if(!containsValue(value))
        	{
        		throw new Error();	
        	}
        	return valueDict[value];
        }
        public function getKeys() : Array
        {
            var keys:Array = [];
            for (var key:* in table)
            {
                keys.push( key );
            }
            return keys;
        }
        public function getValue(key:*) : *
        {
        	if(!containsKey(key))
        	{
        		throw new Error();	
        	}
            return table[key];
        }
        public function getValues() : Array
        {
            var values:Array = [];

            for (var key:* in table)
            {
                values.push( table[key] );
            }
            return values;
        }
        public function size() : int
        {
             return length;
        }
        public function isEmpty() : Boolean
        {
            return size() <= 0;
        }
        public function clear() : void
        {
            for ( var key:* in table )
            {
                removeFromKey( key );
            }
        }
        public function clearAllExceptKey(keyId:*) : void
        {
            for ( var key:* in table )
            {
                if ( key != keyId )
                {
                    removeFromKey( key );
                }
            }
        }
        public function clearAllExceptValue(valueId:*) : void
        {
            for ( var value:* in valueDict )
            {
                if ( value != valueId )
                {
                    removeFromValue( value );
                }
            }
        }
        public function putAll(hashtable:HashTable) : void
        {
         	var entries:Array = hashtable.getEntries();
         	for(var i:uint = 0;i<entries.length;i++)
         	{
         		putEntry( entries[i] );
         	}
        }
        public function getEntries():Array
        {
        	var entries:Array = new Array();
        	var keys:Array = this.getKeys();
        	for(var i:uint = 0;i<keys.length;i++)
         	{
         		var entry:HashEntry = new HashEntry(keys[i],this.getValue(keys[i]));
         		entries.push( entry );
         	}
         	return entries;
        }
        /**
         * warning, non clona gli oggetti dentro la tabella, ma la tabella, quindi più
         * tabelle possono contenere riferimenti agli stessi oggetti 
         * @return 
         * 
         */        
        public function clone():HashTable
        {
        	var cl:HashTable = new HashTable();
        	cl.putAll(this);
        	return cl;
        }
	}
}