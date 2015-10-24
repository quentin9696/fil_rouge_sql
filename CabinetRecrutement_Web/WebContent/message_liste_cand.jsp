<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreEmploi"%>
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
  			if(utilisateur instanceof Entreprise) {
  				%>
  				<h2>Liste des messages envoyé :</h2>
  				
  				   <table id="affichage">
				      <tr>
				        <th>Id</th>
				        <th>Candidature</th>
				        <th>Offre</th>
				        <th>Date envoi</th>
				        <th>Message</th>
				      </tr>
  				<%
  				
  				Entreprise e = (Entreprise) utilisateur;
  				
  				List<MessageCandidature> listeMessages = serviceMessageCandidature.getAll();
  				
  				int idEnt = e.getId();
  				
  				for(MessageCandidature message : listeMessages) {
  					int idEntMess = message.getOffreEmploi().getEntreprise().getId();
  					
  					if(idEnt == idEntMess) {
  						%>
  						<tr>
				         <td><%=message.getId()%></td>
				         <td><a href="infos_candidature.jsp?id=<%=message.getCandidature().getId()%>"><%=message.getCandidature().getNom()%> <%=message.getCandidature().getPrenom()%> (CAND_<%=message.getCandidature().getId()%>)</a></td>
				         <td>Offre n° <%=message.getOffreEmploi().getId()%> -> <a href="infos_offre_emplois.jsp?id=<%=message.getOffreEmploi().getId()%>"><%=message.getOffreEmploi().getTitre()%></a></td>
				         <td><%=Utils.date2String(message.getDateEnvoi())%></td>
				         <td><%=Utils.text2HTML(message.getCorpsMessage())%></td>
				        </tr>
				       	<%
  					}
  				}
  				%>
  				</table>
  				<%
  			}
  			else if(utilisateur instanceof Candidature) {
  				%>
  				<h2>Liste des messages reçu :</h2>
  				
  				   <table id="affichage">
				      <tr>
				        <th>Id</th>
				        <th>Offre</th>
				        <th>Date envoi</th>
				        <th>Message</th>
				      </tr>
  				<%
  				
  				Candidature c = (Candidature) utilisateur;
  				
  				List<MessageCandidature> listeMessages = serviceMessageCandidature.getAll();
  				
  				int idCand = c.getId();
  				
  				for(MessageCandidature message : listeMessages) {
  					int idCandMess = message.getCandidature().getId();
  					
  					if(idCand == idCandMess) {
  						%>
  						<tr>
				         <td><%=message.getId()%></td>
				         <td>Offre n° <%=message.getOffreEmploi().getId()%> -> <a href="infos_offre_emplois.jsp?id=<%=message.getOffreEmploi().getId()%>"><%=message.getOffreEmploi().getTitre()%> (<%=message.getOffreEmploi().getEntreprise().getNom()%>)</a></td>
				         <td><%=Utils.date2String(message.getDateEnvoi())%></td>
				         <td><%=Utils.text2HTML(message.getCorpsMessage())%></td>
				        </tr>
				       	<%
  					}
  				}
  				%>
  				</table>
  				<%
  			}
  		}
  	%>
	</div>
  </body>
  
</html>
