import 'package:cloud_firestore/cloud_firestore.dart';

class ApartmentModel {
  final String description;
  final String nom;
  final String image;

  final int etoile;
  final int prix;
  final String typeHotel;
  final List pictures;
  final String pays;
  final String ville;
  final String user;
  final String telephone;
  final String imageProp;
  final String email;
  final String hentree;
  final String hsortie;
  final List equipement;
  final String id;
  final String address;
  final bool favoris;
  final GeoPoint position;

  ApartmentModel(
      {this.id,
      this.description,
      this.nom,
      this.image,
      this.etoile,
      this.prix,
      this.pictures,
      this.pays,
      this.ville,
      this.user,
      this.telephone,
      this.imageProp,
      this.email,
      this.hentree,
      this.hsortie,
      this.equipement,
      this.address,
      this.favoris,
      this.position,
      this.typeHotel});

  static ApartmentModel fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return ApartmentModel(
        nom: map['Nom'],
        description: map['Description'],
        image: map['Image'],
        etoile: map['etoile'],
        prix: map['prix'],
        pictures: map['pictures'],
        ville: map['ville'],
        pays: map['pays'],
        email: map['Email'],
        user: map['User'],
        imageProp: map['imageProp'],
        telephone: map['Telephone'],
        hentree: map['hentree'],
        hsortie: map['hsortie'],
        equipement: map['equipement'],
        id: documentId,
        address: map['Adresse'],
        favoris: map['favoris'],
        position: map['position'],
        typeHotel: map['typeHotel']);
  }

  Map<String, dynamic> toMap() => {
        'Nom': nom,
        'Description': description,
        'Image': image,
        'etoile': etoile,
        'prix': prix,
        'pictures': pictures,
        'ville': ville,
        'pays': pays,
        'Email': email,
        'User': user,
        'imageProp': imageProp,
        'Telephone': telephone,
        'hentree': hentree,
        'hsortie': hsortie,
        'equipement': equipement,
        'Adresse': address,
        'favoris': favoris,
        'position': position,
        'typeHotel': typeHotel,
      };
}
