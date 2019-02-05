package com.li.dc.sebc.turboFSE.model.vo
{
	public class ConstAttributiFolder
	{
		/* Folder */
		
		public static const TIPO_FARMACEUTICO:String = "31";
		
		
		public static const TIPO_PATIENTSUMMARY:String 		= "01";
		public static const TIPO_RETI_DI_PATOLOGIA:String 	= "02";
		public static const TIPO_ALTRI_DOCUMENTI:String 	= "03";
		public static const TIPO_RETE_ONCOLOGICA_LOMBARDA:String = "04";
		public static const TIPO_RETE_NEFROLOGIA:String = "08";
		public static const TIPO_RETE_IMA:String = "23";
		
		public static const TIPO_RETE_UMA:String = "10";
		
		public static const TIPO_EPISODI_DI_DIAGNOSI_E_CURA:String = "14";
		public static const TIPO_DIAGNOSTICA_STRUMENTALE_E_SPECIALISTICA_AMBULATORIALE:String = "15";
		
		
		public static const TIPO_IUP:String = "16";
		public static const TIPO_IUP_IN_CARTELLA_AMBULATORIALE:String = "18";

		
		public static const TIPO_FOLDER_RICOVERI:String = "19";
		public static const TIPO_RICOVERO:String = "20";
		public static const TIPO_FOLDER_PSOCCORSO:String = "21";
		public static const TIPO_PSOCCORSO:String = "22";
		public static const TIPO_VACCINAZIONI:String = "40";
		public static const TIPO_PDT:String = "51";
		
		public static const TIPO_PRERICOVERI:String = "81";
		
		
		public static const TIPO_ALTRI_DOCUMENTI_IUP:String 	= "41";
		public static const TIPO_ALTRI_DOCUMENTI_PS:String 		= "42";
		public static const TIPO_ALTRI_DOCUMENTI_NOSO:String 	= "43";
		//
		public static const TIPO_CATEGORIE:String 	= "70";
		
		//public static const TIPO_VACCINAZIONI:String = "99";
		
		//========================================================
		/*Eventi  */
		public static const EVENTO_SPECIALISTICO:String = "02";
		public static const EVENTO_FARMACEUTICO:String = "01";
		public static const EVENTO_RICOVERO:String = "03";
		public static const EVENTO_PSOCCORSO:String = "05";
		/* DCE */
		public static const DCE_REFERTO_SPECIALISTICA:String = "01";
		public static const DCE_REFERTO_LABORATORIO:String = "02";
		public static const DCE_REFERTO_RADIOLOGIA:String = "03";
		public static const DCE_PSOCCORSO:String = "04";
		public static const DCE_DIMISSIONI:String = "05";
		public static const DCE_ENOTE:String = "08";
		public static const DCE_PATTIENT_SUMMARY:String = "09";
		/* Attributi data Folder (filter)*/
		public static const ATR_FOLD_SOC_ORAINGRESSO:String = "dataOraIngresso";
		public static const ATR_FOLD_SOC_ORAUSCITA:String = "dataOraUscita";
		public static const ATR_FOLD_RIC_ORARICOVERO:String = "dataOraRicovero";
		public static const ATR_FOLD_RIC_PRERICOVERO:String = "dataPrericovero";
		public static const ATR_FOLD_RIC_ORADIMISSIONI:String = "dataOraDimissioni";
		public static const ATR_FOLD_SPE_PRESCRIZIONE:String = "dataPrescrizione";
		public static const ATR_FOLD_SPE_ACCETTAZIONE:String = "dataAccettazione";
		public static const ATR_FOLD_SPE_PRENOTAZIONE:String = "dataPrenotazione";
		//
		public static const ATR_DCE_REFERTO:String = "dataOraRichiesta";
		public static const ATR_DCE_DIMISSIONI:String = "dataOraAccettazione";
		public static const ATR_DCE_ENOTE:String = "dataOraIngressoEnote";
		public static const ATR_DCE_SOCCORSO:String = "dataOraIngressoSoccorso";
		public static const ATR_DCE_CREAZIONE:String = "dataOraCreazione";
		//
		public static const LAB_ACCESSO_AMBULATORIALE:String 	= "Accesso Ambulatoriale";
		public static const LAB_RICOVERO:String 				= "Ricovero";
	}
}