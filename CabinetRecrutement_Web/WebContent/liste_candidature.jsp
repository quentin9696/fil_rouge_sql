<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"%>

<%
  // R�cup�ration du service (bean session)
	IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
// Appel de la fonctionnalit� d�sir�e aupr�s du service
	List<Candidature> listeCandidatures = serviceCandidat.findAllCandidatures();
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : liste des candidatures r�f�renc�es</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  		<%@include file="header.jsp" %>
  		<div id="content">
  		<%
  		if(listeCandidatures == null) {
  			out.println("Aucune candidature r�f�renc�e");
  		}
  		else {
  		%>
  		
		<h2>Liste des candidatures r�f�renc�es :</h2>

		<table id="affichage">
		  <tr>
		    <th>Identifiant</th>
		    <th>Nom/pr�nom</th>
		    <th>Adresse postale</th>
		    <th>Adresse email</th>
		    <th>Niveau de qualification</th>
		    <th>Date de d�p�t</th>
		  </tr>
		  
		  	
		  	<%
		  		for(Candidature c : listeCandidatures) {
		  			%>
		  			<tr>
					     <td>CAND_<%=c.getId()%></td>
					     <td><a href="infos_candidature.jsp?id=<%=c.getId()%>"><%=c.getNom()%> <%=c.getPrenom()%></a></td>
					     <td><%=((!c.getAdressePostale().isEmpty()) ? c.getAdressePostale() : "[Aucune adresse postale]")%></td>
					     <td>
					     <%
					     	if(c.getAdresseEmail() != null && !c.getAdresseEmail().isEmpty()) {
					     		%>
								<a href="mailto:"<%=c.getAdresseEmail()%>"><%=c.getAdresseEmail()%></a>
								<%
					     	}
					     	else {
					     		out.println("[Aucune adresse mail]");
					     	}
					     %></td>
					     <td><%=c.getNiveauQualification().getIntitule()%></td>
					     <td><%=Utils.date2String(c.getDateDepot())%></td>
				  	</tr>
		  			<%
		  		}
		  	%>
		  	
		</table>
	<% 
		}
  	%>
    </div>
  </body>
  
</html>
