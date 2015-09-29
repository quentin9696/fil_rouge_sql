package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;

/**
 * Session Bean implementation class EntrepriseDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class MessageOffreDemploiDAO
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
	public MessageOffreDemploiDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public MessageOffreDemploi findById(Integer id)
	{
		return entityManager.find(MessageOffreDemploi.class, id);
	}
	//----------------------------------------------------------------------------
  public List<MessageOffreDemploi> findAll()
	{
		Query query = entityManager.createQuery("select entreprise from Entreprise entreprise order by entreprise.id");
		List l = query.getResultList();

		return (List<MessageOffreDemploi>) l;
	}
  public MessageOffreDemploi persist(MessageOffreDemploi messageOffreDemploi) {
	  
	  if(messageOffreDemploi != null) {
		  try {
			  entityManager.persist(messageOffreDemploi);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  return messageOffreDemploi;
  }
  
  public MessageOffreDemploi update(MessageOffreDemploi messageOffreDemploi) {
	  
	  if(messageOffreDemploi != null) {
		  try {
			  entityManager.merge(messageOffreDemploi);
		  }
		  catch (Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
	  return messageOffreDemploi;
  }
  
  public void remove(MessageOffreDemploi messageOffreDemploi) {
	  if(messageOffreDemploi != null) {
		  try {
			  entityManager.remove(messageOffreDemploi);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
  }
	//-----------------------------------------------------------------------------
}
