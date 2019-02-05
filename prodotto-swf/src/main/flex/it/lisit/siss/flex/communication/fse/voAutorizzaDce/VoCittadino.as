package it.lisit.siss.flex.communication.fse.voAutorizzaDce
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoCittadino extends ValueObject
	{
		public var idCittadino:String;
		public var tipoIdCittadino:String = "CF";
		public var nomeCittadino:String;
		public var cognomeCittadino:String;
		
		public function VoCittadino()
		{
			super();
		}
	}
}