<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                java.util.List"%>

<%
  // R�cup�ration du service (bean session)
	 IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
	// Appel de la fonctionnalit� d�sir�e aupr�s du service
	List<OffreEmploi> listes = serviceOffre.getOffreEmplois();
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : liste des entreprises r�f�renc�es</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
  	<%@include file="header.jsp" %>
  		<div id="content">
			<h2>Liste des offres d'emploi r�f�renc�es :</h2>
			
			<table id="affichage">
			  <tr>
			    <th>Num�ro</th>
			    <th>Titre</th>
			    
			    <th>Entreprise</th>
			    <th>Niveau de qualification</th>
			    <th>Date de d�p�t</th>
			    
			  </tr>
			  
			      <tr>
			       <%
			       	for(OffreEmploi offre : listes) {
			       		%> <td><%=offre.getId()%></td>
			       		<td><a href="infos_offre_emplois.jsp?id=<%=offre.getId()%>"><%=offre.getTitre()%></a></td>
			       		<td><%=offre.getEntreprise().getNom()%></td>
			       		<td><%=offre.getNiveauQualification().getIntitule()%></td>
			       		<td><%=Utils.date2String(offre.getDateDepot())%></td>
			       	<%
			       	}
			       %>
			      </tr>   
			</table>
		</div>

  </body>
  
</html>
