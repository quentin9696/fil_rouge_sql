<%@page import="java.util.Set"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActiviteRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauQualificationRemote,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"
%>
<%
	IServiceNiveauQualificationRemote serviceNiveauQualif = (IServiceNiveauQualificationRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauQualification");
	IServiceSecteurActiviteRemote serviceSecteurActivite = (IServiceSecteurActiviteRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
	IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
	IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
%>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : nouveau cadnidat</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
  <%@include file="header.jsp" %>
  	<div id="content">
  	<%
  		if(utilisateur == null) {
  			%>
  			<p class="erreur">Vous devez être connecté pour utiliser les messages !</p>
  			<%
  		}
  		else {
  			if(utilisateur instanceof Candidature) {
  				%>
  				<p class="erreur">Vous devez être connecté en tant qu'entreprise pour avoir accès à cette fonctionnalitée !</p>
  				<%
  			}
  			else if(utilisateur instanceof Entreprise) {
				
  				Entreprise e = (Entreprise) utilisateur;
  				
		  		if(request.getParameter("id_offre").isEmpty() ) {
		  			%>
		  			<p class="erreur">vous devez spécifier une offre d'emploi</p>
		  			<%
		  		}
		  		else if (request.getParameter("id_cand").isEmpty()) {
		  			%>
		  			<p class="erreur">vous devez spécifier une cnadidature</p>
		  			<%
		  		}
		  		else {
		  			if(request.getParameter("id_offre").matches("^[0-9]+$") && request.getParameter("id_cand").matches("^[0-9]+$")) {
		  				int idOffre = new Integer(request.getParameter("id_offre"));
		  				int idCandidature = new Integer(request.getParameter("id_cand"));

		  				OffreEmploi offre = serviceOffre.getOffreEmploisById(idOffre);
		  				Candidature cand = serviceCandidat.findById(idCandidature);
		  				
		  				if(offre == null || cand == null) {
		  					%>
		  					<p class="erreur">Erreur : L'offre ou la candidature n'éxiste pas/plus !</p>
		  					<%
		  				}
		  				else {
		  					Set<SecteurActivite> listeSecteursActiviteOffre = offre.getSecteurActivites();
		  					Set<SecteurActivite> listeSecteursActiviteCandidature = cand.getSecteurActivites();

		  					boolean find = false;
		  					
							for(SecteurActivite s : listeSecteursActiviteOffre) {
								int idSecteurOffre = s.getId();
								for(SecteurActivite sCand : listeSecteursActiviteCandidature) {
									int idSecteurCand = sCand.getId();
									
									if(idSecteurCand == idSecteurOffre) {
										find = true;
									}
								}
							}
							
							int idNiveauQualificationOffre = offre.getNiveauQualification().getId();
							int idNiveauQualificationCand = cand.getNiveauQualification().getId();
							
							if(idNiveauQualificationCand != idNiveauQualificationOffre) {
								find = false;
							}
							
							int idEntreprise = e.getId();
							int idEntrepriseOffre = offre.getEntreprise().getId();
							
							if(idEntreprise != idEntrepriseOffre) {
								find = false;
							}
							
							if(!find) {
								%>
								<p class="erreur">Erreur : Cette offre ne correspond pas à aux critères</p>
								<%
							}
							else {
								%>
								<h2>Demande d'entretien</h2>
								<form action="traitement_message_envois_candidat.jsp?id_offre=<%=offre.getId()%>&id_cand=<%=cand.getId()%>" method="post">
								  	<table id="affichage">
								  	  <tr>
								  	  	<td>Candidat concerné :</td>
								  	  	<td><%=cand.getNom()%> <%=cand.getPrenom()%></td>
								  	  </tr>
								  	  <tr>
								  	  	<td>Message :</td>
								  	  	<td><textarea rows="7" cols="70" name="message"></textarea></td>
								  	  </tr>
								  	</table>
									  <p>
			    						<input type="submit" value="Envoyer"/>
			 						  </p>
		 						  </form>
								  
								<%
							}
		  				}
		  				
		  			}
		  			else {
		  				%>
		  				<p class="erreur">N'essayez pas pirater le site. Votre adresse (<%=request.getRemoteAddr()%>) a été envoyé à la police !</p>
		  				<%
		  			}
		  		}
  			}
  		}
  	%>
	</div>
  </body>
  
</html>
