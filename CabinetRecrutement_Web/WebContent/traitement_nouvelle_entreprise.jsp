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
    <title>Cabinet de recrutement : Nouvelle entreprise référencée</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
		
		
		<%
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
				
				List<Entreprise> entreprises = serviceEntreprise.listeDesEntreprises();
				
				boolean find = false;
				for(Entreprise e : entreprises) {
					if(e.getNom().equalsIgnoreCase(entreprise.getNom())) {
						find = true;
					}
				}
				
				if(find) {
					out.println("Erreur : L'entreprise " + entreprise.getNom() + " existe déjà ! <br/>");
				}
				else {
					Entreprise nouvelleEntreprise = serviceEntreprise.ajoutEntreprise(entreprise);
				%>
					<h2>Nouvelle entreprise référencée :</h2>
					
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
				            <%=nouvelleEntreprise.getDescriptif()%>
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
			}
			catch(Exception e) {
				out.println("Erreur : ");
				e.printStackTrace();
			}
		}
		
		%>
		
		<a href="index.jsp">Retour au menu</a>
		

  </body>
  
</html>
