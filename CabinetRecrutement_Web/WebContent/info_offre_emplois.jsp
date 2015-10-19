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
  // R�cup�ration du service (bean session)
	 IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : liste des entreprises r�f�renc�es</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  <%
  	if(request.getParameter("id").isEmpty()) {
  		out.println("L'offre d'emploi doit �tre sp�cifi�e <br/>");
  	}
  	else if (request.getParameter("id").matches("^[0-9]*$")) {
  		
  		//int id = new Integer(request.getParameter("id"));
  		int id = 1;
  		OffreEmploi offre = serviceOffre.getOffreEmploisById(id);
  		if(offre == null) {
  			out.println("L'offre d'emploi " + id + " n'a pas �t� trouv�e ! <br/>");
  		}
  		else {
  %>
		<h2>Infos offre d'emploi :</h2>
    
    
    
    
      <table id="affichage">
        <tr>
          <th style="width: 170px;">Num�ro de l'offre :</th>
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
            <u><%=offre.getEntreprise().getNom()%></u>
          </td>
        </tr>
        <tr>
          <th>Descriptif de la mission :</th>
          <td>
            <%=offre.getDescriptifMission()%>
          </td>
        </tr>
        <tr>
          <th>Profil recherch� :</th>
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
          <th>Secteur(s) d'activit� :</th>
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
          <th>Date de d�p�t :</th>
          <td>
          	<%=offre.getDateDepot()%>
          </td>
        </tr>
      </table>
	<%
  		}
  	}
  	else {
  		out.println("N'essayez pas de pirater le site. Votre adresse ip ("+ request.getRemoteAddr() + ") vient d'�tre envoy�e � la police ! <br/>");
  	}
	%>
    <a href="index.jsp">Retour au menu</a>

  </body>
  
</html>
