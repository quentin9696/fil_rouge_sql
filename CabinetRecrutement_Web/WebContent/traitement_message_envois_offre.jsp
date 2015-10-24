<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreEmploi"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDemploi"%>
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
	IServiceMessageOffreEmploi serviceMessageOffre = (IServiceMessageOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageOffreEmploi");
	//IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
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
								
								String message = request.getParameter("message");
								if(message == null) {
									%>
									<p class="erreur">Erreur : Vous devez taper du texte dans le message !</p>
									<%
								}
								else {
									if(message.isEmpty()) {
										%>
										<p class="erreur">Erreur : Vous devez taper du texte dans le message !</p>
										<%
									}
									else {
										MessageOffreDemploi messageOffre = new MessageOffreDemploi();
										messageOffre.setCorpsMessage(message);
										messageOffre.setOffreEmploi(offre);
										messageOffre.setCandidature(c);
										messageOffre.setDateEmploi(new Timestamp(new Date().getTime()));
										
										try {
											MessageOffreDemploi messageOffreDemploi = serviceMessageOffre.ajouterMessage(messageOffre);
											%>
											<h2>Nouveau message enregistré :</h2>
											<table id="affichage">
											  <tr>
											    <th style="width: 170px;">Id :</th>
											    <td><%=messageOffreDemploi.getId()%></td>
											  </tr>
									      <tr>
									        <th>Candidature :</th>
									        <td><%=messageOffreDemploi.getCandidature().getNom()%> <%=messageOffreDemploi.getCandidature().getPrenom()%> (CAND_<%=messageOffreDemploi.getCandidature().getId()%>)</td>
									      </tr>
									      <tr>
									        <th>Offre emploi concernée :</th>
									        <td><%=messageOffreDemploi.getOffreEmploi().getTitre()%> (<%=messageOffreDemploi.getOffreEmploi().getEntreprise().getNom()%>)</td>
									      </tr>
									      <tr>
									        <th>Date d'envoi :</th>
									        <td><%=Utils.date2String(messageOffreDemploi.getDateEmploi())%></td>
									      </tr>
											  <tr>
											    <th>Corps du message :</th>
											    <td>
											      <%=Utils.text2HTML(messageOffreDemploi.getCorpsMessage())%>
											    </td>
											  </tr>
											</table>
											<%
										}
										catch(Exception e) {
											e.printStackTrace();
										}
									}
								}
								
								%>
								
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
