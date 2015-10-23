<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedList"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
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
    <title>Cabinet de recrutement : Information sur une offre d'emploi référencée</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  <%@include file="header.jsp" %>
  		<div id="content">
  <%
  	if(request.getParameter("id").isEmpty()) {
  		%>
  		<p class="erreur" >L'offre d'emploi doit être spécifiée</p>
  		<%
  	}
  	else if (request.getParameter("id").matches("^[0-9]*$")) {
  		
  		int id = new Integer(request.getParameter("id"));
  		OffreEmploi offre = serviceOffre.getOffreEmploisById(id);
  		if(offre == null) {
  			%>
  			<p class="erreur" >L'offre n'a pa été trouvée. </p>
  			<%
  		}
  		else {
  %>
		<h2>Infos offre d'emploi :</h2>
    
    	<% 
    		if(utilisateur != null) {
    			if(utilisateur instanceof Candidature) {
    				
    				Candidature c = (Candidature) utilisateur;
    				
    				Set<SecteurActivite> secteursActivite = offre.getSecteurActivites();
    				
    				int idNiveauQualifCand = c.getNiveauQualification().getId();
    				int idNiveauQualifOffre = offre.getNiveauQualification().getId();
    				
    				if(idNiveauQualifCand == idNiveauQualifOffre) {
    					
    					boolean find = false;
    					
    					for(SecteurActivite s : offre.getSecteurActivites()) {
    						int idS = s.getId();
    						for(SecteurActivite sCand : c.getSecteurActivites()) {
    							int idSCand = sCand.getId();
    							
    							if(idSCand == idS) {
    								find = true;
    							}
    						}
    					}
    					
    					if(find) {
    						%>
    						<p class="erreur">Intéressé par cette offre d'emploi ? <a href="">Demande d'entretien</a></p>
    						<%
    					}
    				}
    				
    			}
    			else if(utilisateur instanceof Entreprise) {
    				 Entreprise e = (Entreprise) utilisateur;
						
    				 int idEnt = e.getId();
    				 int idEntOffre =  offre.getEntreprise().getId();
    				 
    				 if(idEnt == idEntOffre) {
    					
	    				 IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");

	    				 int idNiveauQualifOffre = offre.getNiveauQualification().getId();
	    				 Set<SecteurActivite> secteursActivite = offre.getSecteurActivites();
	    				 
	    				 LinkedList<Candidature> listePotentielle = new LinkedList<Candidature>();
	    				 
	    				 for(SecteurActivite s : secteursActivite) {
	    					 
	    					 int idSecteurActiviteCourrant = s.getId();
	    					 listePotentielle.addAll(serviceCandidat.getCandidatAssocier(idSecteurActiviteCourrant, idNiveauQualifOffre));
	    				 }
	    				 
	    				 if(listePotentielle.size() > 0) {
	    					 LinkedList<Integer> idCand = new LinkedList<Integer>();
	    					 
	    					 for(Candidature candidatureCourrante : listePotentielle) {
	    						 int idCandidatureCourrante = candidatureCourrante.getId();
	    						 
	    						 if(idCand.size() < 1) {
	    							 idCand.add(idCandidatureCourrante);
	    						 }
	    						 else {
	    							 boolean find = false;
	    							 
	    							 for(int i : idCand) {
	    								 if(i == idCandidatureCourrante) {
	    									 find = true;
	    								 }
	    							 }
	    							 
	    							 if(!find) {
	    								 idCand.add(idCandidatureCourrante);
	    							 }
	    						 }
	    					 }
	    					 
	    					 listePotentielle.clear();
	    					 
	    					 for(int i : idCand) {
	    						listePotentielle.add(serviceCandidat.findById(i));	 
	    					 }
	    					 
	    					 %>
	    					 <p class="erreur">Liste des candidatures potentiellement intéressées par l'offre : </p>
	    					 <ul>
	    					 	<%
	    					 		for(Candidature c : listePotentielle) {
	    					 			%>
	    					 			<li><%=c.getNom()%> <%=c.getPrenom()%> - <a href="">Envoyer une proposition de rendez-vous</a></li>
	    					 			<%
	    					 		}
	    					 	%>
	    					 </ul>
	    					 <%
	    				 }
	    			}
    			}
    		}
    	%>
    
      <table id="affichage">
        <tr>
          <th style="width: 170px;">Numéro de l'offre :</th>
          <td>
            <%=offre.getId()%>
          </td>
        </tr>
        <tr>
          <th>Titre :</th>
          <td>
            <%=offre.getTitre()%>
          </td>
        </tr>
        <tr>
          <th>Entreprise :</th>
          <td>
            <u><%=offre.getEntreprise().getNom()%></u><br/> 
            <%=Utils.text2HTML(offre.getEntreprise().getDescriptif())%>
          </td>
        </tr>
        <tr>
          <th>Descriptif de la mission :</th>
          <td>
            <%=offre.getDescriptifMission()%>
          </td>
        </tr>
        <tr>
          <th>Profil recherché :</th>
          <td>
            <%=offre.getProfilRecherche()%>
          </td>
        </tr>
        <tr>
          <th>Lieu de la mission :</th>
          <td>
            <%=offre.getEntreprise().getAdressePostale()%>
          </td>
        </tr>
        <tr>
          <th>Niveau de qualification :</th>
          <td>
            <%=offre.getNiveauQualification().getIntitule()%>
          </td>
        </tr>
        <tr>
          <th>Secteur(s) d'activité :</th>
          <td>
            <ul>
             <% 
				Set<SecteurActivite> liste = offre.getSecteurActivites();
             
             	for(SecteurActivite secteur : liste){
            	 	out.println("<li>"+ secteur.getIntitule() +"</li>");
            	}
           	%>  
            </ul>
          </td>
        </tr>
        <tr>
          <th>Date de dépôt :</th>
          <td>
          	<%=Utils.date2String(offre.getDateDepot())%>
          </td>
        </tr>
      </table>
	<%
  		}
  	}
  	else {
  		%>
  		<p class="erreur">N'essayez pas de pirater le site. Votre adresse ip (<%=request.getRemoteAddr()%>) vient d'être envoyée à la police !</p>
  		<%
  	}
	%>
	
	</div>
  </body>
  
</html>
