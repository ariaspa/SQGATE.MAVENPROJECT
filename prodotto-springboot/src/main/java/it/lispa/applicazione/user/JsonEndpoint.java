/*
 * Applicatione Lispa di esempio
 * Verifica del funzionamento di Spring boot
 *    
 * richiamare via browser  http://localhost:8080/user l'output sarà l'elenco degli utenti   
 *    www.lispa.it
 */

package it.lispa.applicazione.user;

import java.util.List;
import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.jaxrs.annotation.JacksonFeatures;

import org.springframework.stereotype.Component;

@Component
@Path("/user")
public class JsonEndpoint {

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@JacksonFeatures(serializationEnable =  { SerializationFeature.INDENT_OUTPUT })	
	public List<User> getUser() {
		List<User> users = new ArrayList<User>();
		
		users.add(new User("Inxecoronata", "Kicornacchia"));
		users.add(new User("Bozunito", "Kicoccodrillo"));
		users.add(new User("Tizuburzio", "Kichiocciola"));
		users.add(new User("Vixelma", "Kiciuffolotto"));
		users.add(new User("Vixelma1", "Kiciuffolotto1"));
		
		return users;
	}

}
