package it.lisit.siss.flex.communication.impl.soap
{
	import it.lisit.siss.flex.communication.IFactorySEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	/**
	 * Classe originaria di tutti i "Factory" di tipo SEB, che implementano prodotti di servizi che comunicano via SOAP.
	 * Hanno necessità di una costante che indica il context da utilizzare per la comunicazione 
	 * Il Context della libreria server/SEBP_COMMONFLEX di Luca Sartori.
	 * Diego Fossati
	 */
	public class FactorySEBSoap implements IFactorySEB
	{
		//=========================================================
		/* realizzo IFactorySEB */
		/* nelle sub class fare l'override  di questi due campi */
		public function get version():String
		{
			return "1.00";
		}
		public function get author():String
		{
			return "Diego Fossati - Marco Salonia";
		}
		//=========================================================
		protected var communicator:ICommunicatorSoap;
		public function FactorySEBSoap( communicator:ICommunicatorSoap )
		{
			this.communicator = communicator;
		}
	}
}