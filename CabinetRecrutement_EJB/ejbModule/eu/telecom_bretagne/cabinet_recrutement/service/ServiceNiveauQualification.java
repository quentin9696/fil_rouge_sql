package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.LinkedList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;

/**
 * Session Bean implementation class ServiceNiveauQualification
 */
@Stateless
@LocalBean
public class ServiceNiveauQualification implements IServiceNiveauQualificationRemote {

	@EJB 
	private NiveauQualificationDAO niveauQualiticationDAO;
    /**
     * Default constructor. 
     */
    public ServiceNiveauQualification() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public List<NiveauQualification> getNiveauQualif() {
		
		return niveauQualiticationDAO.findAll();
	}

}
