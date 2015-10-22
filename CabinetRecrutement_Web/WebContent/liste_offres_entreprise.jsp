<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                java.util.*"%>

<%
  // R�cup�ration du service (bean session)
	 IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
	 IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement : liste des entreprises r�f�renc�es</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
  	<%@include file="header.jsp" %>
  	<div id="content">
	  <%
		  if(utilisateur == null)
		  {
		    %>
		    <p class="erreur">Erreur : vous devez �tre connect�.</p>
		    <%
		  }
			 else
			 {
			  	if(utilisateur instanceof Candidature)
			  	{
			      %>
			      <p class="erreur" >Erreur : vous devez �tre connect� avec votre compte entreprise.</p>
			      <%
			  	}
			  	else if(utilisateur instanceof Entreprise) {
			  		Entreprise e = (Entreprise) utilisateur;
			  		
			  		List<OffreEmploi> listeOffre = serviceOffre.getOffreEmploisByEntreprise(e.getId());
			  		if(listeOffre == null) {
			  			%>
			  			<p classe="erreur">Aucune offres d'emplois n'a �t� d�pos�e !</p>
			  			<%
			  			
			  		}
			  		else {
			  		%>
			  		
				  		<h2>Liste des offres d'emploi r�f�renc�es :</h2>
						
						<table id="affichage">
						  <tr>
						    <th>Num�ro</th>
						    <th>Titre</th>
						    
						      <th>&nbsp;</th>
						      <th>&nbsp;</th>
						      
						    <th>Entreprise</th>
						    <th>Niveau de qualification</th>
						    <th>Date de d�p�t</th>
						    
						    	<th style="text-align: left;">Candidatures potentielles</th>
						    	
						  </tr>
						  <%
						  	for(OffreEmploi offre : listeOffre) {
						  		
						  %>
						      <tr>
						       <td><%=offre.getId()%></td>
						       <td><a href="infos_offre_emplois.jsp?id=<%=offre.getId()%>"><%=offre.getTitre()%></a></td>
						       
						         <td>
						           <a href="maj_offre.jsp?id=<%=offre.getId()%>"><img src="images/mise_a_jour.png" border="0" alt="Mise � jour de l'offre d'emploi"/></a><br/>
						         </td>
						         <td>
						           <a href="efface_offre?id=<%=offre.getId()%>" onclick="return confirm('�tes-vous s�r de vouloir supprimer cette offre d\'emploi ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');"><img src="images/effacement.png" border="0" alt="Effacement de l'offre d'emploi" /></a><br/>
						         </td>
						         
						       <td><%=offre.getEntreprise().getNom()%></td>
						       <td><%=offre.getNiveauQualification().getIntitule()%></td>
						       <td><%=Utils.date2String(offre.getDateDepot())%></td>
							   <td>
							   	<%
							   	Set<SecteurActivite> secteurs = offre.getSecteurActivites();
							   	HashSet<Candidature> listePotentielle = new HashSet();
							   	
							   	for(SecteurActivite s : secteurs) {
							   		/*List<Candidature> listeCandidature = serviceCandidat.getCandidatAssocier(s.getId(), offre.getNiveauQualification().getId());
							   		
							   		if(listeCandidature != null && listeCandidature.size() > 0) {
							   			for(Candidature cand : listeCandidature) {
								   			listePotentielle.add(cand);	
								   		}	
							   		}*/

							   	}
							   	
							   	if(listePotentielle == null) {
							   		%>-<%
							   	}
							   	else {
							   		%>
							   		<ul>
							   		<%
							   		for(Candidature c : listePotentielle) {
							   			%>
							   			<li><a href="infos_candidature.jsp?id=<%=c.getId()%>"><%=c.getNom()%> <%=c.getPrenom()%></a></li>
							   			<%
							   		}
							   		%>
							   		</ul>
							   		<%
							   	}
							   	%>     
							   </td>
							       
						      </tr>
				      
						</table>		
			  		<%
						  }
			  		}
			  	}
			 }
			%>
  </body>
  
</html>
