package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.ConstTipiAttributiFolder;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFPDT;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFPreRicovero;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiFolder;
	
	internal class ParserAttributiFolder implements IParserAttributiFolder
	{
		private var listQName:Array ;
		private var listQName_2:Array ;
		
		public function ParserAttributiFolder()
		{
			createListQname();
		}
		//=============================================================================
		private function createListQname():void
		{
			listQName = new Array();
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_AMBULATORIALE] 		= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_ambulatoriale/","attributi_ambulatoriale");
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_CLASSIFICAZIONE_CITT] 	= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_classificazione_citt/","attributi_classificazione_citt");
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_RICOVERO] 				= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_ricovero/","attributi_ricovero");
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_PS] 					= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_ps/","attributi_ps");
			
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_FARMACI] 				= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/attributi_farmaci/","attributi_farmaci");
			
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_VACCINAZIONI] 			= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/attributi_vaccinazioni/","attributi_vaccinazioni");
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_PRERICOVERO] 			= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/attributi_prericovero/","attributi_prericovero");
			listQName[ConstTipiAttributiFolder.ATTRIBUTI_PDT] 					= new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/attributi_pdt/","attributi_pdt");
			//////////////////////////////////////////////////
			listQName_2 = new Array();
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_AMBULATORIALE] 			= new QName("","attributi_ambulatoriale");
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_CLASSIFICAZIONE_CITT] 	= new QName("","attributi_classificazione_citt");
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_RICOVERO] 				= new QName("","attributi_ricovero");
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_PS] 						= new QName("","attributi_ps");
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_FARMACI] 				= new QName("","attributi_farmaci");
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_VACCINAZIONI] 			= new QName("","attributi_vaccinazioni");
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_PRERICOVERO] 			= new QName("","attributi_prericovero");
			listQName_2[ConstTipiAttributiFolder.ATTRIBUTI_PDT] 					= new QName("","attributi_pdt");		
		}
		//=============================================================================
		private function getAttributoSpecifico(attributi:XML,count:int=-1):VoAttributiFolder
		{
			trace("attributiattributi :"+attributi);
			switch(count)
			{
				case ConstTipiAttributiFolder.ATTRIBUTI_AMBULATORIALE:
					return new ParserAFAmbulatoriale( attributi ).execute();
				case ConstTipiAttributiFolder.ATTRIBUTI_CLASSIFICAZIONE_CITT:
					return new ParserAFClassificazioneCittadino( attributi ).execute();
				case ConstTipiAttributiFolder.ATTRIBUTI_RICOVERO:
					return new ParserAFRicovero( attributi ).execute();
				case ConstTipiAttributiFolder.ATTRIBUTI_PS:
					return new ParserAFPSoccorso( attributi ).execute();
				case ConstTipiAttributiFolder.ATTRIBUTI_FARMACI:
					return new ParserAFFarmaci( attributi ).execute();
				case ConstTipiAttributiFolder.ATTRIBUTI_VACCINAZIONI:
					return new ParserAFVaccinazioni( attributi ).execute();
				case ConstTipiAttributiFolder.ATTRIBUTI_PRERICOVERO:
					return new ParserAFPrericovero( attributi ).execute();
				case ConstTipiAttributiFolder.ATTRIBUTI_PDT:
					return new ParserAttributiPDT( attributi ).execute();
			}	
			return null;
		}
		//=============================================================================
		public function getAttributi(attributi:XML,param:Object=null):VoAttributiFolder
		{
			var hasChild:Boolean		= (attributi.children().length() >0);
			var voAttFolder:VoAttributiFolder = null;
			var attSpecifici:XMLList;
			var qname:QName;
			// provo con il namespace da documento
		 	for(var i:uint = 0;i<listQName.length;i++)
		 	{
		 		qname 			= listQName[i] as QName;
		 		attSpecifici 	= attributi[qname];
		 		if(attSpecifici!=null && attSpecifici.length()>0)
				{
					voAttFolder = getAttributoSpecifico(attSpecifici[0],i);
					break;
				}
		 	}
		 	// non ho trovato nulla provo con namespace dell'envelope
			if(voAttFolder==null)
			{
				var urinameSpace:String	= QName(attributi.name()).uri;
				for(i = 0;i<listQName_2.length;i++)
			 	{
			 		qname			= listQName_2[i] as QName;
			 		qname			= new QName(urinameSpace,qname.localName);
			 		
			 		attSpecifici 	= attributi[qname];
			 		if(attSpecifici!=null && attSpecifici.length()>0)
					{
						voAttFolder = getAttributoSpecifico(attSpecifici[0],i);
						break;
					}
			 	}
			} 
			// non è stato trovato un attributo specifico corrispondente, ma il tag contiene dei figli
			// istanzio quello generico			
		 	if(voAttFolder==null && hasChild)
		 	{
		 		voAttFolder = new VoAttributiFolder();
		 	}
			return voAttFolder;
		}
	}
}