package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the message_offre_demploi database table.
 * 
 */
@Entity
@Table(name="message_offre_demploi")
@NamedQuery(name="MessageOffreDemploi.findAll", query="SELECT m FROM MessageOffreDemploi m")
public class MessageOffreDemploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private MessageOffreDemploiPK id;

	@Column(name="corps_message")
	private String corpsMessage;

	@Column(name="date_emploi")
	private Timestamp dateEmploi;

	//bi-directional many-to-one association to Candidature
	@ManyToOne
	@JoinColumn(name="id_candidature")
	private Candidature candidature;

	//bi-directional many-to-one association to OffreEmploi
	@ManyToOne
	@JoinColumn(name="id_offre_emploi")
	private OffreEmploi offreEmploi;

	public MessageOffreDemploi() {
	}

	public MessageOffreDemploiPK getId() {
		return this.id;
	}

	public void setId(MessageOffreDemploiPK id) {
		this.id = id;
	}

	public String getCorpsMessage() {
		return this.corpsMessage;
	}

	public void setCorpsMessage(String corpsMessage) {
		this.corpsMessage = corpsMessage;
	}

	public Timestamp getDateEmploi() {
		return this.dateEmploi;
	}

	public void setDateEmploi(Timestamp dateEmploi) {
		this.dateEmploi = dateEmploi;
	}

	public Candidature getCandidature() {
		return this.candidature;
	}

	public void setCandidature(Candidature candidature) {
		this.candidature = candidature;
	}

	public OffreEmploi getOffreEmploi() {
		return this.offreEmploi;
	}

	public void setOffreEmploi(OffreEmploi offreEmploi) {
		this.offreEmploi = offreEmploi;
	}

}