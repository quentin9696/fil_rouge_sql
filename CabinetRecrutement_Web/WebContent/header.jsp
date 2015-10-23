<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
                
<%
  		Object utilisateur = session.getAttribute("utilisateur");
	%>
  	<table style="border-collapse: collapse; width: 100%; border: 1px;">
	    <tr>
        <td  style="vertical-align: middle; font-size: 18px; color: #564b47; font-weight: bolder;">Cabinet de recrutement</td>
        <td align="right"><img src="images/loupe.png" alt="" width="70" border="0" /></td>
	    </tr>
	  </table>
		<h1>
		<%
		if(utilisateur == null)
	  	  {
	  	    %>
	  	   	Non connecté
	  	    <%
	  	  }
	  	  else
	  	  {
	  	  	if(utilisateur instanceof Entreprise)
	  	  	{
	  	  		Entreprise e = (Entreprise) utilisateur;
	  	  		%>
	  	  	Entreprise : <i><%=e.getNom()%></i>
	  	  		<%
	  	  	}
	  	  	else if(utilisateur instanceof Candidature) {
	  	  		Candidature c = (Candidature) utilisateur;
		  		%>
		  	Candidat : <i><%=c.getNom().toUpperCase() + " " + c.getPrenom()%></i>
		  		<%
	  	  	}
	  	  }
		%>
</h1>
	<div id="menu">
    <h2>Menu administration</h2>
		<ul>
		  <li>
		    Gestion des entreprises
		    <ul>
				<li class="menu"><a href="creation_entreprise.jsp">Nouvelle entreprise</a></li>
			    <li class="menu"><a href="liste_entreprises.jsp">Liste des entreprises</a></li>
			    <li class="menu"><a href="liste_offres_emplois.jsp">Liste de toutes les offres d'emploi</a></li>
		    </ul>
		  </li>
		  <li>
		    Gestion des candidatures
		    <ul>
		      <li class="menu"><a href="creation_candidature.jsp">Nouvelle candidature</a></li>
		      <li class="menu"><a href="liste_candidature.jsp">Liste des candidatures</a></li>
		    </ul>
		  </li>
		</ul>
	<%
	if(utilisateur != null)
	  {
		if(utilisateur instanceof Entreprise)
	  	{
			Entreprise e = (Entreprise) utilisateur;
	%>
    <hr/>
	    <h2>Menu entreprise</h2>
	      	<ul>
	          <li class="menu"><a href="maj_entreprise.jsp">Mettre à jour les informations de l'entreprise</a></li>
	          <li class="menu"><a href="creation_offre_emploi.jsp">Nouvelle offre d'emploi</a></li>
		      <li class="menu"><a href="liste_offres_entreprise.jsp">Liste de mes offres d'emploi</a> (<%=((e.getOffreEmplois() != null) ? e.getOffreEmplois().size() : "0")%>)</li>
			</ul>
        	<ul>
          		<li style="list-style-image: url(images/effacement.png)" class="menu"><a href="effacer_ent.jsp" onclick="return confirm('Êtes-vous sûr de vouloir retirer votre entreprise et toutes vos offres d\'emploi?\n\nAttention, cette opération n\'est pas réversible !\n\n');">Retirer mon entreprise et toutes mes offres d'emploi</a></li>
        	</ul>
    	<%
	  		}
    	}
    	%>
    <hr/>
    
    <%
    if(utilisateur != null) {
    	if(utilisateur instanceof Candidature) {
    		Candidature c = (Candidature) utilisateur;
    %>
    	<h2>Menu candidature</h2>
        <ul>
          <li class="menu"><a href="maj_candidature.jsp">Mettre à jour les informations de la candidature</a></li>
	        <li class="menu"><a href="offres_condidature.jsp">Lister les offres d'emploi qui correspondent à ma candidature</a> (<%=((1==1)?"0":"0")%>)</li>
        </ul>
        <ul>
	        <li style="list-style-image: url(images/effacement.png)" class="menu"><a href="effacer_cand.jsp" onclick="return confirm('Êtes-vous sûr de vouloir retirer votre candidature ?\n\nAttention, cette opération n\'est pas réversible !\n\n');">Retirer ma candidature</a></li>
        </ul>
        
    	<hr/>
    <%
    	}
    }
    %>
	    <ul>
        	<li class="menu"><a href="<%=((utilisateur == null)?"connexion":"deconnexion") %>.jsp"><%=((utilisateur == null)?"Connexion":"Déconnexion") %></a></li>
      	</ul> 
	<hr/>
</div>
