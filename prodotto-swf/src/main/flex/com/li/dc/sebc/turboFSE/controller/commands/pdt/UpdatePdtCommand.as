package com.li.dc.sebc.turboFSE.controller.commands.pdt
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.util.Utils;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.collections.ArrayCollection;

	public class UpdatePdtCommand extends Command
	{
		public function UpdatePdtCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			var model:FSEModel 					= FSEModel.getInstance();
			var visibleList:ArrayCollection		= model.retrieveProxy(ConstDataProxy.DATA_VISIBLE_UP_TREE).getData() as ArrayCollection;
			/* Array di PDT */
			var pdtGiaAperti:Array				= Utils.getListOpenPDT( visibleList );
			 
			/* prendo i pdt apribili di default Array di PDT  */
			var pdtDefault:ArrayCollection		= (model.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration).listaCodiciPDT;
			var pdtDefaultArray:Array			= (pdtDefault!=null) ? pdtDefault.toArray() : new Array();
			
			/* creo la lista dei pdt da inserire nel pannello dei pdt apribili, cioè tolgo dalla lista di default quelli già aperti , 
				VADO PER SOTTRAZIONE */
			var pdtApribili:Array				= Utils.mergeListPdt(pdtGiaAperti , pdtDefaultArray );
			 
			/* aggiorno  le liste dei pannelli */
			model.retrieveProxy(ConstDataProxy.DATA_PDT_OPEN).update( pdtApribili );
 			model.retrieveProxy(ConstDataProxy.DATA_PDT_CLOSE).update( pdtGiaAperti );
		}
	}
}