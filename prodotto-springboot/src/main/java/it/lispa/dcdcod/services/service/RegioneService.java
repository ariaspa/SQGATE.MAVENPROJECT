package it.lispa.dcdcod.services.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.lispa.dcdcod.services.domain.Regione;
import it.lispa.dcdcod.services.repository.RegioneRepository;

@Service
public class RegioneService {

	@Autowired
	private RegioneRepository repository;

	public Iterable<Regione> findAll() {
		return repository.findAll();
	}

	public Optional<Regione> findById(Long id) {
		return repository.findById(id);
	}

	public Iterable<Regione> findByCodiceIstat(Integer codiceIstat) {
		return repository.findByCodiceIstat(codiceIstat);
	}

	public Iterable<Regione> findByDenominazione(String denominazione) {
		return repository.findByDenominazioneStartingWith(denominazione);
	}
}
