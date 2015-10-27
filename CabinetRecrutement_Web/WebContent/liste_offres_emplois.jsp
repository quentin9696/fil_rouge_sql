<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedList"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                java.util.List"%>

<%
  // Récupération du service (bean session)
	 IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
	// Appel de la fonctionnalité désirée auprès du service
	List<OffreEmploi> listes = serviceOffre.getOffreEmplois();
%>
  	<%@include file="header.jsp" %>
  		<div id="content">
			<h2>Liste des offres d'emploi référencées :</h2>
			
			<table id="affichage">
			  <tr>
			    <th>Numéro</th>
			    <th>Titre</th>
			    
			    <th>Entreprise</th>
			    <th>Niveau de qualification</th>
			    <th>Date de dépôt</th>
			    
			  </tr>
			  
			      
			       <%
			       	for(OffreEmploi offre : listes) {
			       		%> 
			       		<tr>
				       		<td><%=offre.getId()%></td>
				       		<td><a href="infos_offre_emplois.jsp?id=<%=offre.getId()%>"><%=offre.getTitre()%></a></td>
				       		<td><%=offre.getEntreprise().getNom()%></td>
				       		<td><%=offre.getNiveauQualification().getIntitule()%></td>
				       		<td><%=Utils.date2String(offre.getDateDepot())%></td>
			       		<tr>
			       	<%
			       	}
			       %> 
			</table>
			<p align="center"><a href="cabinet_recrutement_offres_rss.jsp"><img src="images/icone_rss.png" alt="" border="0"/></a></p>
		</div>

  </body>
  
</html>
