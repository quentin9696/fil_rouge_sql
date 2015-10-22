<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
  Object utilisateur = session.getAttribute("utilisateur");
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
    <h2>Menu principal</h2>
    
    <ul>
    	<%
  	  if(utilisateur == null)
  	  {
  	    %>
  	   	<li><a href="connexion.jsp">Connexion</a></li>
  	    <%
  	  }
  	  else
  	  {
  	  	if(utilisateur instanceof Entreprise)
  	  	{
  	  		Entreprise e = (Entreprise) utilisateur;
  	  		%>
  	  	<li><a href="deconnexion.jsp">(ENT_<%=e.getId()%>) Deconnexion</a></li>
  	  		<%
  	  	}
  	  	else if(utilisateur instanceof Candidature) {
  	  		Candidature c = (Candidature) utilisateur;
	  		%>
	  	<li><a href="deconnexion.jsp">(CAND_<%=c.getId()%>) Deconnexion</a></li>
	  		<%
  	  	}
  	  }
  	%>
    	
    	<li><a href="creation_entreprise.jsp">Création d'une nouvelle entreprise</a></li>
    	<li><a href="liste_entreprises.jsp">Liste des entreprises référencées</a></li>
    	<li><a href="liste_offres.jsp">Liste des offres d'emplois référencées</a></li>
    	<li><a href="creation_candidature.jsp">Création d'un nouveau candidat</a></li>
    	<li><a href="liste_candidature.jsp">Liste des candidature</a></li>
    	<%
    	if(utilisateur != null)
    	  {
    		if(utilisateur instanceof Entreprise)
    	  	{
    	  		Entreprise e = (Entreprise) utilisateur;
    	  		%>
    	  	<li><a href="liste_offres_entreprise.jsp">Liste de mes offres d'emplois</a></li>
    	  		<%
    	  	}
    	  }
    	%>
    </ul>
  
  </body>

</html>
