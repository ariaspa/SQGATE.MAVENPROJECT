package it.lisit.siss.flex.utility
{
	public class HashEntry
	{
		private var _key:*;
		private var _value:*;
		//
		public function get key():*
		{return _key;}
		public function get value():*
		{return _value;}
		public function HashEntry(hkey:*,hvalue:*)
		{
			_key = hkey;
			_value = hvalue;
		}
		public function clone():HashEntry
		{
			return new HashEntry(key, value);
		}
	}
}