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
  public List<Candidature> findAll()
	{
		Query query = entityManager.createQuery("select entreprise from Entreprise entreprise order by entreprise.id");
		List l = query.getResultList();

		return (List<Candidature>) l;
	}
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
  
  public List<Candidature> listCandidature(SecteurActivite secteurActivite, NiveauQualification niveauQualification) {
	  
	  Query query = entityManager.createQuery("select candidature from Candidature candidature "
	  		+ "where niveauQualification.id=candidature.niveauQualification and ");
	  
	  
	  return null;
  }
}
