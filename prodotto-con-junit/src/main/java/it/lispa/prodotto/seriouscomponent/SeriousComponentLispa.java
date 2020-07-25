package it.lispa.prodotto.seriouscomponent;
/**
 * classe di esempio per poi essere invocato dai test junit
 *
 * @since 1.0
 * @see java.awt.altro
 */
public class SeriousComponentLispa {

	/** 
	 * verifica se nel testo in input contiene la sottoparola FUNNY
	 * @param String text 
	 * @return  boolean valore di ritorno
	 */

	public static boolean seriousness1(String text) {
		return !text.toUpperCase().contains("FUNNY");
	}

	/** 
	 *  concatena alla stringa in input la parola LISPA
	 * @param String text 
	 * @return  boolean valore di ritorno
	 */
	public static String seriousness2(String text) {
		return text.concat("LOMBARDIA ");
	}
}