package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	
	public class VoRispostaSingola extends ClonableValueObject
	{
		public var esitoServizio:String;
		//public var dataUltimaModifica:String;
		public var datiCittadino:VoDatiCittadino;
		public var datiMedico:VoDatiMedico;
		public var datiTesserino:VoDatiTesserino;
		public var esenzioniGodute:VoEsenzioniGodute;
		
		public function VoRispostaSingola()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoRispostaSingola 	= new VoRispostaSingola();
			cl.esitoServizio			= this.esitoServizio;
			//cl.dataUltimaModifica		= this.dataUltimaModifica;
			if(this.datiCittadino!=null)
			{
				cl.datiCittadino		= this.datiCittadino.clone() as VoDatiCittadino;
			}	
			if(this.datiMedico!=null)
			{
				cl.datiMedico			= this.datiMedico.clone() as VoDatiMedico; 
			}
			if(this.datiTesserino!=null)
			{
				cl.datiTesserino		= this.datiTesserino.clone() as VoDatiTesserino;
			}
			if(this.esenzioniGodute!=null)
			{
				cl.esenzioniGodute		= this.esenzioniGodute.clone() as VoEsenzioniGodute
			}
			return cl;
		}
	}
}