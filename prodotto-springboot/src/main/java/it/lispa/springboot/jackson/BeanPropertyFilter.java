package it.lispa.springboot.jackson;

import java.io.Serializable;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.databind.ser.BeanPropertyWriter;
import com.fasterxml.jackson.databind.ser.PropertyWriter;
import com.fasterxml.jackson.databind.ser.impl.SimpleBeanPropertyFilter;

class BeanPropertyFilter extends SimpleBeanPropertyFilter {

	public static final BeanPropertyFilter serializeAll() {
		return SerializeExceptFilter.INCLUDE_ALL;
	}

	public static final BeanPropertyFilter filterOutAllExcept(final Set<String> properties) {
		return new FilterExceptFilter(properties);
	}

	public static final BeanPropertyFilter filterOutAllExcept(final String... propertyArray) {
		final HashSet<String> properties = new HashSet<String>(propertyArray.length);

		Collections.addAll(properties, propertyArray);
		return new FilterExceptFilter(properties);
	}

	public static final BeanPropertyFilter serializeAllExcept(final Set<String> properties) {
		return new SerializeExceptFilter(properties);
	}

	public static final BeanPropertyFilter serializeAllExcept(final String... propertyArray) {
		final HashSet<String> properties = new HashSet<String>(propertyArray.length);

		Collections.addAll(properties, propertyArray);
		return new SerializeExceptFilter(properties);
	}

	private static class FilterExceptFilter extends BeanPropertyFilter implements Serializable {

		private static final long serialVersionUID = -2887845740088749527L;

		protected final Set<String> propertiesToInclude;

		FilterExceptFilter(final Set<String> properties) {
			propertiesToInclude = properties;
		}

		@Override
		protected final boolean include(final BeanPropertyWriter writer) {
			if (propertiesToInclude.contains(writer.getName())) {
				return true;
			}
			return propertiesToInclude.contains(writer.getMember().getDeclaringClass().getSimpleName() + "." + writer.getName());
		}

		@Override
		protected final boolean include(final PropertyWriter writer) {
			if (propertiesToInclude.contains(writer.getName())) {
				return true;
			}
			return propertiesToInclude.contains(writer.getMember().getDeclaringClass().getSimpleName() + "." + writer.getName());
		}
	}

	private static class SerializeExceptFilter extends BeanPropertyFilter implements Serializable {

		private static final long serialVersionUID = 7768837557367993143L;

		static final SerializeExceptFilter INCLUDE_ALL = new SerializeExceptFilter();

		protected final Set<String> propertiesToExclude;

		SerializeExceptFilter() {
			propertiesToExclude = Collections.emptySet();
		}

		SerializeExceptFilter(Set<String> properties) {
			propertiesToExclude = properties;
		}

		@Override
		protected final boolean include(final BeanPropertyWriter writer) {
			if (propertiesToExclude.contains(writer.getName())) {
				return false;
			}
			return !propertiesToExclude.contains(writer.getMember().getDeclaringClass().getSimpleName() + "." + writer.getName());
		}

		@Override
		protected final boolean include(final PropertyWriter writer) {
			if (propertiesToExclude.contains(writer.getName())) {
				return false;
			}
			return !propertiesToExclude.contains(writer.getMember().getDeclaringClass().getSimpleName() + "." + writer.getName());
		}
	}
}