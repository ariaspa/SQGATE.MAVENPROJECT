package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.dataProxy.DataConfiguration;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.model.vo.PopupConfig;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.graphic.timeline.model.DataDocument;
	import it.lispa.siss.sebc.flex.htmlTag.Anchor;
	import it.lispa.siss.sebc.flex.htmlTag.ArrayTag;
	import it.lispa.siss.sebc.flex.htmlTag.Bold;
	import it.lispa.siss.sebc.flex.htmlTag.Break;
	import it.lispa.siss.sebc.flex.htmlTag.FontTag;
	import it.lispa.siss.sebc.flex.htmlTag.HTMLTag;
	import it.lispa.siss.sebc.flex.htmlTag.Italic;
	import it.lispa.siss.sebc.flex.htmlTag.ListTag;
	import it.lispa.siss.sebc.flex.htmlTag.Paragraph;
	import it.lispa.siss.sebc.flex.htmlTag.Tex;
	import it.lispa.siss.sebc.flex.htmlTag.Underline;
	import it.lispa.siss.sebc.middleground.entity.Ambulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderAmbulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderFarmaceutico;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderRicovero;
	import it.lispa.siss.sebc.middleground.entity.Caratterizzazione;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.Dipendenza;
	import it.lispa.siss.sebc.middleground.entity.Evento;
	import it.lispa.siss.sebc.middleground.entity.Farmaco;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	import it.lispa.siss.sebc.middleground.entity.Prestazione;
	import it.lispa.siss.sebc.middleground.entity.Programmazione;
	import it.lispa.siss.sebc.middleground.entity.ProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.Ricovero;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.utils.StringUtil;
	
	public class BodyPopUpVT
	{
		private static const ENTE:String 			= "Ente : ";
		private static const FARMACIA:String 		= "Farmacia : ";
		private static const PRESIDIO:String 		= "Presidio : ";
		private static const REPARTO:String 		= "Reparto : ";
		private static const DISCIPLINA:String 		= "Disciplina : ";
		private static const TIPOLOGIA:String 		= "Tipologia : ";
		private static const DESCRIZIONE:String 	= "Descrizione : ";
		private static const INTERVALLO:String 		= "Intervallo temporale : ";
		private static const PDT_ASSOCIATO:String 	= "PDT Associato :";
		private static const PDT_ASSOCIATI:String 	= "PDT Associati :";
		private static const DATA_EROGAZIONE:String = "Data erogazione : ";
		private static const DATA_FINE_VALID:String = "Data fine validità : ";
		private static const DO_ACCETTAZIONE:String = "Data e ora accettazione : ";
		private static const DO_DIMISSIONI:String 	= "Data e ora dimissione : ";
		private static const DIAGNOSI_DIMI:String 	= "Diagnosi di dimissione : ";
		private static const DOCUMENTO:String 		= "Visualizza documento";
		///////////////////////////////////////////////////////////
		private static const DIZIONARIO_PDT:String 	= "2.16.840.1.113883.2.9.2.30.3.1.6.11";
		///////////////////////////////////////////////////////////
		private static function extractDesc(dt:DatoCodificato):String
		{
			if(checkDCDesc(dt))
			{
				return trm(dt.descrizione);
			}
			return "";
		}
		
		private static function extractCod(dt:DatoCodificato):String
		{
			if( checkDCCod( dt ) )
			{
				return trm( dt.codice );
			}
			return "";
		}
		
		private static function trm(s:String):String
		{
			var ss:Array 	= s.split("\n");
			var rs:String 	= ""; 
			var i:IIterator = new ArrayIterator(ss);
			while(i.hasNext())
			{
				rs += " "+StringUtil.trim( i.next() as String ); 
			}
			return  rs;
		}
		
		// check dato codificato descrizione 
		private static function checkDCDesc(dt:DatoCodificato):Boolean
		{
			return (dt!=null && dt.descrizione!=null && dt.descrizione.length>0);
		}
		
		// check dato codificato codice
		private static function checkDCCod(dt:DatoCodificato):Boolean
		{
			return (dt!=null && dt.codice!=null && dt.codice.length>0);
		}
		
		/**
		 * formattazione del codice e della descrizione 
		 * @param cod
		 * @param desc
		 * @return 
		 * 
		 */		
		private static function fCD(cod:String,desc:String):String
		{
			if(cod.length>0 )
			{
				return desc + " ( "+cod+" ) ";
			}
			return desc;
		} 
		
		private static function getBodyProgrammazione(item:DataDocument):String
		{
			var pro:Programmazione 		= item.data as Programmazione;
			//
			var fontTag:FontTag 		= getInitialFontTag();
			// (Descrizione tipologia prestazione -> )Tipologia :
			var descrTipologia:String	= extractDesc(pro.tipoPrestazione);
			if(descrTipologia!=null && descrTipologia.length>0)
			{
				addLineTag(fontTag,TIPOLOGIA,descrTipologia);
			}
			// (Descrizione prestazione -> )Descrizione :  descr + (cod)
			var cdPrestazione:String   	= fCD(extractCod(pro.prestazione),extractDesc(pro.prestazione))
			if(cdPrestazione!=null && cdPrestazione.length>0)
			{
				addLineTag(fontTag,DESCRIZIONE,cdPrestazione);
			} 
			// intervallo temporale : data1 - data2
			if(item.dateIni!=null && item.dateEnd!=null)
			{
				var ini:String = UtilDate.formatterDate(item.dateIni);	
				var end:String = UtilDate.formatterDate(item.dateEnd);
				addLineTag(fontTag,INTERVALLO,ini + " - " + end);
			}
			// Prestazioni correlate :
				// 
				// elenco puntato
			var iter:IIterator;
			if(pro.listaDipendenze!=null && pro.listaDipendenze.length>0)
			{
				var para:Paragraph = new Paragraph(new Bold(new Tex("Prestazioni correlate : ")),Paragraph.LEFT);
				iter		= new ArrayIterator(pro.listaDipendenze.toArray());
				while(iter.hasNext())
				{
					var dip:Dipendenza 	= iter.next() as Dipendenza;
					var desc:String    	= (dip.distanzaRelativa!=null) ? trm(dip.distanzaRelativa) : "";
					var id:String      	= (dip.idPrestazione!=null) ? trm(dip.idPrestazione) : "";
				 	if(id.length>0)
				 	{
				 		addLineListTag(para,fCD(desc,id));	
				 	}
				}
				// sono sicuro che almeno un item èstato aggiunto
				if(para.length>0){
					fontTag.addChild( para ); 
				}
			}	
			//	
			// PDT associato :   	
			if(pro.listaPDT!=null && pro.listaPDT.length>0)
			{
				fontTag.addChild(new Break());
				var pdt:PercorsoDiagnosticoTerapeutico   = pro.listaPDT.toArray()[0];
				var testo:String = fCD( extractCod(pdt.PDT), extractDesc(pdt.PDT) );
				if(testo.length>0) 
				{
					addLineTag(fontTag,PDT_ASSOCIATO,testo);
				}
			}
			//Identificativo Set Documentale relativo
			/* if(pro.idSetDocumenti!=null && pro.idSetDocumenti.length>0)
			{
				arrayTag.addChild( new FontTag( new Tex("Identificativo Set Documentale "+trm( pro.idSetDocumenti )),HTMLTabColor.BLACK,12) );
			} */ 
			return fontTag.getString();
		}  
		private static function getBodyEventoRicovero(attric:AttributiFolderRicovero):String
		{
			if(attric.datiRicovero!=null)
			{
				//---------ESTRAGGO I DATI----------------------
				// Descrizione ente, presidio e reparto
				var descrizioneEPR:String = "";
				var ric:Ricovero 	= attric.datiRicovero;
				
				var ente:String		= extractDesc(ric.strutturaErogazione);
				var presidio:String	= extractDesc(ric.presidio);
				var reparto:String	= extractDesc(ric.repartoRicovero);
				
				// Data e ora accettazione	
				var dataRic:String 	= "";
				if(ric.dataOraRicovero!=null)
				{
					dataRic			= UtilDate.getStringDataAndOra(ric.dataOraRicovero);	 
				}
				// Data e ora dimissione
				var dataDimi:String	= "";
				if(ric.datiDimissione!=null && ric.datiDimissione.dataOraDimissione!=null)
				{
					dataDimi = UtilDate.getStringDataAndOra(ric.datiDimissione.dataOraDimissione);
				}
				// Diagnosi dimissione
				var diagnosiDimi:String	= "";
				if(ric.datiDimissione!=null && ric.datiDimissione.diagnosi!=null && ric.datiDimissione.diagnosi.descrizioneDiagnosi!=null)
				{
					diagnosiDimi = trm(ric.datiDimissione.diagnosi.descrizioneDiagnosi);
				}
				/////////////////////////////////////////////////////////////////////////////////////////////////
				var fontTag:FontTag 		= getInitialFontTag();
				addLineTag(fontTag,ENTE,ente);
				addLineTag(fontTag,PRESIDIO,presidio);
				addLineTag(fontTag,REPARTO,reparto);
				addLineTag(fontTag,DIAGNOSI_DIMI,diagnosiDimi);
				fontTag.addChild( new Break() );
				// 
				addLineTag(fontTag,DO_ACCETTAZIONE,dataRic); 
				addLineTag(fontTag,DO_DIMISSIONI,dataDimi);
				// 
				return fontTag.getString();
			}
			return "";
		}
		
		private static function addLineListTag(line:HTMLTag,value:String):void
		{
			if(value.length>0 && line!=null)
			{
				var list:ListTag = new ListTag();
				list.addChild( new Italic( new Tex(value) ) );
				line.addChild( list );
			}
		}
		
		private static function addLineTag(line:HTMLTag,test:String,value:String):void
		{
			if(value.length>0 && line!=null)
			{
				line.addChild(new Bold(new Tex(test)));
				line.addChild(new Italic(new Tex(value)));
				line.addChild(new Break()); 
			}
		}
		private static function getInitialFontTag():FontTag
		{
			var fontTag:FontTag = new FontTag(new Break(),HTMLTabColor.BLACK,12,"Trebuchet MS");
			fontTag.addChild(new Break());
			return fontTag;
		}
		
		private static function getBodyEventoPS(attps:AttributiFolderProntoSoccorso):String
		{
			if(attps.datiProntoSoccorso!=null)
			{
				//------ESTRAZIONE----------------------------------------
				// Descrizione ente, presidio
				var ps:ProntoSoccorso 	= attps.datiProntoSoccorso;
				var der:String			= "";
				var descEnte:String 	= ""; 
				if(ps.struttura!=null)
				{
					descEnte 			= extractDesc( ps.struttura.ente );
				}
				var descPress:String 	= extractDesc( ps.presidio );
				//Data e ora accettazione
				var dataIngresso:String = "";
				if(ps.dataOraIngresso!=null && ps.dataOraIngresso.length>0)
				{
					dataIngresso = UtilDate.getStringDataAndOra(ps.dataOraIngresso);
				}
				// Data e ora dimissione
				var dataDimissione:String = "";
				if(ps.datiDimissione!=null && ps.datiDimissione.dataOraDimissione!=null)
				{
					dataDimissione = UtilDate.getStringDataAndOra( ps.datiDimissione.dataOraDimissione );
				}
				// Diagnosi dimissione
				var diagnosi:String		= "";
				if(ps.datiDimissione!=null && ps.datiDimissione.dataOraDimissione!=null)
				{
					diagnosi 	= extractDesc( ps.datiDimissione.diagnosiPrincipaleDimissione );
				}
				//////////////////////////////////////////////////////////////////////////////////
				var fontTag:FontTag 		= getInitialFontTag();
				addLineTag(fontTag,ENTE,descEnte);
				addLineTag(fontTag,PRESIDIO,descPress);
				addLineTag(fontTag,DIAGNOSI_DIMI,diagnosi);
				fontTag.addChild( new Break() );
				addLineTag(fontTag,DO_ACCETTAZIONE,dataIngresso); 
				addLineTag(fontTag,DO_DIMISSIONI,dataDimissione); 
				return fontTag.getString();
			}
			return "";
		}
		
		
		private static function getBodyEventoFarma(attf:AttributiFolderFarmaceutico):String
		{
			var fontTag:FontTag 		= getInitialFontTag();
			// Descrizione Farmacia
			addLineTag(fontTag,FARMACIA,extractDesc( attf.struttura ));
			// Data erogazione
			if(attf.dataErogazione!=null && attf.dataErogazione.length>0)
			{
				 addLineTag(fontTag,DATA_EROGAZIONE,UtilDate.getStringDataAndOra( attf.dataErogazione ));
			}
			// Elenco Farmaci (codice e descrizione)
			if(attf.elencoFarmaciErogati!=null && attf.elencoFarmaciErogati.length>0)
			{
				var para:Paragraph = new Paragraph(new Bold(new Tex("Elenco farmaci : ")),Paragraph.LEFT);
				var iter:IIterator	= new ArrayIterator(attf.elencoFarmaciErogati.toArray());
				while(iter.hasNext())
				{
					var f:Farmaco 		= iter.next() as Farmaco;
					var desc:String		= extractDesc(f.denominazioneCommerciale);
					var cod:String		= extractCod(f.denominazioneCommerciale);
					if(desc.length>0)
					{ 
						addLineListTag(para,(cod.length>0) ? "( "+cod+" ) ":"" + desc);
					}
				}
				if(para.length>0)
				{
					fontTag.addChild( new Break() );
					fontTag.addChild( para );
				}
			}
			return fontTag.getString();
		}
		
		private static function getBodyEventoSpeci(atts:AttributiFolderAmbulatoriale):String
		{
			if(atts.attributiAmbulatoriale!=null)
			{
				var fontTag:FontTag 		= getInitialFontTag(); 
				var amb:Ambulatoriale 	= atts.attributiAmbulatoriale as Ambulatoriale;
				// Descrizione ente, presidio
				var dep:String			= "";
				var ente:String 		= "";
				if(amb.struttura!=null)
				{
					ente 	= extractDesc(amb.struttura.ente);
					fontTag.addChild( new Break() ); 
					addLineTag(fontTag,ENTE,ente);
				} 
				var press:String = extractDesc(amb.presidio);
				addLineTag(fontTag,PRESIDIO,press);
				// Data erogazione
				if(amb.dataAccettazione!=null){
					 
					addLineTag(fontTag,DO_ACCETTAZIONE,UtilDate.getStringDataAndOra( amb.dataAccettazione ));
				}
				// Elenco prestazioni (codice e descrizione)
				var prest:String = "";
				if(amb.prestazioniAssociate!=null && amb.prestazioniAssociate.length>0)
				{
					var para:Paragraph = new Paragraph(new Bold(new Tex("Elenco prestazioni")),Paragraph.LEFT);
					var iter:IIterator = new ArrayIterator( amb.prestazioniAssociate.toArray() );
					while(iter.hasNext())
					{
						var p:Prestazione 		= iter.next() as Prestazione;
						var dc:DatoCodificato 	= new DatoCodificato(p.descrizione,p.codice);
						var codice:String 		= extractCod(dc);
						var desc:String 		= extractDesc(dc);
						if(desc.length>0)
						{
							addLineListTag( para, desc + (codice.length>0) ? "( "+codice+" )":"" );
						}
					}
					if(para.length>0)
					{
						fontTag.addChild( new Break() ); 
						fontTag.addChild( para ); 
					}
				}
				return fontTag.getString();
			}
			return "";
		}
		
		private static function getBodyEvento(evv:Evento):String
		{
			//
			// Ente :  A.O. S.ANNA - COMO
			//
			//Data e ora accettazione : 12/01/2006
			//Data e ora dimissione : 13/01/2006 - 00.00.00
			  
			if(evv.attributiSpecificiFolder.tipo==ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO)
			{
				// 2.POPUP EVENTO RICOVERO EROGATO
				return getBodyEventoRicovero( evv.attributiSpecificiFolder as AttributiFolderRicovero);	
			}else if(evv.attributiSpecificiFolder.tipo==ConstAttributiSpecificiFolder.ATTRIBUTI_PS)
			{
				// 3.POPUP EVENTO PRONTO SOCCORSO EROGATO
				return getBodyEventoPS(evv.attributiSpecificiFolder as AttributiFolderProntoSoccorso);
			}else if(evv.attributiSpecificiFolder.tipo==ConstAttributiSpecificiFolder.ATTRIBUTI_FARMACI)
			{
				// 4.POPUP EVENTO FARMACEUTICO EROGATO
				return getBodyEventoFarma(evv.attributiSpecificiFolder as AttributiFolderFarmaceutico);
			}else if(evv.attributiSpecificiFolder.tipo==ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE)
			{
				// 5.POPUP EVENTO SPECIALISTICO EROGATO
				return getBodyEventoSpeci(evv.attributiSpecificiFolder as AttributiFolderAmbulatoriale);
			}
			return "";
		}
		 
		private static function getBodyDoc(item:DataDocument):String
		{
			// Ente :
			// Disciplina :
			// Data ora creazione :
			// (se tipo 26)Data fine validità : 
			//
			// PDT Associati :
			//
			// (icona )Visualizza documento(forma link) 
			 
			var evv:SetDocumentale = item.data as SetDocumentale;
			 
			var fontTag:FontTag 		= getInitialFontTag();
			// Ente :
			if(evv.strutturaArchiviazione!=null)
			{
				var descEnte:String = extractDesc(evv.strutturaArchiviazione.ente);
				if(descEnte.length)
				{
					addLineTag(fontTag,ENTE,descEnte);
				}
			}
			// Disciplina :
			if(evv.disciplinaErogazione!=null)
			{
				var descDiscErr:String = extractDesc(evv.disciplinaErogazione);
				if(descDiscErr.length)
				{
					addLineTag(fontTag,DISCIPLINA,descDiscErr);
				}	
			}
			// Data ora creazione :
			if( evv.dataOraCreazione!=null && evv.dataOraCreazione.length>0)
			{
				addLineTag(fontTag,DATA_EROGAZIONE,UtilDate.getStringData( evv.dataOraCreazione ) );
			}
			// (se tipo 26)Data fine validità :  
			if(item.dateEnd!=null)
			{
				addLineTag(fontTag,DATA_FINE_VALID,UtilDate.formatterDate(item.dateEnd) );
			}	
			//
			// PDT Associati :addLineTag(fontTag,DATA_FINE_VALID,UtilDate.formatterDate(item.dateEnd) );
			//
			if(evv.caratterizzazioniCliniche!=null && evv.caratterizzazioniCliniche.length>0)
			{
				var para : Paragraph = new Paragraph(new Bold(new Tex(PDT_ASSOCIATI)),Paragraph.LEFT);
				var iter:IIterator = new ArrayIterator(evv.caratterizzazioniCliniche.toArray());
				while(iter.hasNext())
				{
					var car:Caratterizzazione = iter.next() as Caratterizzazione;
					if(car.dizionario!=null && car.dizionario==DIZIONARIO_PDT)
					{
						if(car.codice!=null && car.codice.length>0)
						{
							addLineListTag(para,"PDT : "+car.codice);
						}
					}
				}	
				if(para.length>0)
				{
					fontTag.addChild( para );
					fontTag.addChild( new Break());
				}
			} 
			 
			var tags:Array = new Array();
			tags.push( fontTag );
			// (icona )Visualizza documento(forma link) 
		 	if(evv.documentoTestuale!=null)
		 	{
		 		if(evv.documentoTestuale.uri!=null && evv.documentoTestuale.uri.length>0)
		 		{
	 				var cittadino:Cittadino			= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
	 				if(cittadino!=null){
	 					// visualizer=Visualizer.swf
						// comunicator=ComEMail.swf
						// collect=Collettore.swf
						//====================== http://127.0.0.1:8000/classes/flex/container.html?visualizer=Visualizer.swf&comunicator=ComEMail.swf&collect=Collettore.swf&codiceFiscale=CTTTML82A41C559X&linkReferto=030305.REPTEST.A&formatoDCE=TXT
						// codiceFiscale=CTTTML82A41C559X 	**
						// linkReferto=030305.REPTEST.A 	**
						// Allegati=FALSE
						// Aggiornamento=FALSE
			 			var linkReferto:String 		= evv.documentoTestuale.uri;
			 			var codiceFiscale:String	= cittadino.codiceFiscale;
			 			//var parziale:String			= "codiceFiscale="+codiceFiscale+"&linkReferto="+linkReferto+"&allegati=FALSE&aggiornamento=FALSE"; 
			 			var parziale:String			= "codiceFiscale="+codiceFiscale+"&linkReferto="+linkReferto; 
			 			var pop:PopupConfig 		= ((FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CONFIGURATION) as DataConfiguration).getData() as Configuration).popup;
			 		 	var urlContainer:String 	= pop.urlHtmlContainer;
						var module:String			= "visualizer="+pop.urlModuloVisualizer+"&comunicator=ComEMail.swf&collect="+pop.urlModuloCollector;
						var url:String				= urlContainer+"?"+module+"&"+parziale;
						//new Image(src);
						tags.push(new Anchor( new FontTag(new Underline(new Bold(new Tex(DOCUMENTO))),HTMLTabColor.BLUE,14,"Trebuchet MS"),url,"_blank" ));
		 			}
		 		}
		 	}
		 	return new ArrayTag(tags).getString();
		} 
		public static function getBody(item:DataDocument):String
		{
			/*
			//http://IP:Porta/classes/flex/SEBP_CRMFLEX.html?
				var link:String = "codiceFiscale=CTTDNV71A41F205Y&linkReferto=030957.TestSoap.uauauauauauauauio.65&Allegati=TRUE&Aggiornamento=TRUE";
				
				if(link !=null && link.length>0)
				{
					arrayTag.addChild( new Break());
					arrayTag.addChild( new FontTag(new Anchor(new Bold(new Tex("DOCUMENTO")),link,"_blank"),HTMLTabColor.RED,12) );
				}
				
				 attric.datiRicovero.
			
			1.POPUP EVENTO PROGRAMMATO
			Descrizione tipologia prestazione
			Codice e descrizione prestazione
			Lista PDT associati (codice e descrizione)
			Lista prestazione (descrizione e codice) dipendente
			Identificativo Set Documentale relativo
			
			2.POPUP EVENTO RICOVERO EROGATO
			Descrizione ente, presidio e reparto
			Data e ora accettazione
			Data e ora dimissione
			Diagnosi dimissione
			
			3.POPUP EVENTO PRONTO SOCCORSO EROGATO
			Descrizione ente, presidio e reparto
			Data e ora accettazione
			Data e ora dimissione
			Diagnosi dimissione
			
			4.POPUP EVENTO FARMACEUTICO EROGATO
			Descrizione Farmacia
			Data erogazione
			Elenco Farmaci (codice e descrizione)
			
			5.POPUP EVENTO SPECIALISTICO EROGATO
			Descrizione ente, presidio 
			Data erogazione
			Elenco prestazioni (codice e descrizione)
			
			6.POPUP DOCUMENTO CLINICO ELETTRONICO
			Descrizione ente, presidio
			Descrizione tipologia DCE
			Descrizione Disciplina erogazione
			Data e ora creazione documento
			Lista PDT associati (codice e descrizione)
			Rete di Patologia associata (codice e descrizione)
			Identificativo Set Documentale relativo
			*/
			var data:Object = item.data;
			if(data is Programmazione)
			{
				return getBodyProgrammazione(item);
			}else if(data is Evento)
			{
				return getBodyEvento(data as Evento);
			}else if(data is SetDocumentale)
			{
				return getBodyDoc(item);
			}
			return "";
		}
	}
}