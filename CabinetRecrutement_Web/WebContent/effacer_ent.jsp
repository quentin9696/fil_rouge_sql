<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreEmploi"%>
<%@page import="java.util.List"%>
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
				
			  		IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
			  		
			  		List<OffreEmploi> offres = serviceOffre.getOffreEmploisByEntreprise(e.getId());
			  		
			  		if(offres != null && offres.size() > 0) {
			  			for(OffreEmploi o : offres) {
							int idOffre = o.getId();
			  				
			  				
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
			  				serviceOffre.removeOffre(o);
			  			}
			  		}
			  		
			  		IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
			  		
			  		serviceEntreprise.removeEntreprise(e);
			  		response.sendRedirect("deconnexion.jsp");
			  		
			  	}
		%>
		</div>
  </body>
  
</html>

