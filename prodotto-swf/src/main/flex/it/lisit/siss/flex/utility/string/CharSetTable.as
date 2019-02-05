package it.lisit.siss.flex.utility.string
{
	import flash.utils.Dictionary;
	
	public class CharSetTable
	{
		public static const CHARGRAVE:Array=["&quot;","&amp;","&lt;","&gt;","&nbsp;","&iexcl;","&cent;","&pound;","&curren;","&yen;","&brvbar;","&brkbar;","&sect;",  
											"&uml;","&die;","&copy;","&ordf;","&not;","&shy;","&reg;","&macr;","&hibar;","&deg;","&plusmn;","&sup2;","&sup3;","&acute;","&micro;", 
											"&para;","&middot;","&cedil;","&sup1;","&ordm;","&raquo;","&iquest;","&Agrave;","&Aacute;","&Acirc;", "&Atilde;",
											"&Auml;","&Aring;","&AElig;","&Ccedil;","&Egrave;","&Eacute;","&Ecirc;", "&Euml;","&Igrave;","&Iacute;",
											"&Icirc;","&Iuml;","&ETH;","&Dstrok;","&Ntilde;","&Ograve;","&Oacute;","&Ocirc;","&Otilde;","&Ouml;","&times;", 
											"&Oslash;","&Ugrave;","&Uacute;","&Ucirc;", "&Uuml;","&Yacute;","&THORN;","&szlig;","&agrave;","&aacute;",
											"&acirc;","&atilde;","&auml;","&aring;","&aelig;","&ccedil;","&egrave;","&eacute;","&ecirc;", "&euml;",  
											"&igrave;","&iacute;","&icirc;", "&iuml;","&eth;","&ntilde;","&ograve;","&oacute;","&ocirc;", "&otilde;",
											"&ouml;","&divide;","&oslash;","&ugrave;","&uacute;","&ucirc;", "&uuml;","&yacute;","&thorn;","&yuml;","&rsquo;"];
		/////////////////////////////////////////////////
		private static var table:Dictionary = getTable();
		private static function getTable():Dictionary
		{
			var table:Dictionary 	= new Dictionary();
			table["&quot;"]			="&#34;";
			table["&amp;"]			="&#38;";
			table["&lt;"]			="&#60;";
			table["&gt;"]			="&#62;";
			table["&nbsp;"]			="&#160;";
			table["&iexcl;"]		="&#161;";
			table["&cent;"]			="&#162;";
			table["&pound;"]		="&#163;";
			table["&curren;"]		="&#164;";
			table["&yen;"]			="&#165;";
			table["&brvbar;"]		="&#166;";
			table["&brkbar;"]		="&#166;";
			table["&sect;"]			="&#167;";
			table["&uml;"]			="&#168;";
			table["&die;"]			="&#168;";
			table["&copy;"]			="&#169;";
			table["&ordf;"]			="&#170;";
			table["&not;"]			="&#172;";
			table["&shy;"]			="&#173;";
			table["&reg;"]			="&#174;";
			table["&macr;"]			="&#175;";
			table["&hibar;"]		="&#175;";
			table["&deg;"]			="&#176;";
			table["&plusmn;"]		="&#177;";
			table["&sup2;"]			="&#178;";
			table["&sup3;"]			="&#179;";
			table["&acute;"]		="&#180;";
			table["&micro;"]		="&#181;";
			table["&para;"]			="&#182;";
			table["&middot;"]		="&#183;";
			table["&cedil;"]		="&#184;";
			table["&sup1;"]			="&#185;";
			table["&ordm;"]			="&#186;";
			table["&raquo;"]		="&#187;";
			table["&iquest;"]		="&#191;";
			table["&Agrave;"]		="&#192;";
			table["&Aacute;"]		="&#193;";
			table["&Acirc;"]		="&#194;";
			table["&Atilde;"]		="&#195;";
			table["&Auml;"]			="&#196;";
			table["&Aring;"]		="&#197;";
			table["&AElig;"]		="&#198;";
			table["&Ccedil;"]		="&#199;";
			table["&Egrave;"]		="&#200;";
			table["&Eacute;"]		="&#201;";
			table["&Ecirc;"]		="&#202;";
			table["&Euml;"]			="&#203;";
			table["&Igrave;"]		="&#204;";
			table["&Iacute;"]		="&#205;";
			table["&Icirc;"]		="&#206;";
			table["&Iuml;"]			="&#207;";
			table["&ETH;"]			="&#208;";
			table["&Dstrok;"]		="&#208;";
			table["&Ntilde;"]		="&#209;";
			table["&Ograve;"]		="&#210;";
			table["&Oacute;"]		="&#211;";
			table["&Ocirc;"]		="&#212;";
			table["&Otilde;"]		="&#213;";
			table["&Ouml;"]			="&#214;";
			table["&times;"]		="&#215;";
			table["&Oslash;"]		="&#216;";
			table["&Ugrave;"]		="&#217;";
			table["&Uacute;"]		="&#218;";
			table["&Ucirc;"]		="&#219;";
			table["&Uuml;"]			="&#220;";
			table["&Yacute;"]		="&#221;";
			table["&THORN;"]		="&#222;";
			table["&szlig;"]		="&#223;";
			table["&agrave;"]		="&#224;";
			table["&aacute;"]		="&#225;";
			table["&acirc;"]		="&#226;";
			table["&atilde;"]		="&#227;";
			table["&auml;"]			="&#228;";
			table["&aring;"]		="&#229;";
			table["&aelig;"]		="&#230;";
			table["&ccedil;"]		="&#231;";
			table["&egrave;"]		="&#232;";
			table["&eacute;"]		="&#233;";
			table["&ecirc;"]		="&#234;";
			table["&euml;"]			="&#235;";
			table["&igrave;"]		="&#236;";
			table["&iacute;"]		="&#237;";
			table["&icirc;"]		="&#238;";
			table["&iuml;"]			="&#239;";
			table["&eth;"]			="&#240;";
			table["&ntilde;"]		="&#241;";
			table["&ograve;"]		="&#242;";
			table["&oacute;"]		="&#243;";
			table["&ocirc;"]		="&#244;";
			table["&otilde;"]		="&#245;";
			table["&ouml;"]			="&#246;";
			table["&divide;"]		="&#247;";
			table["&oslash;"]		="&#248;";
			table["&ugrave;"]		="&#249;";
			table["&uacute;"]		="&#250;";
			table["&ucirc;"]		="&#251;";
			table["&uuml;"]			="&#252;";
			table["&yacute;"]		="&#253;";
			table["&thorn;"]		="&#254;";
			table["&yuml;"]			="&#255;";	
			table["&rsquo;"]		="&#146;";	
			return table;
		}
		public static function getChar(charAgrave:String):String
		{
			var char:String = table[charAgrave];
			if(char == null)return charAgrave;
			return char;
		}
	}
}