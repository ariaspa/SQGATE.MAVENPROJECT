package it.lispa.dcdcod.services.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import it.lispa.springboot.entity.FilterableEntity;

@Entity
@Table(name = "REGIONI_RD")
public class Regione extends FilterableEntity {
	@Id
	@Column(name = "REG_KEY_ID")
	private Long id;

	@Column(name = "CD_REGIONE")
	private Integer codice;

	@Column(name = "CD_REGIONE_ISTAT")
	private Integer codiceIstat;

	@Column(name = "DS_REGIONE")
	private String denominazione;

	@Column(name = "DS_REGIONE_BREVE")
	private String denominazioneBreve;

	@Column(name = "DT_INIZIO_VALIDITA")
	private Date dataInizioValidita;

	@Column(name = "DT_FINE_VALIDITA")
	private Date dataFineValidita;

	@Column(name = "FL_ANNULLA")
	private String annullata;

	protected Regione() {
	}

	public Long getId() {
		return id;
	}

	public Integer getCodice() {
		return codice;
	}

	public Integer getCodiceIstat() {
		return codiceIstat;
	}

	public String getDenominazione() {
		return denominazione;
	}

	public String getDenominazioneBreve() {
		return denominazioneBreve;
	}

	public Date getDataInizioValidita() {
		return dataInizioValidita;
	}

	public Date getDataFineValidita() {
		return dataFineValidita;
	}

	public String getAnnullata() {
		return annullata;
	}
}
