package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.coop.voProvinceDiNascita.VoOutputProvinceDiNascita;
	
	internal class ParserProvinceDiNascita
	{
		private var _body:XML;
		public function ParserProvinceDiNascita(body:XML)
		{
			_body = body;
		}
		public function execute():VoOutputProvinceDiNascita
		{
			return new VoOutputProvinceDiNascitaImpl(_body);
		}
	}
}
	import it.lisit.siss.flex.communication.coop.voProvinceDiNascita.VoOutputProvinceDiNascita;
	import it.lisit.siss.flex.utility.xml.XPathUtility;
	import it.lisit.siss.flex.communication.coop.voProvinceDiNascita.VoListProvince;
	import it.lisit.siss.flex.communication.coop.voProvinceDiNascita.VoProvincia;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	

class VoOutputProvinceDiNascitaImpl extends VoOutputProvinceDiNascita
{
	public function VoOutputProvinceDiNascitaImpl(body:XML)
	{
		super();
		parsing(body);
	}
	private function getListProvince(province:XML):Array
	{
		var prov:XMLList 	= province.child( "Row" );
		var temp:Array		= new Array();
		for(var i:uint = 0;i<prov.length();i++)
		{
			var vo:VoProvinciaImpl = new VoProvinciaImpl( prov[i] );
			temp.push( vo );
		}
		return temp;
	}
	private function parsing(body:XML):void
	{
		var datas:String = XPathUtility.getNodeValue(body,"//data");
		var list:Array = new Array();
		if(datas!=null && datas.length>0)
		{
			var provincieXML:XML 	= new XML(datas);
			list					= getListProvince(provincieXML);
		}
		this.province 			= new VoListProvinceImpl(list);	
	}
}
class VoProvinciaImpl extends VoProvincia
{
	public function VoProvinciaImpl(prov:XML)
	{
		super();
		this.COD_PROV 	= prov.child( "COD_PROV" );
		this.DESC_DPROV = prov.child( "DESC_DPROV" );
	}
}
class VoListProvinceImpl extends VoListProvince
{
	private var orig:Array;
	public function VoListProvinceImpl(list:Array)
	{
		super();
		orig = list;
		this.iterator = new ArrayIterator( orig );
	}
	override public function toArray():Array
	{
		var temp:Array = new Array();
		var iter:ArrayIterator = new ArrayIterator( orig );
		while(iter.hasNext())
		{
			var item:ClonableValueObject = iter.next() as ClonableValueObject;
			temp.push( item );
		}
		return temp;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = this.toArray();
		return new VoListProvinceImpl( temp );
	}
}