<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
<h2>Connexion au système</h2>

<p style="font-style: italic;">
  Pour une entreprise, l'identifiant est de la forme ENT_ + clé primaire (ENT_1 par exemple)
  et CAND_ + clé primaire (CAND_1 par exemple) pour une candidature.
</p>

<%
  String identifiant = request.getParameter("identifiant");
  if(identifiant == null) // Pas de paramètre "identifiant" => affichage du formulaire
  {
  	%>
		<form action="connexion.jsp" method="get">
		  <!-- <input type="hidden" name="action" value="connexion" /> -->
		  <p>
		    Identifiant : <input type="text" name="identifiant"/>
		  </p>
		  <p>
		    <input type="submit" value="Connexion"/>
		  </p>
		</form>
  	<%
  }
  else                    // Paramètre "identifiant" existant => connexion
  {
  	if(identifiant.equals(""))
  	{
      %>
      <p class="erreur">Veuillez renseignez votre numéro d'identifiant pour pouvoir vous connecter</p>
      <a href="index.jsp">Retour...</a>
      <%
  	}
    else if(identifiant.startsWith("ENT_"))
  	{
  		IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
  		int id = Integer.parseInt(identifiant.substring(4)); // On enlève le préfixe "ENT_";
  		Entreprise entreprise = serviceEntreprise.getEntreprise(id);
  		if(entreprise == null)
  		{
  			%>
  			<p class="erreur">Erreur : il n'y a pas d'entreprise avec cet identifiant : <%=identifiant%></p>
  			<a href="index.jsp">Retour...</a>
  			<%
  		}
  		else
  		{
        session.setAttribute("utilisateur",entreprise);
        response.sendRedirect("index.jsp");
  		}
  	}
  	else if(identifiant.startsWith("CAND_"))
  	{
  		IServiceCandidat serviceCandidature = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
  		int id = Integer.parseInt(identifiant.substring(5)); // On enlève le préfixe "CAND_";
  		Candidature candidature = serviceCandidature.findById(id);
      if(candidature == null)
      {
        %>
        <p class="erreur">Erreur : il n'y a pas de candidature avec cet identifiant : <%=identifiant%></p>
        <a href="index.jsp">Retour...</a>
        <%
      }
      else
      {
        session.setAttribute("utilisateur",candidature);
        response.sendRedirect("index.jsp");
      }
  	}
  }
%>
</body>

