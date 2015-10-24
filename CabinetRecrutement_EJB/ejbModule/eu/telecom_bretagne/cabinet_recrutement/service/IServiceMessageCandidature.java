package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

@Remote
public interface IServiceMessageCandidature {
	public MessageCandidature addMessage(MessageCandidature message);
	public List<MessageCandidature> getAll();
	public void remove(MessageCandidature message);
}
