<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActiviteRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauQualificationRemote,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"
%>
<%
IServiceNiveauQualificationRemote serviceNiveauQualif = (IServiceNiveauQualificationRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauQualification");
IServiceSecteurActiviteRemote serviceSecteurActivite = (IServiceSecteurActiviteRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
%>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : nouveau cadnidat</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  	<%@include file="header.jsp" %>
  	<div id="content">
  	<%
  		
  	if(utilisateur == null) {
  		%>
  		<p class="erreur">Erreur : seule les entreprises peuvent ajouter des offres d'emplois.</p>
  		<%
  	}
  	else if(utilisateur instanceof Candidature) {
  		%>
  		<p class="erreur">Erreur : seule les entreprises peuvent ajouter des offres d'emplois.</p>
  		<%
  	}
  	else if(utilisateur instanceof Entreprise) {
  		
  	%>
	<h2>Référencer un nouvelle offre d'emploi</h2>
    
    <form action="traitement_offre_emploi.jsp" method="post">
    
	  	<table id="affichage">
	  	  <tr>
	         <th style="width: 170px">Titre :</th>
	        <td>
	          <input type="text" name="titre" size="20" maxlength="50">
	        </td>
	  	  </tr>
        <tr>
          <th>Descriptif :</th>
          <td>
            <textarea rows="7" cols="70" name="desc"></textarea>
          </td>
        </tr>
        <tr>
	         <th style="width: 170px">Profil recherché :</th>
	        <td>
	          <input type="text" name="profil" size="20" maxlength="50">
	        </td>
	  	  </tr>
        <tr>
          <th>Niveau de qualification :</th>
          <td>
            <table id="tab_interne"><tr><td>
              
                <%
                	List<NiveauQualification> listeNiveauQualif = serviceNiveauQualif.getNiveauQualif();
                	for(NiveauQualification niveau : listeNiveauQualif) {
                		out.println("<input type=\"radio\" name=\"niveau\" value=\""+ niveau.getId() + "\">" + niveau.getIntitule() + "<br/>");
                	}
                %>
                
				</td></tr></table>
          </td>
        </tr>
        <tr>
          <th>Secteur(s) d'activité :</th>
          <td>
            <table id="tab_interne">
                	<%
	                  	int j = 0;
	                	List<SecteurActivite> listeSecteurActivite = serviceSecteurActivite.getSecteurActivite();
	                	for(SecteurActivite secteur : listeSecteurActivite) {
	                		
	                		out.println("<input type=\"checkbox\" name=\"secteur\" value=\""+ secteur.getId()  + "\">" + secteur.getIntitule() + "<br/>");
	                	}
                	%>
            </table>
          </td>
        </tr>
	  	</table>
		  <p>
		    <input type="submit" value="Enregistrer"/>
		  </p>
		</form>
    <%
  	}
    %>
	</div>
  </body>
  
</html>
