package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class EntrepriseDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class SecteurActiviteDAO
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
	public SecteurActiviteDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public SecteurActivite findById(Integer id)
	{
		return entityManager.find(SecteurActivite.class, id);
	}
	//----------------------------------------------------------------------------
  public List<SecteurActivite> findAll()
	{
		Query query = entityManager.createQuery("select entreprise from Entreprise entreprise order by entreprise.id");
		List l = query.getResultList();

		return (List<SecteurActivite>) l;
	}
  public SecteurActivite persist(SecteurActivite secteurActivite) {
	  
	  if(secteurActivite != null) {
		  try {
			  entityManager.persist(secteurActivite);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  return secteurActivite;
  }
  
  public SecteurActivite update(SecteurActivite secteurActivite) {
	  
	  if(secteurActivite != null) {
		  try {
			  entityManager.merge(secteurActivite);
		  }
		  catch (Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
	  return secteurActivite;
  }
  
  public void remove(SecteurActivite secteurActivite) {
	  if(secteurActivite != null) {
		  try {
			  entityManager.remove(secteurActivite);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
  }
	//-----------------------------------------------------------------------------
}