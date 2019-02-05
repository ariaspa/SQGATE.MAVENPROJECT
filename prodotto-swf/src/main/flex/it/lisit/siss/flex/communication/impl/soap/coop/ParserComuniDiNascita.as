package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.coop.voComuniDiNascita.VoOutputComuniDiNascita;
	
	internal class ParserComuniDiNascita
	{
		private var _body:XML
		public function ParserComuniDiNascita(body:XML)
		{
			_body = body;
		}
		public function execute():VoOutputComuniDiNascita
		{
			return new VoOutputComuniDiNascitaImpl(_body);
		}
	}
}
	import it.lisit.siss.flex.communication.coop.voComuniDiNascita.VoOutputComuniDiNascita;
	import it.lisit.siss.flex.utility.xml.XPathUtility;
	import it.lisit.siss.flex.communication.coop.voComuniDiNascita.VoComune;
	import it.lisit.siss.flex.communication.coop.voComuniDiNascita.VoListComuni;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.debug.Debug;
	

class VoOutputComuniDiNascitaImpl extends VoOutputComuniDiNascita
{
	public function VoOutputComuniDiNascitaImpl(body:XML)
	{
		super();
		parsing(body);
	}
	private function parsing(body:XML):void
	{
		Debug.logWarning("VoOutputComuniDiNascita.parsing.body :: " +body);
		var datas:String = XPathUtility.getNodeValue(body,"//data");
		Debug.logWarning("VoOutputComuniDiNascita.parsing.data :: " +datas);
		var list:Array = new Array();
		if(datas!=null && datas.length>0)
		{
			var comuniXML:XML 		= new XML(datas);
			list					= getListComuni(comuniXML);
		}
		this.comuni 			= new VoListComuniImpl(list);	
	}
	private function getListComuni(comuni:XML):Array
	{
		var comm:XMLList 	= comuni.child( "Row" );
		var temp:Array		= new Array();
		for(var i:uint = 0;i<comm.length();i++)
		{
			var vo:VoComuneImpl = new VoComuneImpl( comm[i] );
			temp.push( vo );
		}
		return temp;
	}
}
class VoListComuniImpl extends VoListComuni
{
	private var orig:Array;
	public function VoListComuniImpl(list:Array)
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
		Debug.logWarning("VoListComunitoArraytoArraytoArraytoArray :: " +temp);
		return temp;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = this.toArray();
		return new VoListComuniImpl( temp );
	}
}
class VoComuneImpl extends VoComune
{
	public function VoComuneImpl(comm:XML)
	{
		super();
		this.COD_CCOMU 	= comm.child( "COD_CCOMU" );
		this.DESC_DCOMU = comm.child( "DESC_DCOMU" );
	}
}