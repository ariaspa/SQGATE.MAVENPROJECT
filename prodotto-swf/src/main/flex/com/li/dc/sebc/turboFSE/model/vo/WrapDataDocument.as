package com.li.dc.sebc.turboFSE.model.vo
{
	import com.li.dc.sebc.turboFSE.model.ConstPrestazioni;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.graphic.timeline.model.DataDocument;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderFarmaceutico;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.Evento;
	import it.lispa.siss.sebc.middleground.entity.Farmaco;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	import it.lispa.siss.sebc.middleground.entity.Programmazione;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.collections.ArrayCollection;
	
	public class WrapDataDocument
	{
		public static const EV_RICOVERI_ER:String 					= "Eventi Ricoveri Erogati";
		public static const EV_PRONTO_SOCCORSO_ER:String 			= "Eventi Pronto Soccorso Erogati";
		public static const EVENTI_FARMACEUTICI_EROGATI:String 		= "Eventi Farmaceutici Erogati";
		public static const EVENTI_SPECIALISTICI_EROGATI:String 	= "Eventi Specialistici Erogati";
		/////////////////////////////////////////////////////////////////////////////////////////////////
		public static const EVENTI_RICOVERI_PROGRAMMATI:String  	= "Eventi Ricoveri Programmati";
		public static const EVENTI_FARMACEUTICI_PROGRAMMATI:String  = "Eventi Farmaceutici Programmati";
		public static const EVENTI_SPECIALISTICI_PROGRAMMATI:String = "Eventi Specialistici Programmati";
		public static const ALTRI_EVENTI_PROGRAMMATI:String 		= "Altri Eventi Programmati";		 
		////////////////////////////////////////////////////////////
		public static const VISITA_SPECIALISTICA:String 			= "VISITA SPECIALISTICA";
		public static const REFERTO_DI_LABORATORIO:String 			= "REFERTO DI LABORATORIO";
		public static const REFERTO_DI_RADIOLOGIA:String 			= "REFERTO DI RADIOLOGIA";
		public static const LETTERA_DI_DIMISSIONE:String 			= "LETTERA DI DIMISSIONE";
		public static const VERBALE_DI_PRONTO_SOCCORSO:String 		= "VERBALE DI PRONTO SOCCORSO";
		public static const DOC_DI_PROG_CLINICO_ELETTRONICO:String 	= "DOCUMENTO DI PROGRAMMAZIONE CLINICO ELETTRONICO";
		public static const ALTRE_TIPOLOGIE:String 					= "ALTRE TIPOLOGIE";
		////////////////////////////////////////////////////////////
		
		
		public static const VISITA_SPECIALISTICA_I:int				= 1;
		public static const REFERTO_DI_LABORATORIO_I:int			= 2;
		public static const REFERTO_DI_RADIOLOGIA_I:int				= 3;
		public static const VERBALE_DI_PRONTO_SOCCORSO_I:int		= 4;
		public static const LETTERA_DI_DIMISSIONE_I:int				= 5;
		public static const DOC_DI_PROG_CLINICO_ELETTRONICO_I:int	= 26;
		 
		
		
		////////////////////////////////////////////////////////////
		public var tipologiaDati:String 	= null;
		public var tipologiaDCE:String 		= null;
		public var PDT:ArrayCollection		= null;	
		public var farmaco:ArrayCollection	= null;
		public var disciplina:String		= null;
		public var prestazione:String		= null;
		//////////////////////////////////////////////////////////// 
		private var doc:DataDocument;
		public function get dataDocument():DataDocument{return doc;}
		////////////////////////////////////////////////////////////
		public function WrapDataDocument(data:DataDocument)
		{
			doc = data;
			parse();
		}
		private function tipologiaDatiParse():String
		{
			if(doc.data is Evento)
			{
				var evv:Evento	= doc.data as Evento;
				if(evv.attributiSpecificiFolder!=null)
				{
					var t:int = evv.attributiSpecificiFolder.tipo; 
					switch(t)
					{
						// Eventi Ricoveri Erogati
						case ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO: 
							return EV_RICOVERI_ER;
						// Eventi Pronto Soccorso Erogati
						case ConstAttributiSpecificiFolder.ATTRIBUTI_PS:
							return EV_PRONTO_SOCCORSO_ER;
						// Eventi Farmaceutici Erogati
						case ConstAttributiSpecificiFolder.ATTRIBUTI_FARMACI:
							return EVENTI_FARMACEUTICI_EROGATI;
						// Eventi Specialistici Erogati
						case ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE:
							return EVENTI_SPECIALISTICI_EROGATI;
					}				
				} 
			}else if(doc.data is Programmazione)
			{
				var pro:Programmazione 	= doc.data as Programmazione;
				var code:String 		= pro.tipoPrestazione.codice; 
				switch(code)
	 			{
	 				case  ConstPrestazioni.FARMACEUTICA:
	 					return EVENTI_FARMACEUTICI_PROGRAMMATI; 
	 				case  ConstPrestazioni.SPECIALISTICA_AMBULATORIALE:
	 				case  ConstPrestazioni.MMG:
	 					return EVENTI_SPECIALISTICI_PROGRAMMATI; 
	 				case  ConstPrestazioni.VACCINALE:
	 				case  ConstPrestazioni.ALTRE:
	 				case  ConstPrestazioni.AUTORILEVAZIONE:
	 				case  ConstPrestazioni.PROTESICA:
	 				case  ConstPrestazioni.ASSISTENZA:
	 				case  ConstPrestazioni.EDUCAZIONE:
	 				case  ConstPrestazioni.PRESTAZIONI:
	 				 	return ALTRI_EVENTI_PROGRAMMATI; 
	 			}
			} 
			return null;	
		}
		private function tipologiaDCEParse():String
		{
			if(doc.data is SetDocumentale)
			{
				var setDoc:SetDocumentale 	= doc.data as SetDocumentale;
				if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null)
				{
					var code:int = int(setDoc.tipoDocumento.codice);
					switch(code)
					{
						case VISITA_SPECIALISTICA_I:
							return VISITA_SPECIALISTICA;
						case REFERTO_DI_LABORATORIO_I:
							return REFERTO_DI_LABORATORIO;
						case REFERTO_DI_RADIOLOGIA_I:
							return REFERTO_DI_RADIOLOGIA;
						case LETTERA_DI_DIMISSIONE_I:
							return LETTERA_DI_DIMISSIONE;
						case VERBALE_DI_PRONTO_SOCCORSO_I:
							return VERBALE_DI_PRONTO_SOCCORSO;	
						case DOC_DI_PROG_CLINICO_ELETTRONICO_I:
							return DOC_DI_PROG_CLINICO_ELETTRONICO;	
						default: 
							return ALTRE_TIPOLOGIE;	
					}
				}
			}
			return null;	
		}
		private function PDTParse():ArrayCollection
		{
			if(doc.data is Programmazione)
			{
				var pro:Programmazione 	= doc.data as Programmazione;
				if(pro.listaPDT!=null && pro.listaPDT.length>0)
				{
					var iter:IIterator		 = new ArrayIterator(pro.listaPDT.toArray());
					var apdt:ArrayCollection = new ArrayCollection();
					
					while( iter.hasNext() )
					{
						var pdt:PercorsoDiagnosticoTerapeutico = iter.next() as PercorsoDiagnosticoTerapeutico;
						if(pdt!=null &&  pdt.PDT!=null && pdt.PDT.descrizione!=null && pdt.PDT.descrizione.length>0)
						{
							apdt.addItem( pdt.PDT.descrizione );
						}
					}
					if(apdt.length>0)
					{
						return apdt;
					}	
				}
			}
			return null;	
		}
		
		private function farmacoParse():ArrayCollection
		{
			if(doc.data is Evento)
			{
				var evv:Evento	= doc.data as Evento;
				if(evv.attributiSpecificiFolder.tipo==ConstAttributiSpecificiFolder.ATTRIBUTI_FARMACI)
				{
					if(evv.attributiSpecificiFolder is AttributiFolderFarmaceutico)
					{
						var frms:ArrayCollection = new ArrayCollection();
						var aFarm:AttributiFolderFarmaceutico = evv.attributiSpecificiFolder as AttributiFolderFarmaceutico;
						if(aFarm.elencoFarmaciErogati!=null && aFarm.elencoFarmaciErogati.length>0)
						{
							var iter:IIterator = new ArrayIterator( aFarm.elencoFarmaciErogati.toArray() );
							while(iter.hasNext())
							{
								var f:Farmaco = iter.next() as Farmaco;
								if(f.denominazioneCommerciale!=null && f.denominazioneCommerciale.descrizione!=null && f.denominazioneCommerciale.descrizione.length>0)
								{
									frms.addItem( f.denominazioneCommerciale.descrizione );
								}
							}
						}
						if(frms.length>0)
						{
							return frms;
						}
					}
				}
			}
			return null;	
		}
		private function disciplinaParse():String
		{
			if(doc.data is SetDocumentale)
			{
				var setDoc:SetDocumentale = doc.data as SetDocumentale;
				if(setDoc.disciplinaErogazione!=null && setDoc.disciplinaErogazione.descrizione!=null && setDoc.disciplinaErogazione.descrizione.length>0)
				{
					return setDoc.disciplinaErogazione.descrizione;					
				}
			}
			return null;	
		}
		private function prestazioneParse():String
		{
			if(doc.data is Programmazione)
			{
				var pro:Programmazione 	= doc.data as Programmazione;
				if(pro.prestazione!=null && pro.prestazione.descrizione!=null && pro.prestazione.descrizione.length>0)
				{
					return pro.prestazione.descrizione;		
				}
			}
			return null;	
		}
		private function parse()
		{
			tipologiaDati 	= tipologiaDatiParse();
			tipologiaDCE	= tipologiaDCEParse();
			PDT				= PDTParse();
			farmaco			= farmacoParse();
			disciplina		= disciplinaParse();
			prestazione		= prestazioneParse();
		}
	}
}





