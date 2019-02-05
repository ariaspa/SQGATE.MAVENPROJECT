package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.IFactoryFSE;
	import it.lisit.siss.flex.communication.fse.service.AbstractApriPDT;
	import it.lisit.siss.flex.communication.fse.service.AbstractAutorizzaDCE2009_01;
	import it.lisit.siss.flex.communication.fse.service.AbstractCancellaDCEDaFolder;
	import it.lisit.siss.flex.communication.fse.service.AbstractChiudiPDT;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaEventiDaFlussi2009_01;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaFascicolo;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaFascicolo2009;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaStoricoDCE;
	import it.lisit.siss.flex.communication.fse.service.AbstractCopiaDCEInPDT;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniDocumentoCDA2;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniDocumentoTestuale;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniIndiceFascicolo;
	import it.lisit.siss.flex.communication.fse.service.AbstractRichiediUrlTestoReferto;
	import it.lisit.siss.flex.communication.impl.soap.FactorySEBSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	/**
	 *
	 * @author Marco Salonia
	 *
	 */
	public class FactorySoapFSE04 extends FactorySEBSoap implements IFactoryFSE
	{
		/**
		 * communicator indica il comunicatore da utilizzare per le chiamate al servizio
		 * @param communicator:ICommunicatorSoap
		 *
		 */
		public function FactorySoapFSE04(communicator:ICommunicatorSoap )
		{
			super( communicator );
		}
		public override function get version():String
		{
			return "1.00 - 07";
		}
		public override function get author():String
		{
			return "Marco Salonia";
		}
		////////////////////////////////////////////////////////////////
		public function getConsultaFascicolo():AbstractConsultaFascicolo
		{
			return new SoapConsultaFascicolo(this.communicator);
		}

		public function getApriPDT():AbstractApriPDT
		{
			return new SoapApriPDT(this.communicator);
		}
		public function getChiudiPDT():AbstractChiudiPDT
		{
			return new SoapChiudiPDT(this.communicator);
		}
		public function getCopiaDCEInPDT():AbstractCopiaDCEInPDT
		{
			return new SoapCopiaDCEInPDT(this.communicator);
		}
		public function getAutorizzaDCE():AbstractAutorizzaDCE2009_01
		{
			return new SoapAutorizzaDCE2009_01(this.communicator);
		}
		public function getConsultaEventiDaFlussi():AbstractConsultaEventiDaFlussi2009_01
		{
			return new SoapConsultaEventiDaFlussi2009_01(this.communicator);
		}
		public function getOttieniDocumentoTestuale():AbstractOttieniDocumentoTestuale
		{
			return new SoapOttieniDocumentoTestuale(this.communicator);
		}
		public function getOttieniDocumentoCDA2():AbstractOttieniDocumentoCDA2
		{
			return new SoapOttieniDocumentoCDA2(this.communicator);
		}
		public function getOttieniIndiceFascicolo():AbstractOttieniIndiceFascicolo
		{
			return new SoapOttieniIndiceFascicolo(this.communicator);
		}
		public function getConsultaFascicolo2009():AbstractConsultaFascicolo2009
		{
			return new SoapConsultaFascicolo2009(this.communicator);
		}
		public function getCancellaDCEDaFolder():AbstractCancellaDCEDaFolder
		{
			return new SoapCancellaDCEDaFolder(this.communicator);
		}
		public function getConsultaStoricoDCE():AbstractConsultaStoricoDCE
		{
			return new SoapConsultaStoricoDCE(this.communicator);
		}
		public function getRichiediUrlTestoReferto():AbstractRichiediUrlTestoReferto
		{
			return new SoapRichiediUrlTestoReferto(this.communicator);
		}
	}
}