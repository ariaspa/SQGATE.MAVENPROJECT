package com.li.dc.sebc.turboFSE.util.window
{
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.util.window.operation.AutorizzaOperation;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Allegato;
	import it.lispa.siss.sebc.middleground.entity.Documento;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	public class TransformAgregazione
	{
		internal static function transform(agregazione:Array):Object
		{
			Debug.logDebug("TransformAgregazione.transform : "+agregazione);
			if(agregazione==null || agregazione.length==0)return null;
			/* Controllo se c'è il salva in cartella e poi spedisco */
			///////////////////////////////////////////////////////////////////////////// 
			var exitStrutturato:Boolean 		= FSEModel.getInstance().documentoCDA2;
			var exitTestuale:Boolean			= FSEModel.getInstance().documentoTestuale;
			Debug.logDebug("TransformAgregazione.transform exitStrutturato: "+exitStrutturato+", exitTestuale : "+exitTestuale);
			//*****************************************************\\
			var testFlag:Boolean				= false;
			var strutFlag:Boolean				= false;
			var notAutorizzato:Boolean			= false;
			var agr:Object 						= {};
			var note:String   					= "";
			var oscurato:Boolean				= false;	
			var idEntry:String					= "";
			var listTestuale:Array				= new Array();
			var listStrutturato:Array			= new Array();
			//*****************************************************\\
			var setDocumentale:SetDocumentale   = agregazione[0] as SetDocumentale;
			if(setDocumentale.listaAllegati!=null)
			{
				var listAllegati:Array				= getObjectAllegati( setDocumentale.listaAllegati.toArray() );
			}
			//*****************************************************
			for(var i:uint = 0;i <agregazione.length;i++)
			{
				var dce:SetDocumentale	= agregazione[i] as SetDocumentale;
				if(dce!=null)
				{
					var listaDoc:Array	= new Array();
					if(dce.documentoTestuale!=null){ listaDoc.push(dce.documentoTestuale);}
					if(dce.documentoStrutturato!=null){ listaDoc.push(dce.documentoStrutturato);}
					
					Debug.logDebug("TransformAgregazione.transform listaDoc: "+listaDoc.length);
					//
					var prelab:String 				= Utils.getNaturaDoc( dce.naturaAggiornamento );
					var label:String				= Utils.getLabelButtonDocEntry( dce );
					var tooltip:String				= label + Utils.getPrestazioni( dce );
					if(!notAutorizzato)
					{
						notAutorizzato 				= Utils.isNotAutorizzato( dce );
					}
					var postlab:String				= notAutorizzato ? "NON AUTORIZZATO" : "AUTORIZZATO";
					label							= " "+prelab +" "+label+" "+postlab;
					//*****************************************************\\
					var docText:Documento			= dce.documentoTestuale;
					var docStrut:Documento			= dce.documentoStrutturato;
					
					var uriText:String				= (docText!=null) ? docText.uri : "";
					var uriStrut:String				= (docStrut!=null)? docStrut.uri :"";
					 
					testFlag						= (!testFlag) ? (docText !=null) : testFlag;
					strutFlag						= (!strutFlag)? (docStrut!=null) : strutFlag;
					oscurato 						= Utils.isOscurato(  dce.oscuramento );
					
					Debug.logDebug("TransformAgregazione.Testuale label: "+label+", tooltip:"+tooltip+", uriText:"+uriText);
					Debug.logDebug("TransformAgregazione.Strutturato label: "+label+", tooltip:"+tooltip+", uriStrut:"+uriStrut);
					listTestuale.push( {label:label,tooltip:tooltip,uri:uriText} ); 
					listStrutturato.push( {label:label,tooltip:tooltip,uri:uriStrut} );  
					//*****************************************************\\
				}
				idEntry = dce.idSetDocumenti;
			}
			if(AutorizzaOperation.noteReperibilita!=null)
			{
				note	= AutorizzaOperation.noteReperibilita;
			} 
			agr.flagText 			= testFlag; 
			agr.flagStrut 			= strutFlag; 
			agr.notAutorizzato 		= notAutorizzato; 
			Debug.logDebug("TransformAgregazione.Strutturato testFlag: "+testFlag+", strutFlag:"+strutFlag+", notAutorizzato:"+notAutorizzato);
			if (listTestuale.length >= 1)
			{
				agr.linkReferto			= listTestuale[0].uri;
			}else if (listStrutturato.length >= 1)
			{
				agr.linkReferto			= listStrutturato[0].uri;
			}else
			{
				agr.linkReferto			= "";
			}
			Debug.logDebug("TransformAgregazione.Strutturato agr.linkReferto: "+agr.linkReferto);
			agr.noteReperibilita 	= note; 
			agr.listTestuale 		= listTestuale; 
			agr.listStrutturato 	= listStrutturato; 
			agr.listAllegati 		= listAllegati;  
			agr.exitTestuale 		= exitTestuale;  
			agr.exitStrutturato 	= exitStrutturato;
			agr.oscurato			= oscurato;
			agr.idEntry				= idEntry;
			return agr;
		}
		private static function getObjectAllegati(allegati:Array=null):Array
		{
			Debug.logDebug("TransformAgregazione.getObjectAllegati allegati: "+allegati);
			var lista:Array 	= new Array();
			if(allegati==null)	return lista;
			for(var i:uint = 0;i<allegati.length;i++)
			{
				var va:Allegato 		= allegati[i];
				var lab:String			= va.etichettaAllegato;
				var tip:String 			= va.formatoAllegato;
				var link:String 		= va.linkAllegato;
				Debug.logDebug("TransformAgregazione.getObjectAllegati allegati["+i+"] = "+"{etichettaAllegato:"+lab+",formatoAllegato:"+tip+",linkAllegato:"+link+"};");
				if(lab==null || lab.length==0)lab = tip; 
				lista.push( {label:lab,tooltip:tip,link:link} );
			}
			return lista;
		}
	}
}