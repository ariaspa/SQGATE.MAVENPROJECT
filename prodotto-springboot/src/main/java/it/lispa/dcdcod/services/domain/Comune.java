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
@Table(name = "COMUNI_RD")
public class Comune extends FilterableEntity {
	@Id
	@Column(name = "COM_KEY_ID")
	private Long id;

	@Column(name = "CD_COMUNE_ISTAT")
	private Integer codiceIstat;

	@Column(name = "DS_COMUNE")
	private String denominazione;

	@Column(name = "DS_COMUNE_BREVE")
	private String denominazioneBreve;

	@Column(name = "CD_FISCALE")
	private String belfiore;

	@Column(name = "CD_CAP")
	private String cap;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "PROV_KEY_ID")
	@Where(clause = "dataFineValidita IS NULL")
	private Provincia provincia;

	@Column(name = "DT_INIZIO_VALIDITA")
	private Date dataInizioValidita;

	@Column(name = "DT_FINE_VALIDITA")
	private Date dataFineValidita;

	@Column(name = "FL_ANNULLA")
	private String annullato;

	protected Comune() {
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

	public String getDenominazioneBreve() {
		return denominazioneBreve;
	}

	public String getBelfiore() {
		return belfiore;
	}

	public String getCap() {
		return cap;
	}

	public Provincia getProvincia() {
		return provincia;
	}

	public Date getDataInizioValidita() {
		return dataInizioValidita;
	}

	public Date getDataFineValidita() {
		return dataFineValidita;
	}

	public String getAnnullato() {
		return annullato;
	}
}