package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;
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
  public OffreEmploi persist(OffreEmploi offreEmploi) {
	  
	  if(offreEmploi != null) {
		  try {
			  entityManager.persist(offreEmploi);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  return entityManager.merge(offreEmploi);
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
	  OffreEmploi offEmploiASuppr = entityManager.merge(offreEmploi);
	  if(offreEmploi != null) {
		  try {
			  entityManager.remove(offEmploiASuppr);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
	  }
	  
  }
	//-----------------------------------------------------------------------------
  
  public List<OffreEmploi> findByEntreprise(int idEntreprise)
  {
	  Query query = entityManager.createQuery("select offreEmploi from OffreEmploi offreEmploi " +
	  "where offreEmploi.entreprise.id = :idE " +
	  "order by offreEmploi.id desc");
	  query.setParameter("idE", idEntreprise);
	  List<OffreEmploi> l = query.getResultList();
	  return l;
  }
  public List<OffreEmploi> findBySecteurActiviteAndNiveauQualification(int idSecteurActivite, int idNiveauQualification)
  {
	  Query query = entityManager.createQuery("select oe from OffreEmploi oe join oe.secteursActivite secteurs " +
	  "where secteurs.id = :idSA and oe.niveauQualification.id = :idNQ " +
	  "order by oe.id desc");
	  query.setParameter("idSA", idSecteurActivite);
	  query.setParameter("idNQ", idNiveauQualification);
	  List<OffreEmploi> l = query.getResultList();
	  return l;
  }
  public List<OffreEmploi> findAll()
  {
	  Query query = entityManager.createQuery("select offreEmploi from OffreEmploi offreEmploi " +
	  "order by offreEmploi.id desc");
	  List l = query.getResultList();
	  return (List<OffreEmploi>)l;
  }
}
