package it.lispa.dcdcod.services.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.lispa.dcdcod.services.domain.Provincia;

public interface ProvinciaRepository extends JpaRepository<Provincia, Long> {
	List<Provincia> findByCodiceIstat(Integer codiceIstat);

	@Query("select p from Provincia p where upper(p.denominazione) like concat(upper(?1), '%') and p.dataFineValidita is null")
	List<Provincia> findByDenominazioneStartingWith(String denominazione);
}
