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
  	  		
  	  		Entreprise e = (Entreprise) utilisateur;
  	  		
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
			  			
			  			try {
				  			OffreEmploi offre = new OffreEmploi();
				  			
				  			offre.setEntreprise(e);
				  			offre.setTitre(titre);
				  			offre.setDescriptifMission(desc);
				  			offre.setProfilRecherche(profil);
				  			offre.setNiveauQualification(niveau);
				  			offre.setDateDepot(new Timestamp(new Date().getTime()));
				  			
				  			offre = serviceOffre.ajouterOffre(offre);
				  			
				  			Set<SecteurActivite> listeSecteurActivite = offre.getSecteurActivites();
				  			
						    
						    //Recupere la checkBox !
				  			String[] checkboxes = request.getParameterValues("secteur");
				  			
				  			if (checkboxes != null && checkboxes.length > 0) {
				  				
				  				for(int i = 0; i<checkboxes.length; i++) {
				  					
				  					int secteurID = new Integer(checkboxes[i]);
				  					
				  					SecteurActivite s = serviceSecteurActivite.getSecteurActiviteById(secteurID);
				  					
				  					if( s != null) {
				  						listeSecteurActivite.add(s);
				  					}
				  					else  {
				  						out.println("<p class=\"erreur\">N'essayez pas de pirater le site. Votre adresse ip ("+ request.getRemoteAddr() 
				  					  			+ "vient d'être envoyée à la police !</p>");
				  						System.exit(-1);	
				  					}
				  				}
				  					
				  				offre.setSecteurActivites(listeSecteurActivite);
				  				serviceOffre.updateOffre(offre);
				  			%>	
			  			<h2>Nouvelle offre d'emploi référencée :</h2>
			  		      
			  		      <table id="affichage">
			  		        <tr>
			  		          <th style="width: 170px">Numéro de l'offre :</th>
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
			  		          <th>Descriptif de la mission :</th>
			  		          <td>
			  		            <%=Utils.text2HTML(offre.getDescriptifMission())%>
			  		          </td>
			  		        </tr>
			  		        <tr>
			  		          <th>Profil recherché :</th>
			  		          <td>
			  		            <%=offre.getProfilRecherche()%>
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
									for(SecteurActivite s : offre.getSecteurActivites()) {
										%>
										<li><%=s.getIntitule()%></li>
										<%
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
				  			else {
				  				%>
				  				<p class="erreur" >Erreur : vous devez selectionner au moins 1 secteur d'activité.</p>
				  				<%
				  			}
				  			
			  		}
		  			catch(Exception exc) {
		  				exc.printStackTrace();
		  			}
			  	}
			  	else {
			  		%>
			  		<p class="erreur" >N'essayer pas de pirater le site ! Votre IP (<%=request.getRemoteAddr()%>) a été envoyé à la police !</p>
			  		<%
			  	}
  	  		}
		  	else {
		  		%>
		  		<p class="erreur" >N'essayer pas de pirater le site ! Votre IP (<%=request.getRemoteAddr()%>) a été envoyé à la police !</p>
		  		<%
		  	}
  		}
  	  	}
  		%>
  		</div>

  </body>
  
</html>
