<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature"%>
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
	IServiceMessageCandidature serviceMessageCandidature = (IServiceMessageCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageCandidature");
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
								
								String message = request.getParameter("message");
								if(message == null) {
									%>
									<p class="erreur">Erreur : Vous devez taper du texte dans le message !</p>
									<%
								}
								else {
									if(message.isEmpty()) {
										%>
										<p class="erreur">Erreur : Vous devez taper du texte dans le message !</p>
										<%
									}
									else {
										MessageCandidature messageCandidature = new MessageCandidature();
										messageCandidature.setCorpsMessage(message);
										messageCandidature.setCandidature(cand);
										messageCandidature.setOffreEmploi(offre);
										messageCandidature.setDateEnvoi(new Timestamp(new Date().getTime()));
										
										try {
											MessageCandidature messageCand = serviceMessageCandidature.addMessage(messageCandidature);
											%>
											<h2>Nouveau message enregistré :</h2>
											<table id="affichage">
											  <tr>
											    <th style="width: 170px;">Id :</th>
											    <td><%=messageCand.getId()%></td>
											  </tr>
										      <tr>
										        <th>Offre emploi concernée :</th>
										        <td><%=messageCand.getOffreEmploi().getTitre()%> (<%=messageCand.getOffreEmploi().getEntreprise().getNom()%>)</td>
										      </tr>
										      <tr>
										        	<th>Candidature :</th>
										        	<td><%=messageCand.getCandidature().getNom()%> <%=messageCand.getCandidature().getPrenom()%> (CAND_<%=messageCand.getCandidature().getId()%>)</td>
									      		</tr>
										      <tr>
										        <th>Date d'envoi :</th>
										        <td><%=Utils.date2String(messageCand.getDateEnvoi())%></td>
										      </tr>
											  <tr>
											    <th>Corps du message :</th>
											    <td>
											      <%=Utils.text2HTML(messageCand.getCorpsMessage())%>
											    </td>
											  </tr>
											</table>
											<%
										}
										catch(Exception exp) {
											exp.printStackTrace();
										}
									}
								}
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
