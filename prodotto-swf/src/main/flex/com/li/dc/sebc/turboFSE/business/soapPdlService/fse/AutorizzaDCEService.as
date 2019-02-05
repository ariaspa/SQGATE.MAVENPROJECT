package com.li.dc.sebc.turboFSE.business.soapPdlService.fse
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.fse.service.AbstractAutorizzaDCE2009_01;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoAutorizza;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoInputAutorizzaDce;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoOutputAutorizzaDce;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoPrestazione;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.ConstTipiAttributiDCE;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.AttributiEnote;
	import it.lispa.siss.sebc.middleground.entity.AttributiLdimissione;
	import it.lispa.siss.sebc.middleground.entity.AttributiReferto;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiDCE;
	import it.lispa.siss.sebc.middleground.entity.AttributiVerbalePsoccorso;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	import it.lispa.siss.sebc.middleground.entity.Prestazione;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	public class AutorizzaDCEService extends FSEService
	{
		public var cittadino:Cittadino;
		public var operatore:Operatore;
		public var note:String;
		public var agregazione:Array;
		private var newListAgregazione:Array;
		public function AutorizzaDCEService()
		{
			super( );
			Debug.logDebug("AutorizzaDCEService instance");
		}
		
		private function getPrestazioni(spc:AttributiSpecificiDCE):IIterator
		{
			try
			{
				Debug.logDebug("AutorizzaDCEService getPrestazioni isATTRIBUTI_REFERTO_2009 : "+(spc.tipo == ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009));
				if(spc.tipo == ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009 
					|| spc.tipo == ConstTipiAttributiDCE.ATTRIBUTI_REFERTO)
				{
					if(AttributiReferto(spc).ambulatoriale!=null 
					&& AttributiReferto(spc).ambulatoriale.prestazioniAssociate!=null
					&& AttributiReferto(spc).ambulatoriale.prestazioniAssociate.length>0)
					{
						Debug.logDebug("AutorizzaDCEService getPrestazioni entrato if " );
						var iter:IIterator	= new ArrayIterator(  AttributiReferto(spc).ambulatoriale.prestazioniAssociate.toArray() );
						iter.reset();
						var temp:Array		= new Array();
						while(iter.hasNext())
						{
							var prest:Prestazione 		= iter.next() as Prestazione;						
							var vopres:VoPrestazione	= new VoPrestazione();
							vopres.idPrestazioneSISS	= prest.codice;
							vopres.IUP					= prest.iup;
							Debug.logDebug("AutorizzaDCEService getPrestazioni  idPrestazioneSISS: " +vopres.idPrestazioneSISS+", IUP: "+vopres.IUP);
							temp.push( vopres );
						}
						Debug.logDebug("AutorizzaDCEService getPrestazioni temp :: " +temp);
						return new ArrayIterator(temp);
					} 
				}
			}catch(e:Error)
			{
				Debug.logDebug("AutorizzaDCEService getPrestazioni Error :: " +e.message +"\n"+e.getStackTrace() );
			}
			return null;
		}
		// 
		private function getPraticaPs(spc:AttributiSpecificiDCE):String
		{
			switch(spc.tipo)
			{
				case ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009:
					return null;
				case ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE:
					return null;
				case ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO:
					if(AttributiVerbalePsoccorso(spc).prontoSoccorso!=null)
						return AttributiVerbalePsoccorso(spc).prontoSoccorso.numeroPraticaPS;
				case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009:
				case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO:
					if(AttributiReferto(spc).prontoSoccorso!=null)
						return AttributiReferto(spc).prontoSoccorso.numeroPraticaPS;
			}	
			return null;
		}
		private function getNosologico(spc:AttributiSpecificiDCE):String
		{
			switch(spc.tipo)
			{
				case ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009:
					if(AttributiEnote(spc).datiRicovero!=null)
						return AttributiEnote(spc).datiRicovero.numeroNosologico
				case ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE:
					if(AttributiLdimissione(spc).ricovero!=null)
						return AttributiLdimissione(spc).ricovero.numeroNosologico
				case ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO:
					return null;
				case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009:
				case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO:
					if(AttributiReferto(spc).ricovero!=null)
						return AttributiReferto(spc).ricovero.numeroNosologico;
			}	
			return null;
		}
		private function getPreRicovero(spc:AttributiSpecificiDCE):String
		{
			switch(spc.tipo)
			{
				case ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009:
					if(AttributiEnote(spc).datiRicovero!=null)
						return AttributiEnote(spc).datiRicovero.datiAccettazione.numeroPrericovero;
				case ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE:
					return null;
				case ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO:
					return null;
				case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO_2009:
				case ConstTipiAttributiDCE.ATTRIBUTI_REFERTO:
					if(AttributiReferto(spc).prericovero!=null)
						return AttributiReferto(spc).prericovero.numeroPrericovero;
			}	
			return null;
		}
		
		private function getInput():VoInputAutorizzaDce
		{
			var input:VoInputAutorizzaDce 	= new VoInputAutorizzaDce();
			try{
				Debug.logDebug("AutorizzaDCEService getInput ");
				newListAgregazione				= new Array();
				var iter:ArrayIterator			= new ArrayIterator(agregazione);
				var temp:Array 					= new Array();
			
				while(iter.hasNext())
				{
					Debug.logDebug("AutorizzaDCEService getInput hasNext ");
					
					var dce:SetDocumentale = iter.next() as SetDocumentale;	
					if(dce.statoAutorizzazioneDocumento!=null && 
						dce.statoAutorizzazioneDocumento.length>0 && 
						dce.statoAutorizzazioneDocumento.toUpperCase() == "NO")
					{
						 
						Debug.logDebug("AutorizzaDCEService getInput hasNext valido");
						
							var autorizza:VoAutorizza = new VoAutorizza();
							/////////////////////////////////////////////////
							var dtCr:String				= dce.dataOraCreazione;
							if(dtCr!=null && dtCr.length < 14)
							{
								var ln:uint			= dtCr.length;
								var tot:uint		= 14-ln;
								for(var i:uint = 0;i<tot;i++)
								{
									dtCr +="0"; 	
								}	 	
							}
							autorizza.dataOraCreazione 	= dtCr; 
							//////////////////////////////////////////////////////////////////////////////////////////////////
							autorizza.idsetDocumenti 	= dce.idSetDocumenti;
							if(dce.tipoDocumento!=null && dce.tipoDocumento.codice!=null)
								autorizza.idTipoDocumento 	= dce.tipoDocumento.codice;
							autorizza.noteReperibilita 	= note;
							dce.noteReperibilita		= note;
							//////////////////////////////////////////////////////////////////////////////////////////////////
							autorizza.attributiSpecifici.numeroNosologico 		= getNosologico(dce.attributiSpecificiDCE); 
							autorizza.attributiSpecifici.numeroPraticaPS 		= getPraticaPs(dce.attributiSpecificiDCE );
							autorizza.attributiSpecifici.numeroPrericovero 		= getPreRicovero(dce.attributiSpecificiDCE); 
							autorizza.attributiSpecifici.prestazioniAssociate 	= getPrestazioni(dce.attributiSpecificiDCE);
							/////////////////////////////////////////////////
							//  autoreDocumento -------------------------------------------------
							
							if(dce.autoreDocumento!=null)
							{
								var codFisc:String;
								if(dce.autoreDocumento.codiceFiscale !=null)
									codFisc = dce.autoreDocumento.codiceFiscale;
								autorizza.autoreDocumento.codiceFiscale	= (codFisc!=null && codFisc.length>0) ? codFisc : operatore.codiceFiscale;
								var cogn:String
								if(dce.autoreDocumento.cognome!=null)
									cogn	= dce.autoreDocumento.cognome;
								
								Debug.logDebug("AutorizzaDCEService getInput NOME: "+nm+", COGNOME: "+cogn);
								
								autorizza.autoreDocumento.cognome		= (cogn!=null && cogn.length>0) ? cogn : "A";		
								var nm:String;
								if(dce.autoreDocumento.nome!=null)
									nm = dce.autoreDocumento.nome;
								autorizza.autoreDocumento.nome			= (nm!=null && nm.length>0) ? nm : "B";				
							}
							///////////////////////////////////////////////// 
							//  cittadino
							autorizza.cittadino.nomeCittadino    	=  cittadino.nome;
							autorizza.cittadino.cognomeCittadino    =  cittadino.cognome;
							 
							if(cittadino.codiceFiscale!=null && cittadino.codiceFiscale.length>0)
							{
								autorizza.cittadino.idCittadino    		=  cittadino.codiceFiscale;
								 
							}else if(cittadino.assistenza.idAssistito!=null && cittadino.assistenza.idAssistito.length>0)
							{
								autorizza.cittadino.idCittadino    		=  cittadino.assistenza.idAssistito;
								autorizza.cittadino.tipoIdCittadino		=  "CS";
							}
							if(dce.strutturaCreazione!=null)
							{
								if(dce.strutturaCreazione.ente!=null && dce.strutturaCreazione.ente.codice!=null)
									autorizza.strutturaCreazione.idEnte	= dce.strutturaCreazione.ente.codice;
									
								if(dce.strutturaCreazione.primoPresidio!=null && dce.strutturaCreazione.primoPresidio.codice!=null)	
									autorizza.strutturaCreazione.idPresidio	= dce.strutturaCreazione.primoPresidio.codice;
									
								if(dce.strutturaCreazione.ASLAppartenenza!=null && dce.strutturaCreazione.ASLAppartenenza.codice!=null)	 
									autorizza.strutturaCreazione.idUnitaOperativaClinica 	= dce.strutturaCreazione.ASLAppartenenza.codice;
							} 
							 
							temp.push( autorizza );
							newListAgregazione.push( dce );
							
							 
						
					}  
				}
				input.iteratorAutorizzazioni = new ArrayIterator(temp);
			}catch(e:Error)
			{
				Debug.logDebug("AutorizzaDCEService getInput Error 1 "+e.message);
			} 
			return input;
		}
		
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			Debug.logDebug("AutorizzaDCEService getDataResult esitiPositivi "+esitiPositivi);
			/*è la risposta dalla pdl */
			var iter:ArrayIterator		= new ArrayIterator(esitiPositivi);
			/*è la lista che ho spedito*/
			var iterAgre:ArrayIterator	= new ArrayIterator(newListAgregazione);
			/* refresh dei  SetDocumentale */
			while(iter.hasNext())
			{
				var vo:VoOutputAutorizzaDce =  iter.next() as VoOutputAutorizzaDce;
				if(vo.esito.toUpperCase()=="SI")
				{
					var idSet:String 				= vo.idSetDocumenti;
					iterAgre.reset();
					while(iterAgre.hasNext())
					{
						var doc:SetDocumentale 		= iterAgre.next() as SetDocumentale;
						var dceSet:String			= doc.idSetDocumenti;  
						if(idSet==dceSet)
						{
							doc.statoAutorizzazioneDocumento = "SI"; 
						}
					}
				}
			}
			return !(esitiPositivi.length== newListAgregazione.length);
		}
		
		override protected function getService():AbstractServiceSEB
		{
			var serv:AbstractServiceSEB = factory.getAutorizzaDCE() as AbstractServiceSEB;
			Debug.logDebug("AutorizzaDCEService executeService servizio :: "+serv);
			return serv;
		}	
		override protected function executeService( ):void
		{
			Debug.logDebug("AutorizzaDCEService executeService this.responder "+this.responder);
			var input:VoInputAutorizzaDce = getInput();
			Debug.logDebug("AutorizzaDCEService executeService input "+input);
			(this.serviceSEB as AbstractAutorizzaDCE2009_01).execute(  input );
			Debug.logDebug("AutorizzaDCEService executeService CHIAMATO ");
		}
	}
}