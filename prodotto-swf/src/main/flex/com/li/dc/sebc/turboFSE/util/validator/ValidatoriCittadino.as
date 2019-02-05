package com.li.dc.sebc.turboFSE.util.validator
{
	import com.li.dc.sebc.turboFSE.util.ExpressionRegExpValidator;
	
	import mx.validators.RegExpValidator;
	import mx.validators.Validator;
	
	public class ValidatoriCittadino
	{
		public static function getValidatorSesso(sesso:Object):ValidatorListString
		{
			var vali:ValidatorListString 	= new ValidatorListString();
			vali.source						= sesso;
			vali.property					= "selectedValue";
			vali.required					= true;
			vali.listString					= ["M","F"]; 
			vali.errorEmpitylist			= "Selezionare un sesso"; 
			vali.requiredFieldError			= "Sesso: Selezionare un sesso";
			return vali;
		}
		public static function getValidatorMaxRecord(maxRecord:Object):RegExpValidator
		{
			var reg:RegExpValidator = new RegExpValidator();
			reg.source				= maxRecord;
			reg.property			= "text";  
			reg.expression			= ExpressionRegExpValidator.REGEXP_NUMERIC;
			reg.required			= false;
			reg.noMatchError		= "Righe per pagina: Deve essere numerico";
			return reg;
		}
		public static function getValidatorPageNumber(pageNumber:Object):RegExpValidator
		{
			var reg:RegExpValidator = new RegExpValidator();
			reg.source				= pageNumber;
			reg.property			= "text";  
			reg.expression			= ExpressionRegExpValidator.REGEXP_NUMERIC;
			reg.required			= false;
			reg.noMatchError		= "Pagina Nr.: Deve essere numerico";
			return reg;
		}
		public static function getValidatorNome(nome:Object):RegExpValidator
		{
			var reg:RegExpValidator = new RegExpValidator();
			reg.source				= nome;
			reg.property			= "text";  
			reg.expression			= ExpressionRegExpValidator.REGEXP_LETTERS;
			reg.required			= false;
			reg.noMatchError		= "Nome: Deve essere nel formato testo";
			return reg;
		}
		 
		public static function getValidatorCognome(cognome:Object):RegExpValidator
		{
			var reg:RegExpValidator = new RegExpValidator();
			reg.source				= cognome;
			reg.property			= "text";  
			reg.expression			= ExpressionRegExpValidator.REGEXP_LETTERS;
			reg.required			= true;
			reg.noMatchError		= "Cognome: Deve essere nel formato testo";
			reg.requiredFieldError	= "Cognome: Inserire il cognome"
			return reg;
		}
		public static function getValidatorCodiceFiscale(identificativo:Object):RegExpValidator
		{
			var reg:RegExpValidator = new RegExpValidator();
			reg.source				= identificativo;
			reg.property			= "text";
			reg.expression			= ExpressionRegExpValidator.REGEXP_CODICE_FISCALE;
			reg.required			= false;
			reg.noMatchError		= "Identificativo: Deve essere un codice fiscale o assitito valido";
			return reg;
		}
		public static function getValidatorCodiceAssistito(identificativo:Object):RegExpValidator
		{
			var reg:RegExpValidator = new RegExpValidator();
			reg.source				= identificativo;
			reg.property			= "text";
			reg.required			= false;
			reg.noMatchError		= "Identificativo: deve essere un codice fiscale o assitito valido";
			reg.expression			= ExpressionRegExpValidator.REGEXP_CODICE_ASSISTITO;
			return reg;
		}
	}
}