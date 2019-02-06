package it.lispa.dcdcod.services.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.lispa.dcdcod.services.domain.Regione;

public interface RegioneRepository extends JpaRepository<Regione, Long> {
	List<Regione> findByCodiceIstat(Integer codiceIstat);

	@Query("select p from Regione p where upper(p.denominazione) like concat(upper(?1), '%') and p.dataFineValidita is null")
	List<Regione> findByDenominazioneStartingWith(String denominazione);
}
