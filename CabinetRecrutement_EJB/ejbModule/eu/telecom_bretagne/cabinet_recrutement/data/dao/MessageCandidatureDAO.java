package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

/**
 * Session Bean implementation class EntrepriseDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class MessageCandidatureDAO
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
	public MessageCandidatureDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public MessageCandidature findById(Integer id)
	{
		return entityManager.find(MessageCandidature.class, id);
	}
	//----------------------------------------------------------------------------
  public List<MessageCandidature> findAll()
	{
		Query query = entityManager.createQuery("select message from MessageCandidature message order by message.id DESC");

		List l = query.getResultList();

		return (List<MessageCandidature>) l;
	}
  public MessageCandidature persist(MessageCandidature messageCandidature) {
	  
	  if(messageCandidature != null) {
		  try {
			  entityManager.persist(messageCandidature);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  return entityManager.merge(messageCandidature);
  }
  
  public MessageCandidature update(MessageCandidature messageCandidature) {
	  
	  if(messageCandidature != null) {
		  try {
			  messageCandidature = entityManager.merge(messageCandidature);
		  }
		  catch (Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
	  return messageCandidature;
  }
  
  public void remove(MessageCandidature messageCandidature) {
	  MessageCandidature messageCandidatureASuppr = entityManager.merge(messageCandidature);
	  if(messageCandidature != null) {
		  try {
			  entityManager.remove(messageCandidatureASuppr);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
  }
	//-----------------------------------------------------------------------------
}
