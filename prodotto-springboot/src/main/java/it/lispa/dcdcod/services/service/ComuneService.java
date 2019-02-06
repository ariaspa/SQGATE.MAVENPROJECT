package it.lispa.dcdcod.services.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.lispa.dcdcod.services.domain.Comune;
import it.lispa.dcdcod.services.repository.ComuneRepository;

@Service
public class ComuneService {

	@Autowired
	private ComuneRepository repository;

	public Iterable<Comune> findAll() {
		return repository.findAll();
	}

	public Optional<Comune> findById(Long id) {
		return repository.findById(id);
	}

	public Comune findByCodiceIstat(Integer codiceIstat) {
		return repository.findByCodiceIstat(codiceIstat);
	}

	public Iterable<Comune> findByDenominazione(String denominazione) {
		return repository.findByDenominazioneStartingWith(denominazione);
	}

	public Iterable<Comune> findBySiglaProvincia(String sigla) {
		return repository.findBySiglaProvincia(sigla);
	}

	public Iterable<Comune> findByDenominazioneRegione(String sigla) {
		return repository.findByDenominazioneRegione(sigla);
	}
}
