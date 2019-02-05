/*
 * Applicatione Lispa di esempio
 * Verifica del funzionamento di Spring boot
 *    
 *    
 *    www.lispa.it
 */

package it.lispa.applicazione.user;

public class User {

	private String firstName;
	private String lastName;

	public User(String firstName, String lastName) {
		this.firstName = firstName;
		this.lastName = lastName;
	}

	public String getFirstName() {
		return this.firstName;
	}

	public String getLastName() {
		return this.lastName;
	}

}
