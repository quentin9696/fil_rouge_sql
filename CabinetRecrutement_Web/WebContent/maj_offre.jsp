<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActiviteRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauQualificationRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedList"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                java.util.List"%>

<%
  // Récupération du service (bean session)
	 IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
IServiceNiveauQualificationRemote serviceNiveauQualif = (IServiceNiveauQualificationRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauQualification");
IServiceSecteurActiviteRemote serviceSecteurActivite = (IServiceSecteurActiviteRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
%>

  <%@include file="header.jsp" %>
  <div id="content">
  <%
  if(utilisateur == null) {
		%>
		<p class="erreur">Vous n'êtes pas connecté !</p>
		<%	
	}
	else if(utilisateur instanceof Candidature) {
		%>
		<p class ="erreur">Seules les entreprises peuvent accéder à cette page.
		<%
	}
	else {
		Entreprise e = (Entreprise) utilisateur;
		
  	if(request.getParameter("id").isEmpty()) {
  		out.println("L'offre d'emploi doit être spécifiée <br/>");
  	}
  	else if (request.getParameter("id").matches("^[0-9]*$")) {
  		
  		int id = new Integer(request.getParameter("id"));
  		OffreEmploi offre = serviceOffre.getOffreEmploisById(id);
  		
  		int idEnt = e.getId();
  		int idEntOffre = offre.getEntreprise().getId();
  		
  		if(offre == null) {
  			out.println("L'offre d'emploi " + id + " n'a pas été trouvée ! <br/>");
  		}
  		else if (idEnt != idEntOffre) {
  			%>
  			<p class="erreur">Ce n'est pas une de vos offres d'emplois</p>
  			<%
  			
  		}
  		else {
  %>
		<h2>Mettre à jour les informations de l'offre d'emploi</h2>
		
		<form action="traitement_maj_offre_emploi.jsp" method="post">
		<table id="affichage">
        <tr>
          <th style="width: 170px;">Id :</th>
          <td>
            <input type="text" size="20" name="id" value="<%=offre.getId()%>" readonly="readonly">
          </td>
        </tr>
	  	  <tr>
          <th>Titre de l'offre :</th>
	        <td>
	          <input type="text" name="titre" size="20" maxlength="50" value="<%=offre.getTitre()%>">
	        </td>
	  	  </tr>
	      <tr>
          <th>Descriptif de la mission :</th>
	        <td>
	          <textarea rows="7" cols="70" name="descriptif_mission"><%=offre.getDescriptifMission()%></textarea>
	        </td>
	      </tr>
        <tr>
          <th>Profil recherché :</th>
          <td>
            <textarea rows="7" cols="70" name="profil_recherche"><%=offre.getProfilRecherche()%></textarea>
          </td>
        </tr>
        <tr>
          <th>Niveau de qualification :</th>
          <td>
            <table id="tab_interne"><tr><td>
	            		
	            	<%
                	List<NiveauQualification> listeNiveauQualif = serviceNiveauQualif.getNiveauQualif();
	            	
                	for(NiveauQualification niveau : listeNiveauQualif) {
                		
                		int idCheck = offre.getNiveauQualification().getId();
                		
                		if(niveau.getId() == idCheck) {
                			out.println("<input type=\"radio\" name=\"niveau\" value=\""+ niveau.getId() + "\" checked=\"checked\" \">" + niveau.getIntitule() + "<br/>");
                		}
                		else {
                			out.println("<input type=\"radio\" name=\"niveau\" value=\""+ niveau.getId() + "\">" + niveau.getIntitule() + "<br/>");	
                		}
                		
                	}
                %>	  
            </td></tr></table>
          </td>
        </tr>
        <tr>
          <th>Secteur(s) d'activité :</th>
          <td>
            <table id="tab_interne">
                	<%
	                  	
	                	List<SecteurActivite> listeSecteurActivite = serviceSecteurActivite.getSecteurActivite();
                		
	                	for(SecteurActivite secteur : listeSecteurActivite) {
	                		
	                		boolean find = false;
	                		int idSecteur = secteur.getId();
	                		for(SecteurActivite secteurCandidature : offre.getSecteurActivites()) {
	                			int idSecteurCandidature = secteurCandidature.getId();
	                			if(idSecteur == idSecteurCandidature) {
	                				find = true;
	                			}
	                		}
	                		
	                		if(find) {
	                			out.println("<input type=\"checkbox\" name=\"secteur\" value=\""+ secteur.getId()  + "\" checked=\"checked\" >" + secteur.getIntitule() + "<br/>");
	                		}
	                		else {
	                			out.println("<input type=\"checkbox\" name=\"secteur\" value=\""+ secteur.getId()  + "\">" + secteur.getIntitule() + "<br/>");	
	                		}
	                		
	                	}
                	%>
            </table>
          </td>
        </tr>
	  	</table>
		  <p>
		    <input type="submit" value="Enregistrer"/>
		  </p>
		</form>
	<%
  		}
  	}
  	else {
  		%>
  		<p class="erreur">N'essayez pas de pirater le site. Votre adresse ip ("+ request.getRemoteAddr() + ") vient d'être envoyée à la police !</p>
  		<%
  	}
	}
	%>
    </div>

  </body>
  
</html>
