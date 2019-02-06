package it.lispa.dcdcod.services.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.ApiOperation;
import it.lispa.dcdcod.services.domain.Comune;
import it.lispa.dcdcod.services.service.ComuneService;
import it.lispa.springboot.jackson.FilteredResponse;

@RestController
@RequestMapping("/comuni")
public class ComuneController {

	@Autowired
	private ComuneService service;

	@GetMapping("")
	@Transactional(readOnly = true)
	@ApiOperation(value = "Ritorna l'elenco dei comuni", response = Iterable.class)
	public FilteredResponse findAll() {
		return FilteredResponse.serializeAllExcept(service.findAll(), "provincia");
	}

	@GetMapping("/{id}")
	@Transactional(readOnly = true)
	@ApiOperation(value = "Ritorna il comune con ID specificato", response = Comune.class)
	public FilteredResponse findById(@PathVariable("id") Long id) {
		return FilteredResponse.serializeAll(service.findById(id));
	}

	@GetMapping("/istat/{codiceIstat}")
	@Transactional(readOnly = true)
	public FilteredResponse findByCodiceIstat(@PathVariable("codiceIstat") Integer codiceIstat) {
		return FilteredResponse.filterOutAllExcept(service.findByCodiceIstat(codiceIstat), "belfiore");
	}

	@GetMapping("/denominazione/{denominazione}")
	@Transactional(readOnly = true)
	public FilteredResponse findByDenominazione(@PathVariable("denominazione") String denominazione) {
		return FilteredResponse.serializeAllExcept(service.findByDenominazione(denominazione), "Comune.id",
				"Provincia.id", "provincia");
	}

	@GetMapping("/provincia/sigla/{sigla}")
	@Transactional(readOnly = true)
	public FilteredResponse findBySiglaProvincia(@PathVariable("sigla") String sigla) {
		return FilteredResponse.serializeAllExcept(service.findBySiglaProvincia(sigla), "provincia");
	}

	@GetMapping("/regione/denominazione/{denominazione}")
	@Transactional(readOnly = true)
	public FilteredResponse findByDenominazioneRegione(@PathVariable("denominazione") String denominazione) {
		return FilteredResponse.serializeAllExcept(service.findByDenominazioneRegione(denominazione), "provincia");
	}
}
