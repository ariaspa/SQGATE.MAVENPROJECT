package it.lisit.siss.flex.communication.fse
{
	import it.lisit.siss.flex.communication.IFactorySEB;
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

	public interface IFactoryFSE extends IFactorySEB
	{
		/**
		 * AbstractConsultaFascicolo service 2008
		 * @return
		 *
		 */
		function getConsultaFascicolo():AbstractConsultaFascicolo;
		function getConsultaEventiDaFlussi():AbstractConsultaEventiDaFlussi2009_01;
		function getApriPDT():AbstractApriPDT;
		function getChiudiPDT():AbstractChiudiPDT;
		function getCopiaDCEInPDT():AbstractCopiaDCEInPDT;
		function getAutorizzaDCE():AbstractAutorizzaDCE2009_01;
		function getOttieniDocumentoTestuale():AbstractOttieniDocumentoTestuale;
		function getOttieniDocumentoCDA2():AbstractOttieniDocumentoCDA2;
		function getOttieniIndiceFascicolo():AbstractOttieniIndiceFascicolo;
		function getConsultaFascicolo2009():AbstractConsultaFascicolo2009;
		function getCancellaDCEDaFolder():AbstractCancellaDCEDaFolder;
		function getConsultaStoricoDCE():AbstractConsultaStoricoDCE;
		function getRichiediUrlTestoReferto():AbstractRichiediUrlTestoReferto;
	}
}