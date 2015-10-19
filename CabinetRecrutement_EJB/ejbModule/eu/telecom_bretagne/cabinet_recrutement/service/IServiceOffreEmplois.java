package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

@Remote
public interface IServiceOffreEmplois {

	public List<OffreEmploi> getOffreEmplois();
	public OffreEmploi getOffreEmploisById(int id);
}
