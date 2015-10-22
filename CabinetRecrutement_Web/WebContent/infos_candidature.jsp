<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.*"%>

<%
  // Récupération du service (bean session)
	IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
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
	  		out.println("La candidature doit être spécifiée <br/>");
	  	}
	  	else if (request.getParameter("id").matches("^[0-9]*$")) {
	  		
	  		int id = new Integer(request.getParameter("id"));
	  		
	  		Candidature c = serviceCandidat.findById(id);
	  		
	  		if(c == null) {
	  			out.println("La candidature " + id + " n'a pas été trouvée ! <br/>");
	  		}
	  		else {
		%>
			 <h2>Infos candidature :</h2>
    
    
	     <table id="affichage">
	      <tr>
	        <th style="width: 170px;">Identifiant :</th>
	        <td>
	          CAND_<%=c.getId()%>
	        </td>
	      </tr>
	       <tr>
	         <th>nom :</th>
	         <td>
	           <%=c.getNom()%>
	         </td>
	       </tr>
	       <tr>
	         <th>Prénom :</th>
	         <td>
	           <%=c.getPrenom()%>
	         </td>
	       </tr>
	       <tr>
	         <th>Date de naissance :</th>
	         <td>
	           <%
	           		if(c.getDateNaissance() != null) {
	           			out.println(Utils.date2String(c.getDateNaissance()));
	           		}
	           		else {
	           			out.println("[aucune date]");
	           		}
	           %>
	         </td>
	       </tr>
	       <tr>
	        <th>Adresse postale (ville) :</th>
	        <td>
	        	<%
	          	if(c.getAdressePostale() != null) {
	        		out.println(c.getAdressePostale());
	        	}
	        	else {
	        		%>[Aucune adresse]<%
	        	}
	        	%>
	        </td>
	      </tr>
	      <tr>
	        <th>Adresse email :</th>
	        <td>
	        	<%
	        	if(c.getAdresseEmail() != null) {
	        		%>
	        		<a href="mailto:<%=c.getAdresseEmail()%>"><%=c.getAdresseEmail()%></a>
	        		<%
	        	}
	        	else {
	        		%>[Aucune adresse mail]<%
	        	}
	        	%>
	          
	        </td>
	      </tr>
	      <tr>
	        <th>Curriculum vitæ :</th>
	        <td>
	          <%
	        	if(c.getCv() != null) {
	        		out.println(Utils.text2HTML(c.getCv()));
	        	}
	        	else {
	        		%>[Aucun CV]<%
	        	}
	        	%>
	        </td>
	      </tr>
	      <tr>
	        <th>Niveau de qualification :</th>
	        <td>
	          <%=c.getNiveauQualification().getIntitule()%>
	        </td>
	      </tr>
	      <tr>
	        <th>Secteur(s) d'activité :</th>
	        <td>
	          <ul>
	           		
	           		<%
	           		
	           		Set<SecteurActivite> liste = c.getSecteurActivites();
	           		
	           		if(liste == null) {
	           			out.println("null ! ");
	           		}
	           		else {
	           		
	           		for(SecteurActivite s : c.getSecteurActivites()) {
	           			%>
	           			<li><%=s.getIntitule()%></li>
	           			<%
	           		}
	           		}
	           		%>
	          </ul>
	        </td>
	      </tr>
	      <tr>
	        <th>Date de dépôt :</th>
	        <td>
	          <%=Utils.date2String(c.getDateDepot())%>
	        </td>
	      </tr>
	    </table>
			
		<%
  			}
	  	}
	  	else {
	  		out.println("N'essayez pas de pirater le site. Votre adresse ip ("+ request.getRemoteAddr() + ") vient d'être envoyée à la police ! <br/>");
	  	}
	%>
    </div>
  </body>
  
</html>

