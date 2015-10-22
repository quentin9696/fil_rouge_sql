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
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : Information sur une offre d'emploi référencée</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  <%@include file="header.jsp" %>
  		<div id="content">
  <%
  	if(request.getParameter("id").isEmpty()) {
  		%>
  		<p class="erreur" >L'offre d'emploi doit être spécifiée</p>
  		<%
  	}
  	else if (request.getParameter("id").matches("^[0-9]*$")) {
  		
  		int id = new Integer(request.getParameter("id"));
  		OffreEmploi offre = serviceOffre.getOffreEmploisById(id);
  		if(offre == null) {
  			%>
  			<p class="erreur" >L'offre n'a pa été trouvée. </p>
  			<%
  		}
  		else {
  %>
		<h2>Infos offre d'emploi :</h2>
    
    
    
    
      <table id="affichage">
        <tr>
          <th style="width: 170px;">Numéro de l'offre :</th>
          <td>
            <%=offre.getId()%>
          </td>
        </tr>
        <tr>
          <th>Titre :</th>
          <td>
            <%=offre.getTitre()%>
          </td>
        </tr>
        <tr>
          <th>Entreprise :</th>
          <td>
            <u><%=offre.getEntreprise().getNom()%></u><br/> 
            <%=Utils.text2HTML(offre.getEntreprise().getDescriptif())%>
          </td>
        </tr>
        <tr>
          <th>Descriptif de la mission :</th>
          <td>
            <%=offre.getDescriptifMission()%>
          </td>
        </tr>
        <tr>
          <th>Profil recherché :</th>
          <td>
            <%=offre.getProfilRecherche()%>
          </td>
        </tr>
        <tr>
          <th>Lieu de la mission :</th>
          <td>
            <%=offre.getEntreprise().getAdressePostale()%>
          </td>
        </tr>
        <tr>
          <th>Niveau de qualification :</th>
          <td>
            <%=offre.getNiveauQualification().getIntitule()%>
          </td>
        </tr>
        <tr>
          <th>Secteur(s) d'activité :</th>
          <td>
            <ul>
             <% 
				Set<SecteurActivite> liste = offre.getSecteurActivites();
             
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
          	<%=Utils.date2String(offre.getDateDepot())%>
          </td>
        </tr>
      </table>
	<%
  		}
  	}
  	else {
  		%>
  		<p class="erreur">N'essayez pas de pirater le site. Votre adresse ip (<%=request.getRemoteAddr()%>) vient d'être envoyée à la police !</p>
  		<%
  	}
	%>
	
	</div>
  </body>
  
</html>
