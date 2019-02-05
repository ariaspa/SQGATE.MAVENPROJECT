package com.li.dc.sebc.turboFSE.util
{
	public class ExpressionRegExpValidator
	{
		/**
		  * Formato ExpressionRegExp che rappresenta una stringa alfanumerica
		  */
		 public static const REGEXP_ALPHANUMERIC:String = "^[a-zA-Z0-9]+$";
		  /**
		  * Formato ExpressionRegExp che rappresenta una stringa numerica
		  */
		 public static const REGEXP_NUMERIC:String = "^[0-9]+$";
		 /**
		  * Formato ExpressionRegExp che rappresenta una stringa alfabetica
		  */
		 public static const REGEXP_LETTERS:String = "^[a-zA-ZÃ Ã¹Ã²Ã©Ã¨Ã¬' ]";
		 /**
		  * Formato ExpressionRegExp che rappresenta un indirizzo email
		  */
		 public static const REGEXP_EMAIL_ADDRESS:String = "[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
		  /**
		  * Formato ExpressionRegExp che rappresenta un codice fiscale (aggiunta estensione per omocodici)
		  */
		 public static const REGEXP_CODICE_FISCALE:String = "[a-zA-Z]{6}[a-zA-Z0-9]{2}[a-zA-Z][a-zA-Z0-9]{2}[a-zA-Z][a-zA-Z0-9]{3}[a-zA-Z]";
		  /**
		  * Formato ExpressionRegExp che rappresenta un codice assistito
		  */ 
		 public static const REGEXP_CODICE_ASSISTITO:String = "[0-9]{3}[a-zA-Z]{2}[0-9]{3}";
	}
}