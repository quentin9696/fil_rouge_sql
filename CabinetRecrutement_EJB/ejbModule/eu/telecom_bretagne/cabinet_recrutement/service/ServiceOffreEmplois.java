package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class OffreEmplois
 */
@Stateless
@LocalBean
public class ServiceOffreEmplois implements IServiceOffreEmplois {

	@EJB
	private OffreEmploiDAO offreEmploiDAO;
    /**
     * Default constructor. 
     */
    public ServiceOffreEmplois() {
        // TODO Auto-generated constructor stub
    }
	@Override
	public List<OffreEmploi> getOffreEmplois() {
		// TODO Auto-generated method stub
		return offreEmploiDAO.findAll();
	}
	@Override
	public OffreEmploi getOffreEmploisById(int id) {
		
		return offreEmploiDAO.findById(id);
	}
	@Override
	public List<OffreEmploi> getOffreEmploisByEntreprise(int id) {
		// TODO Auto-generated method stub
		return offreEmploiDAO.findByEntreprise(id);
	}
	@Override
	public OffreEmploi ajouterOffre(OffreEmploi offre) {
		// TODO Auto-generated method stub
		return offreEmploiDAO.persist(offre);
	}
	@Override
	public OffreEmploi updateOffre(OffreEmploi offre) {
		// TODO Auto-generated method stub
		return offreEmploiDAO.update(offre);
	}
	@Override
	public void removeOffre(OffreEmploi offre) {
		// TODO Auto-generated method stub
		offreEmploiDAO.remove(offre);
	}
	@Override
	public List<OffreEmploi> findBySecteurAndNiveauQualification(int idSecteur,
			int idNiveauQualification) {
		// TODO Auto-generated method stub
		return offreEmploiDAO.findBySecteurActiviteAndNiveauQualification(idSecteur, idNiveauQualification);
	}
	
	

}
