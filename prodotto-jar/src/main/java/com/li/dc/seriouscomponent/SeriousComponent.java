package com.li.dc.seriouscomponent;
/**
 * javadoc di SeriousComponent
 *
 * @since 1.0
 * @see java.awt.altro
 */
public class SeriousComponent {

	/** 
	 * javadoc del metodo testSeriousness1
	 * @param String text 
	 * @return  boolean valore di ritorno
	 */

	public static boolean testSeriousness1(String text) {
		return !text.toUpperCase().contains("FUNNY");
	}

	/** 
	 * javadoc del metodo testSeriousness2
	 * @param String text 
	 * @return  boolean valore di ritorno
	 */
	public static boolean testSeriousness2(String text) {
		return text.toUpperCase().contains("MIMMO");
	}
}