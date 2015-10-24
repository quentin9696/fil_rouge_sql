package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreDemploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;

/**
 * Session Bean implementation class ServiceMessageOffreEmploi
 */
@Stateless
@LocalBean
public class ServiceMessageOffreEmploi implements IServiceMessageOffreEmploi {

	@EJB
	private MessageOffreDemploiDAO messageOffreDemploiDAO;
    /**
     * Default constructor. 
     */
    public ServiceMessageOffreEmploi() {
        // TODO Auto-generated constructor stub
    }
	@Override
	public MessageOffreDemploi ajouterMessage(MessageOffreDemploi message) {
		// TODO Auto-generated method stub
		return messageOffreDemploiDAO.persist(message);
	}
	@Override
	public List<MessageOffreDemploi> getAll() {
		// TODO Auto-generated method stub
		return messageOffreDemploiDAO.findAll();
	}
	@Override
	public void remove(MessageOffreDemploi message) {
		// TODO Auto-generated method stub
		messageOffreDemploiDAO.remove(message);
	}

}
