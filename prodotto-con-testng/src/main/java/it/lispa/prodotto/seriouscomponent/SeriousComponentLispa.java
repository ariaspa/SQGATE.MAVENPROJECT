package it.lispa.prodotto.seriouscomponent;
/**
 * javadoc di SeriousComponentLispa
 *
 * @since 1.0
 * @see java.awt.altro
 */
public class SeriousComponentLispa {

	/** 
	 * ritorna falso se la stringa in input non contiene la parola "FUNNY"
	 * @param String text 
	 * @return  boolean valore di ritorno
	 */

	public static boolean verificaContieneword(String text) {
		return text.toUpperCase().contains("FUNNY");
	}
	/** 
	 * ritorna falso se la stringa in input contiene la parola "FUNNY"
	 * @param String text 
	 * @return  boolean valore di ritorno
	 */

	public static boolean verificaNonContieneword(String text) {
		return !text.toUpperCase().contains("FUNNY");
	}
	/** 
	 * aggiunge alla parola in input il testo "LOMBARDIA"
	 * @param String text 
	 * @return  boolean valore di ritorno
	 */
	public static String  addWord(String text) {
		return text.concat(" LOMBARDIA");
	}
}