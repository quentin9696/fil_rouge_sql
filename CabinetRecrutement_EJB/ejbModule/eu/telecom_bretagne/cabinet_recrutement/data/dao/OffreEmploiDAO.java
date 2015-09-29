package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class EntrepriseDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class OffreEmploiDAO
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
	public OffreEmploiDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public OffreEmploi findById(Integer id)
	{
		return entityManager.find(OffreEmploi.class, id);
	}
	//----------------------------------------------------------------------------
  public List<OffreEmploi> findAll()
	{
		Query query = entityManager.createQuery("select entreprise from Entreprise entreprise order by entreprise.id");
		List l = query.getResultList();

		return (List<OffreEmploi>) l;
	}
  public OffreEmploi persist(OffreEmploi offreEmploi) {
	  
	  if(offreEmploi != null) {
		  try {
			  entityManager.persist(offreEmploi);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  return offreEmploi;
  }
  
  public OffreEmploi update(OffreEmploi offreEmploi) {
	  
	  if(offreEmploi != null) {
		  try {
			  entityManager.merge(offreEmploi);
		  }
		  catch (Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
	  return offreEmploi;
  }
  
  public void remove(OffreEmploi offreEmploi) {
	  if(offreEmploi != null) {
		  try {
			  entityManager.remove(offreEmploi);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
  }
	//-----------------------------------------------------------------------------
}
