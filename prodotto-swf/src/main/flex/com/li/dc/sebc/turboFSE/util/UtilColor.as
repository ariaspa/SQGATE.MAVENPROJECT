package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.model.vo.ConstAttributiFolder;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	
	public class UtilColor
	{
		public static const LABEL_LABEL:int = 0x009A00;
		public static const LABEL_VALUE:int = 0x000000;
		/* colore generico per tutte le viste che non ne hanno una propria */
		private static const COLOR:int = 0xFFFFFF;	
		/////////////////////////////////////////////////////////////////////
		private static function getColorStrEvent(idTipoEv:String):uint
		 {
		 	var color:uint = COLOR;
		 	switch(idTipoEv)
		 	{
		 		case ConstAttributiFolder.EVENTO_FARMACEUTICO:
		 		color = 0xC1C1FF;
		 		break;
		 		case ConstAttributiFolder.EVENTO_PSOCCORSO:
		 		color = 0xF9E69B;
		 		break;
		 		case ConstAttributiFolder.EVENTO_RICOVERO:
		 		color = 0xA9FFBC;
			 	break;
		 		case ConstAttributiFolder.EVENTO_SPECIALISTICO:
		 		color = 0xFFCECE;
			 	break;
		 	}
		 	return color;
		 }
		/////////////////////////////////////////////////////////////////////
		 
		/////////////////////////////////////////////////////////////////////
		 public static function getColorStr(str:String):uint
		 {
		 	var color:uint = COLOR;
		 	//
		 	switch(str)
		 	{
		 		case ConstAttributiFolder.TIPO_FOLDER_PSOCCORSO:
		 		case ConstAttributiFolder.TIPO_PSOCCORSO:
		 		case ConstAttributiFolder.TIPO_ALTRI_DOCUMENTI_PS:
		 			color = 0xF9E69B;
		 			break;
		 		case ConstAttributiFolder.TIPO_EPISODI_DI_DIAGNOSI_E_CURA:
			 		color = 0xE6E6E6;
			 		break;
		 		case ConstAttributiFolder.TIPO_FOLDER_RICOVERI:
		 		case ConstAttributiFolder.TIPO_RICOVERO:
		 		case ConstAttributiFolder.TIPO_ALTRI_DOCUMENTI_NOSO:
			 		color = 0xA9FFBC;
			 		break;
		 		case ConstAttributiFolder.TIPO_DIAGNOSTICA_STRUMENTALE_E_SPECIALISTICA_AMBULATORIALE:
		 		case ConstAttributiFolder.TIPO_IUP:
		 		case ConstAttributiFolder.TIPO_ALTRI_DOCUMENTI_IUP:
			 		color = 0xFFCECE;
			 		break;
		 		case ConstAttributiFolder.TIPO_VACCINAZIONI:
			 		color = 0xFFE27A;
			 		break;
		 		case ConstAttributiFolder.TIPO_PATIENTSUMMARY:
			 		color = 0xDCC1FF;
			 		break;
			 	case ConstAttributiFolder.TIPO_ALTRI_DOCUMENTI:
			 	case ConstAttributiFolder.TIPO_RETI_DI_PATOLOGIA:
			 	case ConstAttributiFolder.TIPO_RETE_NEFROLOGIA:
			 	case ConstAttributiFolder.TIPO_RETE_IMA:
			 	case ConstAttributiFolder.TIPO_RETE_UMA:
			 	case ConstAttributiFolder.TIPO_RETE_ONCOLOGICA_LOMBARDA:
			 		color = 0xFFBB82;
			 		break;
		 	} 
			return color;
		 }
		/////////////////////////////////////////////////////////////////////
		public static function getColorBCK(obj:Object):uint
	  	{
	  		var color:int = COLOR;
		 	if(obj is FolderTree)
		 	{
		 		var vo:FolderTree = obj as FolderTree; 
				if(vo.idStatoFolder!=null && vo.idStatoFolder.length>0 && vo.idStatoFolder.toUpperCase()=="OK")
				{
					color = getColorStr(vo.idTipoFolder);
				} 
		 	}else if(obj is EventoTree)
		 	{
		 		var vof:EventoTree = obj as EventoTree;
		 		if(vof.tipoEvento !=null)
		 			color = getColorStrEvent( vof.tipoEvento.codice);
		 	}else if(obj is DataLabelTree)
		 	{
		 		/*var dt:DataLabelTree	= obj as DataLabelTree;
		 		if(dt.value != null)
		 		{
		 			var value:String = dt.value; 
		 			color = getColorStrEvent(value);
			 		switch(value)
			 		{
			 			case "specialistico":
			 			color = getColorStrEvent(ConstAttributiFolder.EVENTO_SPECIALISTICO);
			 			break;
			 			case "ricovero":
			 			color = getColorStrEvent(ConstAttributiFolder.EVENTO_RICOVERO);
			 			break;
			 			case "farmaceutico":
			 			color = getColorStrEvent(ConstAttributiFolder.EVENTO_FARMACEUTICO);
			 			break;
			 			case "pronto soccorso":
			 			color = getColorStrEvent(ConstAttributiFolder.EVENTO_PSOCCORSO);
			 			break;
			 		}
		 		}*/
		 	}
			return color;
	  	}
	}
}