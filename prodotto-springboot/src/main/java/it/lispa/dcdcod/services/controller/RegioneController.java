package it.lispa.dcdcod.services.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import it.lispa.dcdcod.services.service.RegioneService;
import it.lispa.springboot.jackson.FilteredResponse;

@RestController
@RequestMapping("/regioni")
public class RegioneController {

	@Autowired
	private RegioneService service;

	@GetMapping("")
	@Transactional(readOnly = true)
	public FilteredResponse findAll() {
		return FilteredResponse.serializeAll(service.findAll());
	}

	@GetMapping("/{id}")
	@Transactional(readOnly = true)
	public FilteredResponse findById(@PathVariable("id") Long id) {
		return FilteredResponse.serializeAll(service.findById(id));
	}

	@GetMapping("/istat/{codiceIstat}")
	@Transactional(readOnly = true)
	public FilteredResponse findByCodiceIstat(@PathVariable("codiceIstat") Integer codiceIstat) {
		return FilteredResponse.serializeAll(service.findByCodiceIstat(codiceIstat));
	}

	@GetMapping("/denominazione/{denominazione}")
	@Transactional(readOnly = true)
	public FilteredResponse findByDenominazione(@PathVariable("denominazione") String denominazione) {
		return FilteredResponse.serializeAll(service.findByDenominazione(denominazione));
	}
}
