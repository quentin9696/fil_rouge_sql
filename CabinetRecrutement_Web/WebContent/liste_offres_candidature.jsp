<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                java.util.List"%>

<%
  // Récupération du service (bean session)
	 IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");

	
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : liste des entreprises référencées</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
  	<%@include file="header.jsp" %>
  		<div id="content">
  		
  		<%
  		if(utilisateur == null) {
  			%>
  			<p class="erreur">Erreur : vous devez être connecté !</p>
  			<%
  		}
  		else if(utilisateur instanceof Entreprise) {
  			%>
  			<p class="erreur">Erreur : Vous devez être connecté en tant que candidat !</p>
  			<%
  			
  		}
  		
  		else if(utilisateur instanceof Candidature) {
  			
  			Candidature c = (Candidature) utilisateur;
  			Set <SecteurActivite> listeSecteurActivite = c.getSecteurActivites();
  			
  			
  			List<OffreEmploi> listeTouteOffres = serviceOffre.getOffreEmplois();
  			int idNiveauQualificationCandidat = c.getNiveauQualification().getId();
  			
  			HashSet<OffreEmploi> listes = new HashSet<OffreEmploi>();
  			
  			//out.println("niveau : " + idNiveauQualificationCandidat);
  			for(SecteurActivite secteur : listeSecteurActivite){
  				int idSecteur = secteur.getId();
  				//out.println("secteur : " + idSecteur);
  				listes.addAll(serviceOffre.findBySecteurAndNiveauQualification(idSecteur, idNiveauQualificationCandidat));
  			}
  		// Appel de la fonctionnalité désirée auprès du service
  		
  		%>
			<h2>Liste des offres d'emploi référencées :</h2>
			<%
			 if(listes.size() < 1) {
			    	   %>
			    	   <p class="erreur">Il n'y a actuellement aucune offre correspondante</p>
			    	   <%
			       }
			       else {
			 %>
			<table id="affichage">
			  <tr>
			    <th>Numéro</th>
			    <th>Titre</th>
			    
			    <th>Entreprise</th>
			    <th>Niveau de qualification</th>
			    <th>Date de dépôt</th>
			    
			  </tr>
			  
			      
			       <%
			      
			    	   
			       	for(OffreEmploi offre : listes) {
			       		%> 
			       		<tr>
				       		<td><%=offre.getId()%></td>
				       		<td><a href="infos_offre_emplois.jsp?id=<%=offre.getId()%>"><%=offre.getTitre()%></a></td>
				       		<td><%=offre.getEntreprise().getNom()%></td>
				       		<td><%=offre.getNiveauQualification().getIntitule()%></td>
				       		<td><%=Utils.date2String(offre.getDateDepot())%></td>
			       		<tr>
			       	<%
			       	}
			       %> 
			</table>
			
			<%
			       }
  			}
			%>
			
		</div>

  </body>
  
</html>
