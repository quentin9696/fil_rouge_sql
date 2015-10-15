package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the message_offre_demploi database table.
 * 
 */
@Embeddable
public class MessageOffreDemploiPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="id_candidature", insertable=false, updatable=false)
	private Integer idCandidature;

	@Column(name="id_offre_emploi", insertable=false, updatable=false)
	private Integer idOffreEmploi;

	public MessageOffreDemploiPK() {
	}
	public Integer getIdCandidature() {
		return this.idCandidature;
	}
	public void setIdCandidature(Integer idCandidature) {
		this.idCandidature = idCandidature;
	}
	public Integer getIdOffreEmploi() {
		return this.idOffreEmploi;
	}
	public void setIdOffreEmploi(Integer idOffreEmploi) {
		this.idOffreEmploi = idOffreEmploi;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof MessageOffreDemploiPK)) {
			return false;
		}
		MessageOffreDemploiPK castOther = (MessageOffreDemploiPK)other;
		return 
			this.idCandidature.equals(castOther.idCandidature)
			&& this.idOffreEmploi.equals(castOther.idOffreEmploi);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.idCandidature.hashCode();
		hash = hash * prime + this.idOffreEmploi.hashCode();
		
		return hash;
	}
}