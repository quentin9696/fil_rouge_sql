package eu.telecom_bretagne.cabinet_recrutement.service;

import java.sql.Time;
import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

@Remote
public interface IServiceCandidat {

	public Candidature addCandidat(Candidature c);
	public Candidature updateCandidat(Candidature c);
	public List<Candidature> findAllCandidatures();
	public Candidature findById(int id);
	public List<Candidature> getCandidatAssocier(int idSecteur, int idNiveauQualif);
}
