<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi"%>
<%@page import="com.sun.xml.ws.rx.rm.protocol.wsrm200502.OfferType"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauQualificationRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActiviteRemote"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                java.util.*,
                java.sql.Timestamp,
                java.util.regex.*,
                java.text.SimpleDateFormat"
%>
<%
// Récupération du service (bean session)
	IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
	IServiceNiveauQualificationRemote serviceNiveauQualif = (IServiceNiveauQualificationRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauQualification");
	IServiceSecteurActiviteRemote serviceSecteurActivite = (IServiceSecteurActiviteRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
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
  	  		<p class="erreur">Erreur : seule les entreprises peuvent ajouter des offres d'emplois.</p>
  	  		<%
  	  	}
  	  	else if(utilisateur instanceof Candidature) {
  	  		%>
  	  		<p class="erreur">Erreur : seule les entreprises peuvent ajouter des offres d'emplois.</p>
  	  		<%
  	  	}
  	  	else if(utilisateur instanceof Entreprise) {
  	  		
  	  		String titre = request.getParameter("titre");
  	  		String desc = request.getParameter("desc");
  	  		String profil = request.getParameter("profil");
  	  		
  	  		if(titre == null && titre.isEmpty()) {
  	  			%>
  	  			<p class="erreur" > Erreur : Le titre est obligatoire !</p>
  	  			<%
  	  		}
  	  		else {
	  	  		if(request.getParameter("niveau") == null) {
			  		%>
	  	  			<p>Erreur : le niveau de qualification doit être spécifiée</p>
	  	  			<%
			  	}
			  	else if (request.getParameter("niveau").matches("^[0-9]*$")) {
			  		
			  		int id = new Integer(request.getParameter("niveau"));
			  		NiveauQualification niveau = serviceNiveauQualif.getNiveauQualificationById(id);
			  		
			  		if(niveau != null) {
			  			OffreEmploi offre = new OffreEmploi();
			  			
			  			offre.setTitre(titre);
			  			offre.setDescriptifMission(desc);
			  			offre.setProfilRecherche(profil);
			  			offre.setNiveauQualification(niveau);
			  			
			  			
			  		}
			  	}
			  	else {
			  		%>
			  		<p class="erreur" >N'essayer pas de pirater le site ! Votre IP (<%=request.getRemoteAddr()%>) a été envoyé à la police !</p>
			  		<%
			  	}
  	  		}
  		%>
  			
  		<%
  	  	}
  		%>
  		</div>

  </body>
  
</html>
