package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteurActiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceSecteurActivite
 */
@Stateless
@LocalBean
public class ServiceSecteurActivite implements IServiceSecteurActiviteRemote {

	@EJB 
	private SecteurActiviteDAO secteurActiviteDAO;
	
    /**
     * Default constructor. 
     */
    public ServiceSecteurActivite() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public List<SecteurActivite> getSecteurActivite() {
		// TODO Auto-generated method stub
		return secteurActiviteDAO.findAll();
	}

	@Override
	public SecteurActivite getSecteurActiviteById(int id) {
		// TODO Auto-generated method stub
		return secteurActiviteDAO.findById(id);
	}

}
