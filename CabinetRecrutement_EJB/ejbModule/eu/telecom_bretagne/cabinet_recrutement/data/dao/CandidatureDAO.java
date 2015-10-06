package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class EntrepriseDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class CandidatureDAO
{
	//-----------------------------------------------------------------------------
	/**
	 * Référence vers le gestionnaire de persistance.
	 */
	@PersistenceContext
	EntityManager entityManager;
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public CandidatureDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public Candidature findById(Integer id)
	{
		return entityManager.find(Candidature.class, id);
	}
	//----------------------------------------------------------------------------
  public Candidature persist(Candidature candidature) {
	  
	  if(candidature != null) {
		  try {
			  entityManager.persist(candidature);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  return candidature;
  }
  
  public Candidature update(Candidature candidature) {
	  
	  if(candidature != null) {
		  try {
			  entityManager.merge(candidature);
		  }
		  catch (Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
	  return candidature;
  }
  
  public void remove(Candidature candidature) {
	  if(candidature != null) {
		  try {
			  entityManager.remove(candidature);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
  }
	//-----------------------------------------------------------------------------
  
  public List<Candidature> findBySecteurActiviteAndNiveauQualification(int idSecteurActivite, int idNiveauQualification)
  {
	  Query query = entityManager.createQuery("select c from Candidature c join c.secteursActivite secteur " +
	  "where secteur.id = :idSA and c.niveauQualification.id = :idNQ " +
	  "order by c.id desc");
	  query.setParameter("idSA", idSecteurActivite);
	  query.setParameter("idNQ", idNiveauQualification);
	  List<Candidature> l = query.getResultList();
	  return l;
  }
  public List<Candidature> findAll()
  {
	  Query query = entityManager.createQuery("select candidature from Candidature candidature " +
	  "order by candidature.id desc");
	  List l = query.getResultList();
	  return (List<Candidature>)l;
  }
}
