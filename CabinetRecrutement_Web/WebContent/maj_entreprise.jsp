<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

  		<%@include file="header.jsp" %>
  		<div id="content">
  		
		<%
			if(utilisateur == null) {
				%>
				<p class="erreur">Vous n'êtes pas connecté !</p>
				<%	
			}
			else if(utilisateur instanceof Candidature) {
				%>
				<p class ="erreur">Seul les entreprises peuvent accèder à cette page.
				<%
			}
			else if(utilisateur instanceof Entreprise) {
			
				Entreprise e  = (Entreprise) utilisateur;
				
			IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
		  	// Appel de la fonctionnalité désirée auprès du service
		    Entreprise entreprise = serviceEntreprise.getEntreprise(e.getId());
		  	
		    %>
		    
		    <!-- Affichage des information récupérées -->
		    <form action="traitement_maj_entreprise.jsp" method="post">
		      
			  	<table id="affichage">
			  		<tr>
		          <th style="width: 170px;">ID :</th>
			        <td>
			          <input type="text" name="id" size="20" maxlength="50" value="<%=entreprise.getId()%>" disabled="disabled">
			        </td>
			  	  </tr>
			  	  <tr>
		          <th style="width: 170px;">Nom :</th>
			        <td>
			          <input type="text" name="nom" size="20" maxlength="50" value="<%=entreprise.getNom()%>">
			        </td>
			  	  </tr>
			      <tr>
		          <th>Descriptif :</th>
			        <td>
			          <textarea rows="7" cols="70" name="descriptif"><%=entreprise.getDescriptif()%></textarea>
			        </td>
			      </tr>
			      <tr>
		          <th>Adresse postale (ville) :</th>
			        <td>
			          <input type="text" name="adresse_postale" size="20" maxlength="30" value="<%=entreprise.getAdressePostale()%>">
			        </td>
			      </tr>
			  	</table>
				  <p>
				    <input type="submit" value="Mettre à jour"/>
				  </p>
				</form>
		<%
		  	}
		%>
		</div>
  </body>
  
</html>

