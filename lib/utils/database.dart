import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/apartment_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference hotelCollection =
      Firestore.instance.collection('hotels');

  Future<void> updateUserData(
    String description,
    String nom,
    String image,
    List<String> avis,
    int etoile,
    double prix,
    List<String> typedechambre,
    List<String> features,
    List pictures,
    int nbCommentaires,
    String ville,
    String pays,
    int telephone,
    String user,
    String email,
    String imageProp,
    Timestamp hentree,
    Timestamp hsortie,
    List<String> equipement,
  ) async {
    return await hotelCollection.document(uid).setData({
      'Description': description,
      'Nom': nom,
      'Image': image,
      'avis': avis,
      'etoile': etoile,
      'prix': prix,
      'typedechambre': typedechambre,
      'features': features,
      'pictures': pictures,
      'nbCommentaires': nbCommentaires,
      'ville': ville,
      'pays': pays,
      'telephone': telephone,
      'user': user,
      'email': email,
      'imageProp': imageProp,
      'hentree': hentree,
      'hsortie': hsortie,
      'equipement': equipement,
    });
  }

  List<ApartmentModel> _hotelListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return ApartmentModel(
        nom: doc.data['Nom'] ?? '',
        description: doc.data['Description'] ?? '',
        image: doc.data['Image'] ?? '',
        avis: doc.data['avis'] ?? [],
        etoile: doc.data['etoile'] ?? 0,
        prix: doc.data['prix'] ?? 0,
        typedechambre: doc.data['typedechambre'] ?? [],
        features: doc.data['features'] ?? [],
        pictures: doc.data['pictures'] ?? [],
        nbCommentaires: doc.data['nbCommentaires'] ?? 0,
        ville: doc.data['ville'] ?? '',
        pays: doc.data['pays'] ?? '',
        email: doc.data['Email'] ?? '',
        user: doc.data['User'] ?? '',
        imageProp: doc.data['imageProp'] ?? '',
        telephone: doc.data['Telephone'] ?? 0,
        hentree: doc.data['hentree'],
        hsortie: doc.data['hsortie'],
        equipement: doc.data['equipement'] ?? [],
      );
    }).toList();
  }

  Stream<List<ApartmentModel>> get hotels {
    return hotelCollection.snapshots().map(_hotelListFromSnapshot);
  }
}
