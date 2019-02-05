package it.lisit.siss.flex.communication.exception
{
	public class SebException extends Error
	{
		/* censiti per ora i servizi sviluppati, il valore aumenta per ogni servizio di 500 alla volta */
		//////////////////////////////////////
		public static const IMPL_ERROR:uint = 0;
		//////////////////////////////////////
		public static const COOP_ERROR:uint = 500;
		/* aggiungere qui */
		public static const FSE_ERROR:uint = 1000;
		/* aggiungere qui */
		public static const GAN_ERROR:uint = 1500;
		/* aggiungere qui */
		public static const ICCE_ERROR:uint = 2000;
		/* aggiungere qui */
		public static const UTIL_ERROR:uint = 2500;
		public static const CRM_ERROR:uint = 3000;
		/* aggiungere qui */
		/* ----------------------------------------------------- */
		public function SebException( message:String="",id:int=0)
		{
			super(message,id);
		}
	}
}