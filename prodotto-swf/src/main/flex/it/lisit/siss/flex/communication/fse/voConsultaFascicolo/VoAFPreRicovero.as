package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	public class VoAFPreRicovero extends VoAttributiFolder
	{
		public function VoAFPreRicovero()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_PRERICOVERO;
		}
	}
}