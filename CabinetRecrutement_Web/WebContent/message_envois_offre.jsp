<%@page import="java.util.Set"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi"%>
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
	IServiceOffreEmplois serviceOffre = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
	IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
%>

  <%@include file="header.jsp" %>
  	<div id="content">
  	<%
  		if(utilisateur == null) {
  			%>
  			<p class="erreur">Vous devez être connecté pour utiliser les messages !</p>
  			<%
  		}
  		else {
  			if(utilisateur instanceof Entreprise) {
  				%>
  				<p class="erreur">Vous devez être connecté en tant que candidat pour avoir accès à cette fonctionnalitée !</p>
  				<%
  			}
  			else if(utilisateur instanceof Candidature) {
				
  				Candidature c = (Candidature) utilisateur;
  				
		  		if(request.getParameter("id_offre").isEmpty() ) {
		  			%>
		  			<p class="erreur">vous devez spécifier une offre d'emploi</p>
		  			<%
		  		}
		  		else {
		  			if(request.getParameter("id_offre").matches("^[0-9]+$")) {
		  				int idOffre = new Integer(request.getParameter("id_offre"));
		  				//int idOffre = 1;
		  				OffreEmploi offre = serviceOffre.getOffreEmploisById(idOffre);
		  				
		  				if(offre == null) {
		  					%>
		  					<p class="erreur">Erreur : L'offre n'éxiste pas/plus !</p>
		  					<%
		  				}
		  				else {
		  					Set<SecteurActivite> listeSecteursActiviteOffre = offre.getSecteurActivites();
		  					Set<SecteurActivite> listeSecteursActiviteCandidature = c.getSecteurActivites();

		  					boolean find = false;
		  					
							for(SecteurActivite s : listeSecteursActiviteOffre) {
								int idSecteurOffre = s.getId();
								for(SecteurActivite sCand : listeSecteursActiviteCandidature) {
									int idSecteurCand = sCand.getId();
									
									if(idSecteurCand == idSecteurOffre) {
										find = true;
									}
								}
							}
							
							int idNiveauQualificationOffre = offre.getNiveauQualification().getId();
							int idNiveauQualificationCand = c.getNiveauQualification().getId();
							
							if(idNiveauQualificationCand != idNiveauQualificationOffre) {
								find = false;
							}
							
							if(!find) {
								%>
								<p class="erreur">Erreur : Cette offre ne correspond pas à vos critère</p>
								<%
							}
							else {
								%>
								<h2>Demande d'entretien</h2>
								<form action="traitement_message_envois_offre.jsp?id_offre=<%=offre.getId()%>" method="post">
								  	<table id="affichage">
								  	  <tr>
								  	  	<td>Offre : </td>
								  	  	<td><%=offre.getTitre()%></td>
								  	  </tr>
								  	  <tr>
								  	  	<td>Entreprise :</td>
								  	  	<td><%=offre.getEntreprise().getNom()%></td>
								  	  </tr>
								  	  <tr>
								  	  	<td>Message :</td>
								  	  	<td><textarea rows="7" cols="70" name="message"></textarea></td>
								  	  </tr>
								  	</table>
									  <p>
			    						<input type="submit" value="Envoyer"/>
			 						  </p>
		 						  </form>
								  
								<%
							}
		  				}
		  				
		  			}
		  			else {
		  				%>
		  				<p class="erreur">N'essayez pas pirater le site. Votre adresse (<%=request.getRemoteAddr()%>) a été envoyé à la police !</p>
		  				<%
		  			}
		  		}
  			}
  		}
  	%>
	</div>
  </body>
  
</html>
