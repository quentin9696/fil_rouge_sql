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
			  		if(listeOffre.size() < 1) {
			  			%>
			  			<p class="erreur">Aucune offres d'emplois n'a �t� d�pos�e !</p>
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
						           <a href="efface_offre.jsp?id=<%=offre.getId()%>" onclick="return confirm('�tes-vous s�r de vouloir supprimer cette offre d\'emploi ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');"><img src="images/effacement.png" border="0" alt="Effacement de l'offre d'emploi" /></a><br/>
						         </td>
						         
						       <td><%=offre.getEntreprise().getNom()%></td>
						       <td><%=offre.getNiveauQualification().getIntitule()%></td>
						       <td><%=Utils.date2String(offre.getDateDepot())%></td>
							   <td>
							   	<%
							   	Set<SecteurActivite> secteurs = offre.getSecteurActivites();
							   	
							   	int idNivQualif = offre.getNiveauQualification().getId();
							   	
							   	LinkedList<Candidature> listePotentielle = new LinkedList<Candidature>();
							   	
							   	for(SecteurActivite s : secteurs) {
							   		
							   		int idSecteur = s.getId();
							   		
							   		listePotentielle.addAll(serviceCandidat.getCandidatAssocier(idSecteur, idNivQualif));
							   		
							   		
							   	}
							   	
								
					  			
					  			
							   	
							   	if(listePotentielle.size()<1) {
							   		%>-<%
							   	}
							   	else {
							   		LinkedList <Integer> idCand = new LinkedList<Integer>();
						  			
						  			int j=0;
						  			
						  			for(Candidature candidatCourrant : listePotentielle) {
						  					
						  				int idCandCourrante = candidatCourrant.getId();
						  				
						  				boolean find = false;
						  				
						  				if(idCand.size() < 1) {
						  					idCand.add(idCandCourrante);
						  				}
						  				else {
						  					for(int i : idCand) {
						  	  					if(i == idCandCourrante) {
						  	  						find = true;
						  	  					}
						  	  				}
						  	  				
						  	  				if(!find) {
						  	  					idCand.add(idCandCourrante);
						  	  				}
						  				}
						  				j++;
						  			}
						  			
						  			LinkedList<Candidature> listeCandidats = new LinkedList<Candidature>();
						  			
						  			for(int i : idCand) {
						  				listeCandidats.add(serviceCandidat.findById(i));
						  				
						  			}
							   		%>
							   		<ul>
							   		<%
							   		for(Candidature c : listeCandidats) {
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
				      
								
			  		<%
						  }
						  %>
						  </table>
						  <%
			  		}
			  	}
			 }
			%>
  </body>
  
</html>
