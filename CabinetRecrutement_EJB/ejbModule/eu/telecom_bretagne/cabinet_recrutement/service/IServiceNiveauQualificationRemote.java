package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;

@Remote
public interface IServiceNiveauQualificationRemote {

	public List<NiveauQualification> getNiveauQualif();
}
