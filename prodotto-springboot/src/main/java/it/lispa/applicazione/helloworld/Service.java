/*
 * Applicatione Lispa di esempio
 * Verifica del funzionamento di Spring boot
 *    
 *    
 *    www.lispa.it
 */

package it.lispa.applicazione.helloworld;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Service {

	@Value("${message:World}")
	private String msg;

	public String message() {
		return this.msg;
	}

}
