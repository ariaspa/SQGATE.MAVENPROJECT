package com.li.dc.sebc.turboFSE.util.validator
{
	import mx.utils.StringUtil;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	public class ValidatorListString extends Validator
	{
		public var errorNotFoundString:String 	= "Il valore deve essere uno presente nella lista";
		public var errorEmpitylist:String 		= "listString deve contenere almeno un valore";
		public var listString:Array;
		public function ValidatorListString()
		{
			super();
		}
		override protected function doValidation(value:Object):Array
	    {
	        var results:Array = super.doValidation( value );
	        
	        var result:ValidationResult = validateRequired(value);
	        if (result)
	            results.push(result);
	            
	        return results;
	    }
	    private function validateRequired(value:Object):ValidationResult
	    {
	        if (required)
	        {
	        	if(listString==null || listString.length==0)
	        	{
	        		 return new ValidationResult(true, "", "listString",errorEmpitylist); 
	        	}
	        	
	            var val:String = (value != null) ? String(value) : "";
	
	            val = StringUtil.trim( val );
	            
				for(var i:uint = 0;i<listString.length;i++)
				{
					var listValue:String = (listString[i] != null) ? String(listString[i]) : "";
					listValue = StringUtil.trim( val );
					if(listValue == val)
					{
						return null;
					}
				}
				return new ValidationResult(true, "", "listString",errorNotFoundString); 
	        }
	        return null;
	    }
	}
}