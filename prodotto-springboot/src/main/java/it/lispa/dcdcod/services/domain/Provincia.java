package it.lispa.dcdcod.services.domain;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import it.lispa.springboot.entity.FilterableEntity;

@Entity
@Table(name = "PROVINCIE_RD")
public class Provincia extends FilterableEntity {
	@Id
	@Column(name = "PROV_KEY_ID")
	private Long id;

	@Column(name = "CD_PROVINCIA_ISTAT")
	private Integer codiceIstat;

	@Column(name = "DS_PROVINCIA")
	private String denominazione;

	@Column(name = "CD_SIGLA")
	private String sigla;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "REG_KEY_ID")
	@Where(clause = "dataFineValidita IS NULL")
	private Regione regione;

	@Column(name = "DT_INIZIO_VALIDITA")
	private Date dataInizioValidita;

	@Column(name = "DT_FINE_VALIDITA")
	private Date dataFineValidita;

	@Column(name = "FL_ANNULLA")
	private String annullata;

	protected Provincia() {
	}

	public Long getId() {
		return id;
	}

	public Integer getCodiceIstat() {
		return codiceIstat;
	}

	public String getDenominazione() {
		return denominazione;
	}

	public String getSigla() {
		return sigla;
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
	
	public Regione getRegione() {
		return regione;
	}
}
