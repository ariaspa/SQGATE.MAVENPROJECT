package com.li.dc.sebc.turboFSE.model.vo
{
	import mx.collections.ArrayCollection;
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.VoInputTimeLine")]
	public class VoInputTimeLine
	{
		// List<PercorsoDiagnosticoTerapeutico> 
		public var listapdt:ArrayCollection;
		public var 	idTipoEvento:String;
		public var  idSetDocument:String;;
		public var  idTipoDocumento:String;
		public var  reteDiPatologia:String;
		public var  codiceFiscaleAutore:String;
		public var  idEnteArchiviazione:String;
		public var  nMaxRecord:String;
		public var  nPagina:String;
		public var  today:String;
		//public var  dataInizio:String;
		//public var  dataFine:String;
	}
}