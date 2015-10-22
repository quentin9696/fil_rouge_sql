package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

@Remote
public interface IServiceOffreEmplois {

	public List<OffreEmploi> getOffreEmplois();
	public OffreEmploi getOffreEmploisById(int id);
	public List<OffreEmploi> getOffreEmploisByEntreprise(int id);
	public OffreEmploi ajouterOffre(OffreEmploi offre);
	public OffreEmploi updateOffre(OffreEmploi offre);
	public void removeOffre(OffreEmploi offre);
}
