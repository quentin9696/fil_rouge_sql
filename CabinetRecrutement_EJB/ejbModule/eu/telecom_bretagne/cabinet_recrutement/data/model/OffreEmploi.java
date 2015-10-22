package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Set;
import static javax.persistence.FetchType.EAGER;


/**
 * The persistent class for the offre_emploi database table.
 * 
 */
@Entity
@Table(name="offre_emploi")
@NamedQuery(name="OffreEmploi.findAll", query="SELECT o FROM OffreEmploi o")
public class OffreEmploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="OFFRE_EMPLOI_ID_GENERATOR", sequenceName="OFFRE_EMPLOI_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OFFRE_EMPLOI_ID_GENERATOR")
	private Integer id;

	@Column(name="date_depot")
	private Timestamp dateDepot;

	@Column(name="descriptif_mission")
	private String descriptifMission;

	@Column(name="profil_recherche")
	private String profilRecherche;

	private String titre;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="offreEmploi")
	private Set<MessageCandidature> messageCandidatures;

	//bi-directional many-to-one association to MessageOffreDemploi
	@OneToMany(mappedBy="offreEmploi")
	private Set<MessageOffreDemploi> messageOffreDemplois;

	//bi-directional many-to-one association to Entreprise
	@ManyToOne(fetch = EAGER)
	@JoinColumn(name="id_entreprise")
	private Entreprise entreprise;

	//bi-directional many-to-one association to NiveauQualification
	@ManyToOne
	@JoinColumn(name="id_niveau_qualification")
	private NiveauQualification niveauQualification;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(fetch = EAGER)
	@JoinTable(
		name="offre_emploi_secteur_activite"
		, joinColumns={
			@JoinColumn(name="id_offre_emploi")
			}
		, inverseJoinColumns={
			@JoinColumn(name="id_secteur_activite")
			}
		)
	private Set<SecteurActivite> secteurActivites;

	public OffreEmploi() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Timestamp getDateDepot() {
		return this.dateDepot;
	}

	public void setDateDepot(Timestamp dateDepot) {
		this.dateDepot = dateDepot;
	}

	public String getDescriptifMission() {
		return this.descriptifMission;
	}

	public void setDescriptifMission(String descriptifMission) {
		this.descriptifMission = descriptifMission;
	}

	public String getProfilRecherche() {
		return this.profilRecherche;
	}

	public void setProfilRecherche(String profilRecherche) {
		this.profilRecherche = profilRecherche;
	}

	public String getTitre() {
		return this.titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public Set<MessageCandidature> getMessageCandidatures() {
		return this.messageCandidatures;
	}

	public void setMessageCandidatures(Set<MessageCandidature> messageCandidatures) {
		this.messageCandidatures = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().add(messageCandidature);
		messageCandidature.setOffreEmploi(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().remove(messageCandidature);
		messageCandidature.setOffreEmploi(null);

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
		messageOffreDemploi.setOffreEmploi(this);

		return messageOffreDemploi;
	}

	public MessageOffreDemploi removeMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		getMessageOffreDemplois().remove(messageOffreDemploi);
		messageOffreDemploi.setOffreEmploi(null);

		return messageOffreDemploi;
	}

	public Entreprise getEntreprise() {
		return this.entreprise;
	}

	public void setEntreprise(Entreprise entreprise) {
		this.entreprise = entreprise;
	}

	public NiveauQualification getNiveauQualification() {
		return this.niveauQualification;
	}

	public void setNiveauQualification(NiveauQualification niveauQualification) {
		this.niveauQualification = niveauQualification;
	}

	public Set<SecteurActivite> getSecteurActivites() {
		return this.secteurActivites;
	}

	public void setSecteurActivites(Set<SecteurActivite> secteurActivites) {
		this.secteurActivites = secteurActivites;
	}

}