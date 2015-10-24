<%@page import="com.sun.faces.facelets.impl.IdMapper"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreEmploi"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="java.util.List"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  		
  		<%@include file="header.jsp" %>
  		<div id="content">
  		
		<%
			if(utilisateur == null) {
				%>
				<p class="erreur">Vous n'êtes pas connecté !</p>
				<%	
			}
			else if(utilisateur instanceof Entreprise) {
				%>
				<p class ="erreur">Seul les candidats peuvent accèder à cette page.
				<%
			}
			else if(utilisateur instanceof Candidature) {
			
				Candidature c  = (Candidature) utilisateur;
			  		
				int idCand = c.getId();
				
				IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
			  		
				IServiceMessageOffreEmploi serviceMessageOffre = (IServiceMessageOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageOffreEmploi");
  				List<MessageOffreDemploi> listeMessages = serviceMessageOffre.getAll();
  				
  				for(MessageOffreDemploi message : listeMessages) {
  					
  					int idCandMessage = message.getCandidature().getId();
  					
  					if(idCand == idCandMessage) {
  						
  						serviceMessageOffre.remove(message);
  						
  					}
  				}
  				
  				IServiceMessageCandidature serviceMessageCandidature = (IServiceMessageCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageCandidature");
  				List<MessageCandidature> listeMessagesCand = serviceMessageCandidature.getAll();
  				
  				for(MessageCandidature message : listeMessagesCand) {
  					
  					int idCandMessage = message.getCandidature().getId();
  					
  					if(idCand == idCandMessage) {
  						
  						serviceMessageCandidature.remove(message);
  						
  					}
  				}
					
				
		  		serviceCandidat.removeCandidat(c);
		  		response.sendRedirect("deconnexion.jsp");
		  		
		  	}
		%>
		</div>
  </body>
  
</html>

