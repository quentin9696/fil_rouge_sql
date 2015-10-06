package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the message_candidature database table.
 * 
 */
@Entity
@Table(name="message_candidature")
@NamedQuery(name="MessageCandidature.findAll", query="SELECT m FROM MessageCandidature m")
public class MessageCandidature implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private MessageCandidaturePK id;

	@Column(name="corps_message")
	private String corpsMessage;

	@Column(name="date_envoi")
	private Timestamp dateEnvoi;

	//bi-directional many-to-one association to Candidature
	@ManyToOne
	@JoinColumn(name="id_candidature")
	private Candidature candidature;

	//bi-directional many-to-one association to OffreEmploi
	@ManyToOne
	@JoinColumn(name="id_offre_emploi")
	private OffreEmploi offreEmploi;

	public MessageCandidature() {
	}

	public MessageCandidaturePK getId() {
		return this.id;
	}

	public void setId(MessageCandidaturePK id) {
		this.id = id;
	}

	public String getCorpsMessage() {
		return this.corpsMessage;
	}

	public void setCorpsMessage(String corpsMessage) {
		this.corpsMessage = corpsMessage;
	}

	public Timestamp getDateEnvoi() {
		return this.dateEnvoi;
	}

	public void setDateEnvoi(Timestamp dateEnvoi) {
		this.dateEnvoi = dateEnvoi;
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