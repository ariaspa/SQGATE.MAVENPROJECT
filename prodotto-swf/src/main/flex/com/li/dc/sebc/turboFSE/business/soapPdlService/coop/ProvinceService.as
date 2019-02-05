package com.li.dc.sebc.turboFSE.business.soapPdlService.coop
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.coop.IFactoryCOOP;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceProvincieDiNascita;
	import it.lisit.siss.flex.communication.coop.voProvinceDiNascita.VoOutputProvinceDiNascita;
	import it.lisit.siss.flex.communication.coop.voProvinceDiNascita.VoProvincia;
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Provincia;

	public class ProvinceService extends COOPService
	{
		public function ProvinceService(factory:IFactoryCOOP=null)
		{
			super(factory);
		}
		override protected function getService():AbstractServiceSEB
		{
			return factoryCoop.getServiceProvincieDiNascita() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			Debug.logDebug( "ProvinceService . executeService " );
			(this.serviceSEB as AbstractServiceProvincieDiNascita).getElenco()
		}
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			var province:Array = new Array();
			var iter:IIterator = new ArrayIterator(esitiPositivi);
			while(iter.hasNext())
			{
				var vo:VoOutputProvinceDiNascita =  iter.next() as VoOutputProvinceDiNascita;
				var taArr:Array	= vo.province.toArray()
				province = province.concat( taArr );
			}
			var result:Array = new Array();
			var iterProvince:IIterator = new ArrayIterator(province);
			while(iterProvince.hasNext())
			{
				var vop:VoProvincia 		= iterProvince.next() as VoProvincia;
				var provincia:Provincia		= new Provincia();
				provincia.codiceIstat		= vop.COD_PROV;
				provincia.descrizione		= vop.DESC_DPROV;
				result.push( provincia );
			}
			return result as Object;
		}
	}
}