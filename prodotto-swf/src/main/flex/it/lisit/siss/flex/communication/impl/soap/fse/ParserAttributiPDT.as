package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFPDT;
	
	internal class ParserAttributiPDT
	{
		private var attFolder:XML;
		public function ParserAttributiPDT(attFolder:XML)
		{
			this.attFolder = attFolder;
		}
		public function execute():VoAFPDT
		{
			var pdt:VoAFPDT = new VoAFPDT();
			if(attFolder!=null && attFolder.length()>0)
			{
				var datiPdt:XML		= attFolder.children()[0];
				pdt.dataApertura	= datiPdt.child( "dataApertura" );
				pdt.dataChiusura	= datiPdt.child( "dataChiusura" );
				pdt.codicePDT		= datiPdt.child( "codicePDT" );
				pdt.descrizionePDT		= datiPdt.child( "descrizionePDT" );
			}
			return pdt;
		}
	}
}

/*
 * 
 	<attributiSpecificiFolder>
 <c:attributi_pdt   
 xmlns:c=”http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-  
 01/attributi_pdt/”>
    <datiPDT>
      <dataApertura></dataApertura>
      <dataChiusura></dataChiusura>
      <codicePDT></codicePDT>
      <descrizionePDT></descrizionePDT>
    </datiPDT>
</c:attributi_pdt>
</attributiSpecificiFolder>
 
 */