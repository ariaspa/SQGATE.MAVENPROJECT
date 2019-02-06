package it.lispa.springboot.jackson;

import org.springframework.context.annotation.Configuration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.util.StdDateFormat;
import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module;
import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module.Feature;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;

@Configuration
public class ObjectMapperConfig extends ObjectMapper {

	private static final long serialVersionUID = 7450958954269154310L;

	public ObjectMapperConfig() {
		super();

		final Hibernate5Module module = new Hibernate5Module();

		module.enable(Feature.FORCE_LAZY_LOADING);
		registerModule(module);
		registerModule(new Jdk8Module());
		enable(SerializationFeature.INDENT_OUTPUT);
		setDateFormat(new StdDateFormat());
	}
}
