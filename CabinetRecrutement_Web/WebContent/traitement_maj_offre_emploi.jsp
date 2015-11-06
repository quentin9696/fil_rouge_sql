<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi"%>
<%@page import="com.sun.xml.ws.rx.rm.protocol.wsrm200502.OfferType"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauQualificationRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActiviteRemote"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.*,
                java.sql.Timestamp,
                java.util.regex.*,
                java.text.SimpleDateFormat"
%>
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
  	  		<p class="erreur">Erreur : seule les entreprises peuvent ajouter des offres d'emplois.</p>
  	  		<%
  	  	}
  	  	else if(utilisateur instanceof Candidature) {
  	  		%>
  	  		<p class="erreur">Erreur : seule les entreprises peuvent ajouter des offres d'emplois.</p>
  	  		<%
  	  	}
  	  	else if(utilisateur instanceof Entreprise) {
  	  		
  	  		Entreprise e = (Entreprise) utilisateur;
  	  		
  	  		int idEnt = e.getId();
  	  		int idOffre = new Integer(request.getParameter("id"));
			
  	  		OffreEmploi offre = serviceOffre.getOffreEmploisById(idOffre);
  	  		
  	  		if(offre == null) {
  	  			%>
  	  			<p class="erreur">L'offre n'existe pas !</p>
  	  			<%
  	  		}
  	  		else {
  	  			
	  	  		if(offre.getEntreprise().getId() != idEnt) {
	  	  			%>
	  	  			<p class="erreur">Vous ne pouvez pas modifier une offre qui n'est pas de votre entreprise</p>
	  	  			<%
	  	  		}
	  	  		else {
	  	  			
	  	  			String titre = request.getParameter("titre");
	  	  			String descriptifMission = request.getParameter("descriptif_mission");
	  	  			String profilRecherche = request.getParameter("profil_recherche");
	  	  			
	  	  			
	  	  			if(titre != null) {
		  	  			if(request.getParameter("niveau") == null) {
					  		%>
			  	  			<p>Erreur : le niveau de qualification doit être spécifiée</p>
			  	  			<%
					  	}
					  	else if (request.getParameter("niveau").matches("^[0-9]*$")) {
					  		
					  		int id = new Integer(request.getParameter("niveau"));
					  		NiveauQualification niveau = serviceNiveauQualif.getNiveauQualificationById(id);
					  		
					  		if(niveau != null) {
						  			
					  			OffreEmploi offreModif = new OffreEmploi();
					  			offreModif.setId(idOffre);
					  			offreModif.setTitre(titre);
					  			offreModif.setDescriptifMission(descriptifMission);
					  			offreModif.setProfilRecherche(profilRecherche);
						  		offreModif.setNiveauQualification(niveau);
						  		offreModif.setEntreprise(e);
						  		offreModif.setDateDepot(offre.getDateDepot());
						  		
						  	//Recupere la checkBox !
					  			String[] checkboxes = request.getParameterValues("secteur");
						  	
						  		if(checkboxes == null) {
						  			%>
						  			<p class="erreur">Il faut au moins 1 secteur d'activité !</p>
						  			<%	
						  		}
						  		else {
						  		
						  		offreModif = serviceOffre.updateOffre(offreModif);
						  		
						  		Set<SecteurActivite> listeSecteurActivite = offre.getSecteurActivites();
						  		listeSecteurActivite.clear();	    
						  		
								    
						  			
						  			if (checkboxes != null && checkboxes.length > 0) {
						  				
						  				for(int i = 0; i<checkboxes.length; i++) {
						  					
						  					int secteurID = new Integer(checkboxes[i]);
						  					
						  					SecteurActivite s = serviceSecteurActivite.getSecteurActiviteById(secteurID);
						  					
						  					if( s != null) {
						  						listeSecteurActivite.add(s);
						  					}
						  					else  {
						  						out.println("<p class=\"erreur\">N'essayez pas de pirater le site. Votre adresse ip ("+ request.getRemoteAddr() 
						  					  			+ "vient d'être envoyée à la police !</p>");
						  						System.exit(-1);	
						  					}
						  				}
						  			}
						  			
						  			offreModif.setSecteurActivites(listeSecteurActivite);
						  			offreModif = serviceOffre.updateOffre(offreModif);
						  			%>
						  			<h2>L'offre vient d'être modifiée :</h2>
						  			<table id="affichage">
								        <tr>
								          <th style="width: 170px;">Numéro de l'offre :</th>
								          <td>
								            <%=offreModif.getId()%>
								          </td>
								        </tr>
								        <tr>
								          <th>Titre :</th>
								          <td>
								            <%=offreModif.getTitre()%>
								          </td>
								        </tr>
								        <tr>
								          <th>Entreprise :</th>
								          <td>
								            <u><%=offreModif.getEntreprise().getNom()%></u><br/> 
								            <%=Utils.text2HTML(offreModif.getEntreprise().getDescriptif())%>
								          </td>
								        </tr>
								        <tr>
								          <th>Descriptif de la mission :</th>
								          <td>
								            <%=offreModif.getDescriptifMission()%>
								          </td>
								        </tr>
								        <tr>
								          <th>Profil recherché :</th>
								          <td>
								            <%=offreModif.getProfilRecherche()%>
								          </td>
								        </tr>
								        <tr>
								          <th>Lieu de la mission :</th>
								          <td>
								            <%=offreModif.getEntreprise().getAdressePostale()%>
								          </td>
								        </tr>
								        <tr>
								          <th>Niveau de qualification :</th>
								          <td>
								            <%=offreModif.getNiveauQualification().getIntitule()%>
								          </td>
								        </tr>
								        <tr>
								          <th>Secteur(s) d'activité :</th>
								          <td>
								            <ul>
								             <% 
												Set<SecteurActivite> liste = offreModif.getSecteurActivites();
								             
								             	for(SecteurActivite secteur : liste){
								            	 	out.println("<li>"+ secteur.getIntitule() +"</li>");
								            	}
								           	%>  
								            </ul>
								          </td>
								        </tr>
								        <tr>
								          <th>Date de dépôt :</th>
								          <td>
								          	<%=Utils.date2String(offreModif.getDateDepot())%>
								          </td>
								        </tr>
								      </table>
						  			
						  			<%
					  			}
					  		}
					  		}
					  	else {
					  		%>
					  		<p class="erreur">Essaye pas pirater le site ! </p>
					  		<%
					  	}
	  	  			}
	  	  			else {
	  	  				%>
	  	  				<p class="erreur">Le titre doit être renseigné !</p>
	  	  				<%
	  	  			}
	  	  		}
  	  		}
  	  	}
  	  		%>

  		</div>

  </body>
  
</html>
