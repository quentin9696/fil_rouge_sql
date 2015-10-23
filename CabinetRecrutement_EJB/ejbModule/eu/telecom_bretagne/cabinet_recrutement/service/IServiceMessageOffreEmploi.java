package eu.telecom_bretagne.cabinet_recrutement.service;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi;

@Remote
public interface IServiceMessageOffreEmploi {

	public MessageOffreDemploi ajouterMessage(MessageOffreDemploi message);
}
