package com.li.dc.sebc.turboFSE.business.soapPdlService.coop
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.coop.IFactoryCOOP;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceComuniDiNascita;
	import it.lisit.siss.flex.communication.coop.voComuniDiNascita.VoComune;
	import it.lisit.siss.flex.communication.coop.voComuniDiNascita.VoOutputComuniDiNascita;
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Comune;

	public class ComuniService extends COOPService
	{
		public var codiceProvincia:String;
		public function ComuniService(factory:IFactoryCOOP=null)
		{
			super(factory);
		}
		override protected function getService():AbstractServiceSEB
		{
			return factoryCoop.getServiceComuniDiNascita() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			Debug.logDebug( "ComuniService . executeService " );
			(this.serviceSEB as AbstractServiceComuniDiNascita).getElenco( codiceProvincia );
		}
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			var iter:IIterator = new ArrayIterator( esitiPositivi );
			var comuni:Array = new Array();
			while(iter.hasNext())
			{
				var item:VoOutputComuniDiNascita  = iter.next() as VoOutputComuniDiNascita;
				comuni = comuni.concat( item.comuni.toArray() );
			}
			var result:Array = new Array();
			var iterComuni:IIterator = new ArrayIterator(comuni);
			while(iterComuni.hasNext())
			{
				var vo:VoComune 		= iterComuni.next() as VoComune;
				var comune:Comune 		= new Comune();
				comune.codiceIstat		= vo.COD_CCOMU; 
				comune.descrizione		= vo.DESC_DCOMU;
				result.push( comune );
			}
			return result as Object;
		}
	}
}