package it.lispa.dcdcod.services.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.lispa.dcdcod.services.domain.Provincia;
import it.lispa.dcdcod.services.repository.ProvinciaRepository;

@Service
public class ProvinciaService {

	@Autowired
	private ProvinciaRepository repository;

	public Iterable<Provincia> findAll() {
		return repository.findAll();
	}

	public Optional<Provincia> findById(Long id) {
		return repository.findById(id);
	}

	public Iterable<Provincia> findByCodiceIstat(Integer codiceIstat) {
		return repository.findByCodiceIstat(codiceIstat);
	}

	public Iterable<Provincia> findByDenominazione(String denominazione) {
		return repository.findByDenominazioneStartingWith(denominazione);
	}
}
