/*
 * Applicatione Lispa di esempio
 * Verifica del funzionamento di Spring boot
 *  
 * richiamare via browser  http://localhost:8080/hello  l'output sarà la parola "hello world"
 *    www.lispa.it
 */

package it.lispa.applicazione.helloworld;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

import org.springframework.stereotype.Component;

@Component
@Path("/hello")
public class Endpoint {

	private final Service service;

	public Endpoint(Service service) {
		this.service = service;
	}

	@GET
	public String message() {
		return "Lombardia Informatica Spa: Esempio Spring Boot. Hello  " + this.service.message();
	}

}
