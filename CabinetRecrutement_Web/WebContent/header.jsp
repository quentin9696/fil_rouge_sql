<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>
                
<%
  		Object utilisateur = session.getAttribute("utilisateur");
	%>
	<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
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
	  	   	Non connect�
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
	          <li class="menu"><a href="maj_entreprise.jsp">Mettre � jour les informations de l'entreprise</a></li>
	          <li class="menu"><a href="creation_offre_emploi.jsp">Nouvelle offre d'emploi</a></li>
		      <li class="menu"><a href="liste_offres_entreprise.jsp">Liste de mes offres d'emploi</a></li>
			</ul>
        	<ul>
          		<li style="list-style-image: url(images/effacement.png)" class="menu"><a href="effacer_ent.jsp" onclick="return confirm('�tes-vous s�r de vouloir retirer votre entreprise et toutes vos offres d\'emploi?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');">Retirer mon entreprise et toutes mes offres d'emploi</a></li>
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
          <li class="menu"><a href="maj_candidature.jsp">Mettre � jour les informations de la candidature</a></li>
	        <li class="menu"><a href="liste_offres_candidature.jsp">Lister les offres d'emploi qui correspondent � ma candidature</a></li>
        </ul>
        <ul>
	        <li style="list-style-image: url(images/effacement.png)" class="menu"><a href="effacer_cand.jsp" onclick="return confirm('�tes-vous s�r de vouloir retirer votre candidature ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');">Retirer ma candidature</a></li>
        </ul>
        
    	<hr/>
    <%
    	}
    }
    
    if(utilisateur != null) {
    	if(utilisateur instanceof Candidature) {
    		%>
    		<h2>Menu messages</h2>
		      <ul>
		        <li class="menu"><a href="message_liste_cand.jsp">Messages re�us</a></li>
		        <li class="menu"><a href="message_liste_offre.jsp">Messages envoy�s</a></li>
		      </ul>
        
     		<hr/>
    		<%
    	}
    	else if(utilisateur instanceof Entreprise) {
    		%>
    		<h2>Menu messages</h2>
		      <ul>
		        <li class="menu"><a href="message_liste_offre.jsp">Messages re�us</a></li>
		        <li class="menu"><a href="message_liste_cand.jsp">Messages envoy�s</a></li>
		      </ul>
        
     		<hr/>
    		<%
    	}
    }
    %>
	    <ul>
        	<li class="menu"><a href="<%=((utilisateur == null)?"connexion":"deconnexion") %>.jsp"><%=((utilisateur == null)?"Connexion":"D�connexion") %></a></li>
      	</ul> 
	<hr/>
</div>
