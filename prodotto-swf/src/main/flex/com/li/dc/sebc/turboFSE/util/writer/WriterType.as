package com.li.dc.sebc.turboFSE.util.writer
{
	import it.lispa.siss.sebc.flex.messages.ConstStatus;
	import it.lispa.siss.sebc.middleground.entity.response.ListaWarning;
	import it.lispa.siss.sebc.middleground.entity.response.WarningType;
	
	public class WriterType
	{
		public function WriterType()
		{
		}
		public function getType( obj:Object ):String
		{	 
			if(obj is ListaWarning || obj is WarningType)
			{
				return ConstStatus.WARNING;
			}else if(obj is String)
			{
				return ConstStatus.INFO;
			}
			return ConstStatus.ERROR;
		}
	}
}