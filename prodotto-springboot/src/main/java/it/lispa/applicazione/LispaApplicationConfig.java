/*
 * Applicatione Lispa di esempio
 * Verifica del funzionamento di Spring boot
 *    
 *    
 *    www.lispa.it
 */

package it.lispa.applicazione;

import org.glassfish.jersey.server.ResourceConfig;
import org.springframework.stereotype.Component;

import it.lispa.applicazione.helloworld.Endpoint;
import it.lispa.applicazione.reverse.ReverseEndpoint;
import it.lispa.applicazione.user.JsonEndpoint;


@Component
public class LispaApplicationConfig extends ResourceConfig {

	public LispaApplicationConfig() {
		register(Endpoint.class);
		register(ReverseEndpoint.class);
		register(JsonEndpoint.class);
	}

}
