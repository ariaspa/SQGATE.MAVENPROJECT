package it.lispa.prodotto.helloworld;

/**
 * Classe di esempio che serve per essere invocato dai test junit
 *
 * @since 1.0
 * @see java.awt
 */

public class HelloWorldLispa {

	/** 
	 * javadoc del metodo prova
	 * @param 1.0 
	 * @return  valore di ritorno
	 */

	public String helloWord() {
		System.out.println("Hello World");
		return "HelloWorld";

	}
	public boolean helloWordLispa(String lispa) {
		System.out.println("Hello World: " + lispa);
		return lispa.equals("Lispa");
		

	}
}