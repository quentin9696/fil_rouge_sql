<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.List"
%>
<%
// Récupération du service (bean session)
	IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
%>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : Nouvelle entreprise référencée</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>

		<%
		
		%>
			
		<a href="index.jsp">Retour au menu</a>
		

  </body>
  
</html>
