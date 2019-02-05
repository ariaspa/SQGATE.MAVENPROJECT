package com.li.dc.sebc.turboFSE.util
{
	public class StringWriter
	{
		private const NEW_LINE:String 		= "\n";
		private var stringList:Array;
		private var _tab:String;

		private var charLine:String;
		private var _tabs:int;
		
		public function set defineTab(value:uint):void
		{
			_tab = "";
			for(var i:int = 0;i<value;i++)
				_tab += " ";
		}
		public function get defineTab():uint
		{
			return _tab.length;
		}
		public function StringWriter()
		{
			defineTab 	= 2;
			_tabs		= -1;
			charLine	= "";
			clear();
		}
		public function clear():void
		{
			stringList = new Array();
		}
		public function removeItem(index:int):String
		{
			if(index < stringList.length)
			{
				return stringList.splice(index,1)[0] as String;
			}
			return null;
		}
		public function getItem(index:int):String 
		{
			if(index < stringList.length)
			{
				return stringList[index] as String;
			}
			return null;
		}
		public function getLength():uint
		{
			return stringList.length;
		}
		public function getCharLine():String
		{
			return charLine;
		}
		public function getTabsAtNewLine():int
		{
			return this._tabs;
		}
		public function setTabsAtNewLine(tabs:int = 1,charLine:String = ""):void
		{
			this._tabs  	= tabs;
			this.charLine 	= charLine;
		}
		public function newLine(n:uint=1):void
		{
			var i:int;
			if(_tabs>=0)
			{
				for(i = 0;i<n;i++)
				{	
					stringList.push(NEW_LINE);
					add(charLine);
					tab( getTabsAtNewLine() );
				}
			}else
			{
				for(i = 0;i<n;i++)
					stringList.push(NEW_LINE);
			}
		}
		public function tab(n:uint=1):void
		{
			for(var i:int = 0;i<n;i++)
				stringList.push(_tab);
		}
		public function addAtt(str:String,index:uint):void
		{
			if(index < stringList.length)
			{
				var temp:Array = stringList.splice(index);
				stringList.push(str);
				stringList = stringList.concat(temp);
			}
		}
		public function add(str:String):void
		{
			stringList.push( str );
		}
		
		public function getString():String
		{
			var str:String = "";
			for(var i:int = 0;i<stringList.length;i++)
			{
				str += stringList[i];
			}
			return str;
		}
	}
}