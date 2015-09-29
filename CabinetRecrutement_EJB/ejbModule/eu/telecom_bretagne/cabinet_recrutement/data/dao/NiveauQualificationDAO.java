package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;

/**
 * Session Bean implementation class EntrepriseDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class NiveauQualificationDAO
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
	public NiveauQualificationDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public NiveauQualification findById(Integer id)
	{
		return entityManager.find(NiveauQualification.class, id);
	}
	//----------------------------------------------------------------------------
  public List<NiveauQualification> findAll()
	{
		Query query = entityManager.createQuery("select entreprise from Entreprise entreprise order by entreprise.id");
		List l = query.getResultList();

		return (List<NiveauQualification>) l;
	}
  public NiveauQualification persist(NiveauQualification niveauQualification) {
	  
	  if(niveauQualification != null) {
		  try {
			  entityManager.persist(niveauQualification);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  return niveauQualification;
  }
  
  public NiveauQualification update(NiveauQualification niveauQualification) {
	  
	  if(niveauQualification != null) {
		  try {
			  entityManager.merge(niveauQualification);
		  }
		  catch (Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
	  return niveauQualification;
  }
  
  public void remove(NiveauQualification niveauQualification) {
	  if(niveauQualification != null) {
		  try {
			  entityManager.remove(niveauQualification);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
  }
	//-----------------------------------------------------------------------------
}
