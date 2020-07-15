import 'package:app_flat/models/chambre.dart';
import 'package:app_flat/pages/Avis/Avis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/apartment_model.dart';

class DatabaseService {
  // final String uid;
  // DatabaseService({this.uid});

  // collection reference
  final CollectionReference hotelCollection =
      Firestore.instance.collection('hotels');

  // Future<void> updateUserData(
  //   String description,
  //   String nom,
  //   String image,
  //   List<String> avis,
  //   int etoile,
  //   double prix,
  //   List<String> typedechambre,
  //   List<String> features,
  //   List pictures,
  //   int nbCommentaires,
  //   String ville,
  //   String pays,
  //   int telephone,
  //   String user,
  //   String email,
  //   String imageProp,
  //   Timestamp hentree,
  //   Timestamp hsortie,
  //   List<String> equipement,
  //   String id,
  // ) async {
  //   return await hotelCollection.document().setData({
  //     'Description': description,
  //     'Nom': nom,
  //     'Image': image,
  //     'avis': avis,
  //     'etoile': etoile,
  //     'prix': prix,
  //     'typedechambre': typedechambre,
  //     'features': features,
  //     'pictures': pictures,
  //     'nbCommentaires': nbCommentaires,
  //     'ville': ville,
  //     'pays': pays,
  //     'telephone': telephone,
  //     'user': user,
  //     'email': email,
  //     'imageProp': imageProp,
  //     'hentree': hentree,
  //     'hsortie': hsortie,
  //     'equipement': equipement,
  //   });
  // }

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
          features: doc.data['features'] ?? [],
          pictures: doc.data['pictures'] ?? [],
          ville: doc.data['ville'] ?? '',
          pays: doc.data['pays'] ?? '',
          email: doc.data['Email'] ?? '',
          user: doc.data['User'] ?? '',
          imageProp: doc.data['imageProp'] ?? '',
          telephone: doc.data['Telephone'] ?? 0,
          hentree: doc.data['hentree'],
          hsortie: doc.data['hsortie'],
          equipement: doc.data['equipement'] ?? [],
          id: doc.documentID,
          address: doc.data['Adresse'],
          favoris: doc.data['favoris']);
    }).toList();
  }

  Stream<List<ApartmentModel>> get hotels {
    return hotelCollection.snapshots().map(_hotelListFromSnapshot);
  }

  final CollectionReference chambreCollection =
      Firestore.instance.collection('chambres');

  List<Chambre> chambreListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      Chambre(
        nomHotel: doc.data['nomHotel'] ?? '',
        photo: doc.data['photo'] ?? '',
        prix: doc.data['prix'] ?? 0,
        type: doc.data['type'] ?? [],
        equipement: doc.data['equipement'] ?? [],
        pictures: doc.data['pictures'] ?? [],
        description: doc.data['description'] ?? '',
      );
    }).toList();
  }

  Stream<List<Chambre>> get chambres {
    return chambreCollection.snapshots().map(chambreListFromSnapshot);
  }

  Future<List<Chambre>> getChamberByHotelId(String idhotel) async {
    var postDocuments = await chambreCollection.getDocuments();
    if (postDocuments.documents.isNotEmpty) {
      List<Chambre> list = postDocuments.documents
          .map(
              (snapshot) => Chambre.fromMap(snapshot.data, snapshot.documentID))
          .where((mappedItem) => mappedItem.idhotel == idhotel)
          .toList();
      return list;
    } else
      return [];
  }

  final CollectionReference avisCollection =
      Firestore.instance.collection('Avis');

  List<Avis> avisListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      Avis(
        idhotel: doc.data['idhotel'] ?? '',
        iduser: doc.data['iduser'] ?? '',
        description: doc.data['Description'] ?? '',
        etoile: doc.data['etoile'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Avis>> get avis {
    return avisCollection.snapshots().map(avisListFromSnapshot);
  }

  Future<List<Avis>> getavisByHotelId(String idhotel) async {
    var postDocuments = await avisCollection.getDocuments();
    if (postDocuments.documents.isNotEmpty) {
      List<Avis> list = postDocuments.documents
          .map((snapshot) => Avis.fromMap(snapshot.data, snapshot.documentID))
          .where((mappedItem) => mappedItem.idhotel == idhotel)
          .toList();
      return list;
    } else
      return [];
  }
}
