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

