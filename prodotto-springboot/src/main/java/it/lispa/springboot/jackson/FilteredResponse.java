package it.lispa.springboot.jackson;

import java.util.Set;

import org.springframework.http.converter.json.MappingJacksonValue;

import com.fasterxml.jackson.databind.ser.PropertyFilter;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;

public final class FilteredResponse extends MappingJacksonValue {

	private FilteredResponse(final Object value, final PropertyFilter propertyFilter) {
		super(value);
		setFilters(new SimpleFilterProvider().setDefaultFilter(propertyFilter));
	}

	public static final FilteredResponse serializeAll(final Object value) {
		return new FilteredResponse(value, BeanPropertyFilter.serializeAll());
	}

	public static final FilteredResponse filterOutAllExcept(final Object value, final Set<String> properties) {
		return new FilteredResponse(value, BeanPropertyFilter.filterOutAllExcept(properties));
	}

	public static final FilteredResponse filterOutAllExcept(final Object value, final String... propertyArray) {
		return new FilteredResponse(value, BeanPropertyFilter.filterOutAllExcept(propertyArray));
	}

	public static final FilteredResponse serializeAllExcept(final Object value, final Set<String> properties) {
		return new FilteredResponse(value, BeanPropertyFilter.serializeAllExcept(properties));
	}

	public static final FilteredResponse serializeAllExcept(final Object value, final String... propertyArray) {
		return new FilteredResponse(value, BeanPropertyFilter.serializeAllExcept(propertyArray));
	}

}
