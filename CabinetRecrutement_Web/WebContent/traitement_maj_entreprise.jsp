<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"
%>
<%
// Récupération du service (bean session)
	IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
%>
<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
		<%@include file="header.jsp" %>
  		<div id="content">
		
		<%
		if(utilisateur == null) {
			%>
			<p class="erreur">Vous devez être connecter !</p>
			<%
			
		}
		else if(utilisateur instanceof Candidature) {
			%>
			<p class="erreur">Vous devez être connecter en tant qu'utiisateur</p>
			<%
		}
		else if(utilisateur instanceof Entreprise) {
			Entreprise e = (Entreprise) utilisateur;
			
			String nom = request.getParameter("nom");
			String desc = request.getParameter("descriptif");
			String add = request.getParameter("adresse_postale");
		
		if(nom == null) {
			out.println("Erreur : Le nom ne doit pas être nul !");
		}
		else {
			try {
				
			
				Entreprise entreprise = new Entreprise();
				entreprise.setNom(nom);
				entreprise.setAdressePostale(add);
				entreprise.setDescriptif(desc);
				entreprise.setId(e.getId());
				
				Entreprise nouvelleEntreprise = serviceEntreprise.modiferEntreprise(entreprise);
				
				session.setAttribute("utilisateur", nouvelleEntreprise);
				%>
					<h2>Entreprise mise à jour</h2>
					
					<table id="affichage">
		        		<tr>
		          			<th style="width: 170px;">Identifiant :</th>
		         				<td>
		         					<% out.print("ENT_"+nouvelleEntreprise.getId()); %>
		         				</td>		         
		        		</tr>
				        <tr>
				          <th>Nom :</th>
				          <td>
				            <%=nouvelleEntreprise.getNom()%>
				          </td>
				        </tr>
				        <tr>
				          <th>Descriptif :</th>
				          <td>
				            <%=Utils.text2HTML(nouvelleEntreprise.getDescriptif())%>
				          </td>
				        </tr>
				        <tr>
				          <th>Adresse postale (ville) :</th>
				          <td>
				            <%=nouvelleEntreprise.getAdressePostale()%>
				          </td>
				        </tr>
		      		</table>
		<%
			}
			catch(Exception exc) {
				exc.printStackTrace();
			}
		}
		}
		%>
		</div>

  </body>
  
</html>
