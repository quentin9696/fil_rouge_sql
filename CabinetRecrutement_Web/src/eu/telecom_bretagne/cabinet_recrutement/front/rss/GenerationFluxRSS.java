package eu.telecom_bretagne.cabinet_recrutement.front.rss;

import java.io.Writer;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmplois;

/**
 * Classe permettant la gestion des flux RSS publiant la liste des offres
 * d'emploi et la liste des candidatures. La classe contient deux méthodes
 * statiques utilisables au sein d'un JSP :
 * <ul>
 * 		<li>{@code GenerationFluxRSS.offresEmploi (Writer writer, String urlBase)}</li>
 * 		<li>{@code GenerationFluxRSS.candidatures(Writer writer, String urlBase)}</li>
 * </ul>
 * @author Philippe TANGUY
 */
public class GenerationFluxRSS
{
	//-----------------------------------------------------------------------------
	/**
	 * Construction du flux RSS de la liste des offres d'emploi. Celles-ci sont obtenues
	 * par l'appel de la méthode {@code listeDesOffres()}, voir : {@link IServiceOffreEmploi}.
	 * @param writer  l'instance du {@link Writer} sur lequel sera écrit le flux RSS.
	 *                La méthode étant appelée au sein d'un JSP, celui-ci est l'instance
	 *                de l'objet prédéfini {@code out}, instance de {@link JspWriter}.
	 * @param urlBase l'URL de base (une chaîne de caractères) permettant la récupération
	 *                des éléments du flux.
	 * @throws JAXBException
	 * @throws ServicesLocatorException
	 */
	public static void offresEmploi(Writer writer, String urlBase) throws JAXBException, ServicesLocatorException
	{
		// Récupération du service de gestion des offres d'emploi à l'aide de
		// la classe ServiceLocator.
		// A éventuellement adapter à votre projet.
		IServiceOffreEmplois serviceOffreEmploi = (IServiceOffreEmplois) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmplois");
		
		// Récupération des offres d'emploi.
		List<OffreEmploi> offres = serviceOffreEmploi.getOffreEmplois();
		
		// Création du "contexte" JAXB. Celui-ci est paramétré avec le nom du package
		// contenant les classes générées par l'outil xjc.
		JAXBContext jc = JAXBContext.newInstance("eu.telecom_bretagne.cabinet_recrutement.front.rss");
		
		// Le "marshaller" est la classe permettra de gérer la sérialisation :
		// instances --> flux XML.
		Marshaller marshaller = jc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true); // Pour que le flux généré soit joli...
		
		// Instance de l'objet ObjectFactory qui permettra de créer les instances qui
		// permettront au marshaller de générer le flux XML.
		ObjectFactory fabrique = new ObjectFactory();

		// Création de l'objet racine (élément <rss>)
		Rss rss = fabrique.createRss();
		// Mise à jour du numéro de version RSS
		rss.setVersion(new BigDecimal(2));
		
		// Création du "channel" (élément <channel>)
		Channel channel = fabrique.createChannel();

		channel.setTitle("Cabinet de recrutement : les offres d'emplois");
		channel.setDescription("Flux RSS listant les dépot d'offres d'emplois déposées sur le site (pour le FR) ");
		channel.setLink("http://localhost:8080/CabinetRecrutement_Web/liste_offres_emplois.jsp");
		
		channel.setPubDate(Utils.date2StringRSS(new Date()));
		
		// Inclusion du channel dans le rss.
		rss.setChannel(channel);
		
		List<Item> listeItems = channel.getItem();
		listeItems.clear();
		
		for(OffreEmploi offre : offres) {
			Item itemCourant = new Item();
			
			itemCourant.setTitle(offre.getTitre());
			itemCourant.setDescription(offre.getDescriptifMission());
			itemCourant.setLink("http://localhost:8080/CabinetRecrutement_Web/infos_offre_emplois.jsp?id="+ offre.getId());
			itemCourant.setPubDate(Utils.date2StringRSS(offre.getDateDepot()));
			
			Enclosure enclosure = new Enclosure();
			enclosure.setType("image/png");
			enclosure.setUrl("http://localhost:8080/CabinetRecrutement_Web/images/petite_loupe.png");
			
			itemCourant.setEnclosure(enclosure);
			
			listeItems.add(itemCourant);
			
		}
		
		channel.item = listeItems;
		// ---------------------------------------
		// A compléter...
		//
		// Principe, pour chaque offre :
		//   - créer un élement item
		//   - renseigner les infos
		//   - inclusion de l'item dans le channel
		// ---------------------------------------

		
		// A ce stade l'objet rss est complet (les données ont toutes été incluses), on
		// procède à la sérialisation. La méthode prend en paramètres l'objet à sérialiser
		// (rss), le flux sera écrit sur le writer.
		// Le writer (instance de l'interface Writer) est en fait l'objet out provenant
		// du JSP. ce qui sera écrit sur ce flux sera renvoyé par le serveur Web sur le
		// navigateur (ou l'outil affichant le flux RSS).
		marshaller.marshal(rss, writer);
	}
	//-----------------------------------------------------------------------------
	/**
	 * Construction du flux RSS de la liste des candidature. Celles-ci sont obtenues par
	 * l'appel de la méthode {@code listeDesCandidatures()}, voir : {@link IServiceCandidature}.
	 * @param writer  l'instance du {@link Writer} sur lequel sera écrit le flux RSS.
	 *                La méthode étant appelée au sein d'un JSP, celui-ci est l'instance
	 *                de l'objet prédéfini {@code out}, instance de {@link JspWriter}.
	 * @param urlBase l'URL de base (une chaîne de caractères) permettant la récupération
	 *                des éléments du flux.
	 * @throws JAXBException
	 * @throws ServicesLocatorException
	 */
	public static void candidatures(Writer writer, String urlBase) throws JAXBException, ServicesLocatorException
	{
		IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
		
		List<Candidature> candidats = serviceCandidat.findAllCandidatures();
		
		JAXBContext jc = JAXBContext.newInstance("eu.telecom_bretagne.cabinet_recrutement.front.rss");
		
		Marshaller marshaller = jc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		
		ObjectFactory fabrique = new ObjectFactory();
		
		Rss rss = fabrique.createRss();
		
		rss.setVersion(new BigDecimal(2));
		
		Channel channel = fabrique.createChannel();
		
		channel.setTitle("Cabinet de recrutement : les candidatures");
		channel.setDescription("Flux RSS listant les dépot de candidatures déposées sur le site (pour le FR) ");
		channel.setLink("http://localhost:8080/CabinetRecrutement_Web/liste_candidature.jsp");
		
		channel.setPubDate(Utils.date2StringRSS(new Date()));
		
		rss.setChannel(channel);
		
		List<Item> listeItems = channel.getItem();
		listeItems.clear();
		
		for(Candidature candidat: candidats) {
			Item itemCourant = new Item();
			
			itemCourant.setTitle(candidat.getNom() + " " + candidat.getPrenom());
			
			itemCourant.setDescription(candidat.getCv());
			itemCourant.setLink("http://localhost:8080/CabinetRecrutement_Web/infos_candidature.jsp?id="+ candidat.getId());
			itemCourant.setPubDate(Utils.date2StringRSS(candidat.getDateDepot()));
			
			Enclosure enclosure = new Enclosure();
			enclosure.setType("image/png");
			enclosure.setUrl("http://localhost:8080/CabinetRecrutement_Web/images/petite_loupe.png");
			
			itemCourant.setEnclosure(enclosure);
			
			listeItems.add(itemCourant);
			
		}
		
		channel.item = listeItems;
		
		marshaller.marshal(rss, writer);
	}
	//-----------------------------------------------------------------------------
}
