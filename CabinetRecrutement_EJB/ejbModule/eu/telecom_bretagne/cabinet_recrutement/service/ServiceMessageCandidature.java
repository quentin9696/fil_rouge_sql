package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreDemploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

/**
 * Session Bean implementation class ServiceMessageCandidature
 */
@Stateless
@LocalBean
public class ServiceMessageCandidature implements IServiceMessageCandidature {

	@EJB
	private MessageCandidatureDAO messageCandidatureDAO;
    /**
     * Default constructor. 
     */
    public ServiceMessageCandidature() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public MessageCandidature addMessage(MessageCandidature message) {
		// TODO Auto-generated method stub
		return messageCandidatureDAO.persist(message);
	}

	@Override
	public List<MessageCandidature> getAll() {
		// TODO Auto-generated method stub
		return messageCandidatureDAO.findAll();
	}

	@Override
	public void remove(MessageCandidature message) {
		// TODO Auto-generated method stub
		messageCandidatureDAO.remove(message);
	}

}
