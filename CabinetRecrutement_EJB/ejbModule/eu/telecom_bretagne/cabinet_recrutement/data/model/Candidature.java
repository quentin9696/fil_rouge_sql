package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;

import javax.persistence.*;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Set;
import static javax.persistence.FetchType.EAGER;


/**
 * The persistent class for the candidature database table.
 * 
 */
@Entity
@NamedQuery(name="Candidature.findAll", query="SELECT c FROM Candidature c")
public class Candidature implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CANDIDATURE_ID_GENERATOR", sequenceName="CANDIDATURE_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CANDIDATURE_ID_GENERATOR")
	private Integer id;

	@Column(name="adresse_email")
	private String adresseEmail;

	@Column(name="adresse_postale")
	private String adressePostale;

	private String cv;

	@Column(name="date_depot")
	private Timestamp dateDepot;

	@Column(name="date_naissance")
	private Timestamp dateNaissance;

	private String nom;

	private String prenom;

	//bi-directional many-to-one association to NiveauQualification
	@ManyToOne
	@JoinColumn(name="id_niveau_qualification")
	private NiveauQualification niveauQualification;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="candidature")
	private Set<MessageCandidature> messageCandidatures;

	//bi-directional many-to-one association to MessageOffreDemploi
	@OneToMany(mappedBy="candidature")
	private Set<MessageOffreDemploi> messageOffreDemplois;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(mappedBy="candidatures", fetch = EAGER)
	private Set<SecteurActivite> secteurActivites;

	public Candidature() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAdresseEmail() {
		return this.adresseEmail;
	}

	public void setAdresseEmail(String adresseEmail) {
		this.adresseEmail = adresseEmail;
	}

	public String getAdressePostale() {
		return this.adressePostale;
	}

	public void setAdressePostale(String adressePostale) {
		this.adressePostale = adressePostale;
	}

	public String getCv() {
		return this.cv;
	}

	public void setCv(String cv) {
		this.cv = cv;
	}

	public Timestamp getDateDepot() {
		return this.dateDepot;
	}

	public void setDateDepot(Timestamp dateDepot) {
		this.dateDepot = dateDepot;
	}

	public Timestamp getDateNaissance() {
		return this.dateNaissance;
	}

	public void setDateNaissance(Timestamp dateNaissance) {
		this.dateNaissance = dateNaissance;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public NiveauQualification getNiveauQualification() {
		return this.niveauQualification;
	}

	public void setNiveauQualification(NiveauQualification niveauQualification) {
		this.niveauQualification = niveauQualification;
	}

	public Set<MessageCandidature> getMessageCandidatures() {
		return this.messageCandidatures;
	}

	public void setMessageCandidatures(Set<MessageCandidature> messageCandidatures) {
		this.messageCandidatures = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().add(messageCandidature);
		messageCandidature.setCandidature(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().remove(messageCandidature);
		messageCandidature.setCandidature(null);

		return messageCandidature;
	}

	public Set<MessageOffreDemploi> getMessageOffreDemplois() {
		return this.messageOffreDemplois;
	}

	public void setMessageOffreDemplois(Set<MessageOffreDemploi> messageOffreDemplois) {
		this.messageOffreDemplois = messageOffreDemplois;
	}

	public MessageOffreDemploi addMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		getMessageOffreDemplois().add(messageOffreDemploi);
		messageOffreDemploi.setCandidature(this);

		return messageOffreDemploi;
	}

	public MessageOffreDemploi removeMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		getMessageOffreDemplois().remove(messageOffreDemploi);
		messageOffreDemploi.setCandidature(null);

		return messageOffreDemploi;
	}

	public Set<SecteurActivite> getSecteurActivites() {
		return this.secteurActivites;
	}

	public void setSecteurActivites(Set<SecteurActivite> secteurActivites) {
		this.secteurActivites = secteurActivites;
	}
}