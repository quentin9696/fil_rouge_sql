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
  
  <%@include file="header.jsp" %>
  		<div id="content">
	<h2>Référencer un nouveau candidat</h2>
    
    <form action="traitement_candidature.jsp" method="post">
    
	  	<table id="affichage">
	  	  <tr>
          <th style="width: 170px">Nom :</th>
	        <td>
	          <input type="text" name="nom" size="20" maxlength="50">
	        </td>
	  	  </tr>
        <tr>
          <th>Prénom :</th>
          <td>
            <input type="text" name="prenom" size="20" maxlength="50">
          </td>
        </tr>
        <tr>
          <th>Date de naissance<br/>(format jj/mm/aaaa) :</th>
          <td>
            <input type="text" name="date_naissance" size="10" maxlength="10">
          </td>
        </tr>
        <tr>
          <th>Adresse postale (ville) :</th>
          <td>
            <input type="text" name="adresse_postale" size="20" maxlength="30">
          </td>
        </tr>
        <tr>
          <th>Adresse email :</th>
          <td>
            <input type="text" name="adresse_email" size="30" maxlength="100">
          </td>
        </tr>
        <tr>
          <th>Curriculum vitæ :</th>
          <td>
            <textarea rows="7" cols="70" name="cv"></textarea>
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
	</div>
  </body>
  
</html>
