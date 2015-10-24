<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi"%>
<%@page import="java.util.List"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreEmploi"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

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
				<p class ="erreur">Seul les entreprises peuvent accèder à cette page.
				<%
			}
			else if(utilisateur instanceof Entreprise) {
			
				Entreprise e  = (Entreprise) utilisateur;
				
				if(request.getParameter("id").isEmpty()) {
			  		out.println("L'offre d'emploi doit être spécifiée <br/>");
			  	}
			  	else if (request.getParameter("id").matches("^[0-9]*$")) {
			  		
			  		int id = new Integer(request.getParameter("id"));
			  		IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
			  		
			  		OffreEmploi offre = serviceOffre.getOffreEmploisById(id);
			  		
			  		if(offre == null) {
			  			out.println("<p class =\"error\">L'offre d'emploi " + id + " n'a pas été trouvée !</p>");
			  		}
			  		else {
			  			int idEntreprise = e.getId();
			  			
			  			if(offre.getEntreprise().getId() != idEntreprise) {
			  				%>
			  				<p>Vous ne pouvez pas supprimer une offre qui n'est pas de votre entreprise :-0</p>
			  				<%
			  			}
			  			else {
			  				
			  				int idOffre = offre.getId();
			  				
			  				
							IServiceMessageOffreEmploi serviceMessageOffre = (IServiceMessageOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageOffreEmploi");
			  				List<MessageOffreDemploi> listeMessages = serviceMessageOffre.getAll();
			  				
			  				for(MessageOffreDemploi message : listeMessages) {
			  					
			  					int idOffreMessage = message.getOffreEmploi().getId();
			  					
			  					if(idOffre == idOffreMessage) {
			  						
			  						serviceMessageOffre.remove(message);
			  						
			  					}
			  				}
			  				
			  				IServiceMessageCandidature serviceMessageCandidature = (IServiceMessageCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageCandidature");
			  				List<MessageCandidature> listeMessagesCand = serviceMessageCandidature.getAll();
			  				
			  				for(MessageCandidature message : listeMessagesCand) {
			  					
			  					int idOffreMessage = message.getOffreEmploi().getId();
			  					
			  					if(idOffre == idOffreMessage) {
			  						
			  						serviceMessageCandidature.remove(message);
			  						
			  					}
			  				}
			  				serviceOffre.removeOffre(offre);			  				
			  				%>
			  				<p>L'offre vient d'être supprimée et retiré du site.</p>
			  				<%
			  			}
			  		}
			  	}
			  	else {
			  		%>
			  		<p class="erreur">N'essayer pas pirater le site ! </p>
			  		<%
			  	}


		  	}
		%>
		</div>
  </body>
  
</html>

