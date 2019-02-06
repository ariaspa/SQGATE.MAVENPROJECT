package it.lispa.dcdcod.services.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.lispa.dcdcod.services.domain.Comune;

public interface ComuneRepository extends JpaRepository<Comune, Long> {
	Comune findByCodiceIstat(Integer codiceIstat);

	@Query("select c from Comune c where upper(c.denominazione) like concat(upper(?1), '%') and c.dataFineValidita is null")
	List<Comune> findByDenominazioneStartingWith(String denominazione);

	@Query("select c from Comune c where upper(c.provincia.sigla) = upper(?1) and c.dataFineValidita is null and c.provincia.dataFineValidita is null")
	List<Comune> findBySiglaProvincia(String sigla);

	@Query("select c from Comune c where upper(c.provincia.regione.denominazione) = upper(?1) and c.dataFineValidita is null and c.provincia.dataFineValidita is null and c.provincia.regione.dataFineValidita is null")
	List<Comune> findByDenominazioneRegione(String denominazione);
}
