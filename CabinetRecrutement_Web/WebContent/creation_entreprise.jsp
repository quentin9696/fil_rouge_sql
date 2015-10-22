<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<html>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cabinet de recrutement</title>
    <link rel="stylesheet" href="styles.css" type="text/css" />
  </head>

  <body>
  
  		<%@include file="header.jsp" %>
  		
  		<div id="content">
		<h2>Référencer une nouvelle entreprise</h2>
    
		    <form action="traitement_entreprise.jsp" method="post">
		      
			  	<table id="affichage">
			  	  <tr>
		          <th style="width: 170px;">Nom :</th>
			        <td>
			          <input type="text" name="nom" size="20" maxlength="50">
			        </td>
			  	  </tr>
			      <tr>
		          <th>Descriptif :</th>
			        <td>
			          <textarea rows="7" cols="70" name="descriptif"></textarea>
			        </td>
			      </tr>
			      <tr>
		          <th>Adresse postale (ville) :</th>
			        <td>
			          <input type="text" name="adresse_postale" size="20" maxlength="30">
			        </td>
			      </tr>
			  	</table>
				  <p>
				    <input type="submit" value="Enregistrer"/>
				  </p>
				</form>
		</div>
  </body>
  
</html>
