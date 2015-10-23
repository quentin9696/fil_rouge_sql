package eu.telecom_bretagne.cabinet_recrutement.service;

import java.sql.Time;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceCandidat
 */
@Stateless
@LocalBean
public class ServiceCandidat implements IServiceCandidat {

	@EJB 
	private CandidatureDAO candidatureDAO;
	
    /**
     * Default constructor. 
     */
    public ServiceCandidat() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public Candidature addCandidat(Candidature c) {
		// TODO Auto-generated method stub
		return candidatureDAO.persist(c);
	}

	@Override
	public Candidature updateCandidat(Candidature c) {
		// TODO Auto-generated method stub
		return candidatureDAO.update(c);
	}

	@Override
	public List<Candidature> findAllCandidatures() {
		// TODO Auto-generated method stub
		return candidatureDAO.findAll();
	}

	@Override
	public Candidature findById(int id) {
		// TODO Auto-generated method stub
		return candidatureDAO.findById(id);
	}

	@Override
	public List<Candidature> getCandidatAssocier(int idSecteur,
			int idNiveauQualif) {
		// TODO Auto-generated method stub
		return candidatureDAO.findBySecteurActiviteAndNiveauQualification(idSecteur, idNiveauQualif);
	}

	@Override
	public void removeCandidat(Candidature c) {
		// TODO Auto-generated method stub
		candidatureDAO.remove(c);
	}

}
