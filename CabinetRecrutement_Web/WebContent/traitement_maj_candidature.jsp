<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceSecteurActiviteRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceNiveauQualificationRemote"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"
%>
<%
// Récupération du service (bean session)
IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
IServiceNiveauQualificationRemote serviceNiveauQualif = (IServiceNiveauQualificationRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceNiveauQualification");
IServiceSecteurActiviteRemote serviceSecteurActivite = (IServiceSecteurActiviteRemote) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteurActivite");
%>

  
		<%@include file="header.jsp" %>
  		<div id="content">
		<%
		
		if(utilisateur == null) {
			%>
			<p class="erreur"> Vous devez être connecté.</p>
			<%
		}
		else if(utilisateur instanceof Entreprise) {
			%>
			<p class="erreur">Erreur : Vous devez être un candidat pour modifier votre profil</p>
			<%
		}
		else if(utilisateur instanceof Candidature) {
			
		Candidature c = (Candidature) utilisateur;
		
		int id = new Integer(request.getParameter("id"));
		
		
		if(id != c.getId()) {
			%>
			<p class="erreur">Erreur : vous ne pouvez pas modifier un autre candidat !</p>
			<%
		}
		else {
			
			String nom = request.getParameter("nom");
			String prenom = request.getParameter("prenom");
			String dateNaissance = request.getParameter("date_naissance");
			String adresse = request.getParameter("adresse_postale");
			String mail = request.getParameter("adresse_mail");
			String cv = request.getParameter("cv");
		
			if(nom != null && prenom != null) {
				if(nom.matches("^.{1,50}$") && prenom.matches("^.{1,50}$")) {
					if(dateNaissance != null && dateNaissance.matches("[0-9]{2}/[0-9]{2}/[0-9]{4}")) {
					    
					    Date parsedDate = Utils.string2Date(dateNaissance);
					    Timestamp dateNaissanceTimestamp = new Timestamp(parsedDate.getTime());
					    
					    if(request.getParameter("niveau") == null) {
					  		out.println("<p class=\"erreur\">Le niveau de qualification doit être spécifiée </p>");
					  	}
					  	else if (request.getParameter("niveau").matches("^[0-9]+$")) {
					  		
					  		int idNiveau = new Integer(request.getParameter("niveau"));
					  		
					  		NiveauQualification niveau = serviceNiveauQualif.getNiveauQualificationById(idNiveau);
					  		
					  		if(niveau != null) {
					  			
					  			Candidature candidat = c;
					  			
							    candidat.setNom(nom);
							    candidat.setPrenom(prenom);
							    candidat.setDateNaissance(dateNaissanceTimestamp);
							    candidat.setAdresseEmail(mail);
							    candidat.setAdressePostale(adresse);
							    candidat.setCv(cv);
							    candidat.setNiveauQualification(niveau);
							    
							    //Get les secteur d'activites
							    candidat = serviceCandidat.updateCandidat(candidat);
							    
							    Set<SecteurActivite> listeSecteurActivite = candidat.getSecteurActivites();
					  			
							    listeSecteurActivite.clear();
							    
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
					  						out.println("N'essayez pas de pirater le site. Votre adresse ip ("+ request.getRemoteAddr() 
					  					  			+ "vient d'être envoyée à la police ! <br/>");
					  						System.exit(-1);	
					  					}
					  				}
					  				candidat.setSecteurActivites(listeSecteurActivite);
					  				
					  				c = serviceCandidat.updateCandidat(candidat);
					  				
					  				session.setAttribute("utilisateur",c);
					  				%>
					  				
					  				<h2>Nouvelle candidature référencée :</h2>
	      
	      						<table id="affichage">
	        					
	        					<tr>
	          						<th style="width: 170px;">Identifiant :</th>
							        <td>
							        	CAND_<%=c.getId()%>
							        </td>
							   	</tr>
							    <tr>
							          <th>Nom :</th>
							          <td>
							            <%=c.getNom()%>
							          </td>
						        </tr>
						        <tr>
							          <th>Prénom :</th>
							          <td>
							            <%=c.getPrenom()%>
							          </td>
						        </tr>
						        <tr>
							          <th>Adresse postale (ville) :</th>
							          <td>
							          	<%=c.getAdressePostale()%>
							          </td>
						        </tr>
						        <tr>
							          <th>Adresse email :</th>
							          <td>
							            <a href="mailto:<%=c.getAdresseEmail()%>"><%=c.getAdresseEmail()%></a>
							          </td>
						        </tr>
						        <tr>
							          <th>Curriculum vitæ :</th>
							          <td>
							        	<%=Utils.text2HTML(c.getCv())%>    
							          </td>
						        </tr>
						        <tr>
							          <th>Niveau de qualification :</th>
							          <td>
							            <%=c.getNiveauQualification().getIntitule()%>
							          </td>
						        </tr>
						        <tr>
							          <th>Secteur(s) d'activité :</th>
							          <td>
							            <ul>
								            <%
								            	for(SecteurActivite s : c.getSecteurActivites()) { 
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
							            <%=c.getDateDepot().toString()%>
							          </td>
								</tr>
	      					</table>
					  				
					  				<%
					  			} 
					  			else { 
					  			    out.println("Vous devez cocher au moins 1 secteur d'activité !");
					  			}
					  		}
						    else {
					  			out.println("L'offre d'emploi " + id + " n'a pas été trouvée ! <br/>");
					  		}
					  		
					  		
					  	}
					  	else {
					  		out.println("N'essayez pas de pirater le site. Votre adresse ip ("+ request.getRemoteAddr() 
					  			+ "vient d'être envoyée à la police ! <br/>");
					  	}				    
					}
					else {
						out.println("La date n'est pas dans un format valide (jj/mm/aaaa)");
					}
				}
				else {
					out.println("Le nom ou le prenom n'est pas valide (moins de 50 car.)!");
				}
			}
			else {
				out.println("Le nom et le prenom doivent être renseingé");
			}
			}
		}
		%>
		</div>

  </body>
  
</html>
