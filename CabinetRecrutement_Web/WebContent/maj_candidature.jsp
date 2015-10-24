<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActiviteRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauQualificationRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
<%@page import="java.util.List"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
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
			else if(utilisateur instanceof Entreprise) {
				%>
				<p class ="erreur">Seul les candidats peuvent accèder à cette page.
				<%
			}
			else if(utilisateur instanceof Candidature) {
			
				Candidature e  = (Candidature) utilisateur;
				
				IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
				IServiceNiveauQualificationRemote serviceNiveauQualif = (IServiceNiveauQualificationRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauQualification");
				IServiceSecteurActiviteRemote serviceSecteurActivite = (IServiceSecteurActiviteRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
		  	// Appel de la fonctionnalité désirée auprès du service
		    Candidature candidat = serviceCandidat.findById(e.getId());
		  	
		    %>
		    
		    <!-- Affichage des information récupérées -->
		    <form action="traitement_maj_candidature.jsp" method="post">
		      
			  	<table id="affichage">
			  		<tr>
			          <th style="width: 170px">ID :</th>
				        <td>
				          <input type="text" name="id" size="20" maxlength="50" value="<%=candidat.getId()%>" readonly="readonly">
				        </td>
				  	  </tr>
			        <tr>
			  		<tr>
			          <th style="width: 170px">Nom :</th>
				        <td>
				          <input type="text" name="nom" size="20" maxlength="50" value="<%=candidat.getNom()%>">
				        </td>
				  	  </tr>
			        <tr>
			          <th>Prénom :</th>
			          <td>
			            <input type="text" name="prenom" size="20" maxlength="50" value="<%=candidat.getPrenom()%>">
			          </td>
			        </tr>
			        <tr>
			          <th>Date de naissance<br/>(format jj/mm/aaaa) :</th>
			          <td>
			            <input type="text" name="date_naissance" size="10" maxlength="10" value="<%=Utils.date2String(candidat.getDateDepot())%>">
			          </td>
			        </tr>
			        <tr>
			          <th>Adresse postale (ville) :</th>
			          <td>
			            <input type="text" name="adresse_postale" size="20" maxlength="30" value="<%=candidat.getAdressePostale()%>">
			          </td>
			        </tr>
			        <tr>
			          <th>Adresse email :</th>
			          <td>
			            <input type="text" name="adresse_email" size="30" maxlength="100" value="<%=candidat.getAdresseEmail()%>">
			          </td>
			        </tr>
			        <tr>
			          <th>Curriculum vitæ :</th>
			          <td>
			            <textarea rows="7" cols="70" name="cv"><%=candidat.getCv()%></textarea>
			          </td>
			        </tr>
			        <tr>
			          <th>Niveau de qualification :</th>
			          <td>
			            <table id="tab_interne"><tr><td>
			              
			                <%
			                	List<NiveauQualification> listeNiveauQualif = serviceNiveauQualif.getNiveauQualif();
				            	
			                	for(NiveauQualification niveau : listeNiveauQualif) {
			                		
			                		int idCheck = candidat.getNiveauQualification().getId();
			                		
			                		if(niveau.getId() == idCheck) {
			                			out.println("<input type=\"radio\" name=\"niveau\" value=\""+ niveau.getId() + "\" checked=\"checked\" \">" + niveau.getIntitule() + "<br/>");
			                		}
			                		else {
			                			out.println("<input type=\"radio\" name=\"niveau\" value=\""+ niveau.getId() + "\">" + niveau.getIntitule() + "<br/>");	
			                		}
			                		
			                	}
			                %>	  
			                
							</td></tr></table>
			          </td>
			        </tr>
			        <tr>
			          <th>Secteur(s) d'activité :</th>
			          <td>
			                   	<%
			                	// FAIRE ICI + TRAITEMENT !! 
				                	List<SecteurActivite> listeSecteurActivite = serviceSecteurActivite.getSecteurActivite();
				                	for(SecteurActivite secteur : listeSecteurActivite) {
				                		boolean find = false;
				                		int idSecteur = secteur.getId();
				                		for(SecteurActivite secteurCandidature : candidat.getSecteurActivites()) {
				                			int idSecteurCandidature = secteurCandidature.getId();
				                			if(idSecteur == idSecteurCandidature) {
				                				find = true;
				                			}
				                		}
				                		
				                		if(find) {
				                			out.println("<input type=\"checkbox\" name=\"secteur\" value=\""+ secteur.getId()  + "\" checked=\"checked\" >" + secteur.getIntitule() + "<br/>");
				                		}
				                		else {
				                			out.println("<input type=\"checkbox\" name=\"secteur\" value=\""+ secteur.getId()  + "\">" + secteur.getIntitule() + "<br/>");	
				                		}
				                		
				                	}
			                	%>
			            </table>
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

