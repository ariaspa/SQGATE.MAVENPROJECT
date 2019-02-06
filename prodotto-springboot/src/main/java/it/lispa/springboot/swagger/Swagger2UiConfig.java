package it.lispa.springboot.swagger;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.common.base.Predicates;

import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class Swagger2UiConfig {

	@Value("${swagger.enable:false}")
	private boolean swaggerEnable;

	@Value("${swagger.apiInfo.title:apiInfo.title}")
	private String apiInfoTitle;

	@Value("${swagger.apiInfo.description:apiInfo.description}")
	private String apiInfoDescription;

	@Value("${swagger.apiInfo.version:}")
	private String apiInfoVersion;

	@Value("${swagger.apiInfo.termOfServiceUrl:}")
	private String apiInfoTermOfServiceUrl;

	@Value("${swagger.apiInfo.contact.name:}")
	private String apiInfoContactName;

	@Value("${swagger.apiInfo.contact.url:}")
	private String apiInfoContactUrl;

	@Value("${swagger.apiInfo.contact.email:}")
	private String apiInfoContactEmail;

	@Value("${swagger.apiInfo.license:}")
	private String apiInfoLicense;

	@Value("${swagger.apiInfo.licenseUrl:}")
	private String apiInfoLicenseUrl;

	@Bean
	public Docket api() {
		return new Docket(DocumentationType.SWAGGER_2)
				.select()
				.apis(Predicates.not(RequestHandlerSelectors.basePackage("org.springframework.boot")))
				.build()
				.enable(swaggerEnable)
				.apiInfo(metaData());
	}
	
	private ApiInfo metaData() {
		final ApiInfo apiInfo = new ApiInfo(
				apiInfoTitle, 
				apiInfoDescription, 
				apiInfoVersion,
				apiInfoTermOfServiceUrl,
				new Contact(
						apiInfoContactName, 
						apiInfoContactUrl, 
						apiInfoContactEmail),
				apiInfoLicense, apiInfoLicenseUrl);

		return apiInfo;
	}

}