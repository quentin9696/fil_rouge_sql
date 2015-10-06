package eu.telecom_bretagne.cabinet_recrutement.front.controlesDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteurActiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;

/**
 * Servlet implementation class TestServlet
 */
@WebServlet("/ControlesDAO")
public class ControlesDAOServlet extends HttpServlet
{
	//-----------------------------------------------------------------------------
	private static final long serialVersionUID = 1L;
	//-----------------------------------------------------------------------------
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControlesDAOServlet()
	{
		super();
	}
	//-----------------------------------------------------------------------------
	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// Flot de sortie pour écriture des résultats.
    PrintWriter out = response.getWriter();
    
    // Récupération de la réféence vers le(s) DAO(s)
		EntrepriseDAO entrepriseDAO = null;
		CandidatureDAO candidatureDAO = null;
		NiveauQualificationDAO niveauQualifDAO = null;
		SecteurActiviteDAO secteurActiviteDAO = null;
		OffreEmploiDAO offreEmploiDAO = null;
    try
    {
	    entrepriseDAO = (EntrepriseDAO) ServicesLocator.getInstance().getRemoteInterface("EntrepriseDAO");
	    candidatureDAO = (CandidatureDAO) ServicesLocator.getInstance().getRemoteInterface("CandidatureDAO");
	    niveauQualifDAO = (NiveauQualificationDAO) ServicesLocator.getInstance().getRemoteInterface("NiveauQualificationDAO");
	    secteurActiviteDAO = (SecteurActiviteDAO) ServicesLocator.getInstance().getRemoteInterface("SecteurActiviteDAO");
	    offreEmploiDAO = (OffreEmploiDAO) ServicesLocator.getInstance().getRemoteInterface("OffreEmploiDAO");
    }
    catch (ServicesLocatorException e)
    {
    	e.printStackTrace();
    }
		out.println("Contrôles de fonctionnement du DAO EntrepriseDAO");
		out.println();
		
		// Contrôle(s) de fonctionnalités.
		out.println("Liste des entreprises :");
		List<Entreprise> entreprises = entrepriseDAO.findAll();
		
		for(Entreprise entreprise : entreprises)
		{
			out.println(entreprise.getNom());
		}
		out.println();
		
		out.println("Obtention de l'entreprise n° 1 :");
		Entreprise e = entrepriseDAO.findById(1);
		out.println(e.getId());
		out.println(e.getNom());
		out.println(e.getDescriptif());
		out.println(e.getAdressePostale());
		out.println();

		out.println("Obtention de l'entreprise n° 2 :");
		e = entrepriseDAO.findById(2);
		out.println(e.getId());
		out.println(e.getNom());
		out.println(e.getDescriptif());
		out.println(e.getAdressePostale());
		out.println();
		
		out.println("Test des candidatures");
		
		Candidature c = candidatureDAO.findById(1);
		
		out.println(c.getAdresseEmail());
		out.println(c.getAdressePostale());
		out.println(c.getCv());
		out.println(c.getDateDepot());
		out.println(c.getNom());
		out.println(c.getPrenom());
		out.println(c.getId());
		out.println(c.getDateNaissance());
		out.println(c.getNiveauQualification().getIntitule());
		out.println("Secteurs acti :");
		for(SecteurActivite s : c.getSecteurActivites()) {
			out.println(s.getIntitule()); 
		}
		out.println();

		out.println("Test des niveau qualif");
		
		NiveauQualification nq = niveauQualifDAO.findById(1);
		
		out.println(nq.getIntitule());
		out.println(nq.getId());
		out.println();
		
		out.println("Test des secteurs activité");
		
		SecteurActivite sa = secteurActiviteDAO.findById(1);
		
		out.println(sa.getIntitule());
		out.println(sa.getId());
		out.println();
		
		
		out.println("Test des offres emploi");
		
		OffreEmploi oe = offreEmploiDAO.findById(1);
		out.println(oe.getId());
		out.println(oe.getTitre());
		out.println(oe.getDescriptifMission());
		out.println(oe.getEntreprise().getNom());
		out.println(oe.getProfilRecherche());
		out.println(oe.getNiveauQualification().getIntitule());
		
		out.println("Secteurs acti :");
		for(SecteurActivite s : oe.getSecteurActivites()) {
			out.println(s.getIntitule());
		}
		
		out.println();
		
		
		
	}
	//-----------------------------------------------------------------------------
}
