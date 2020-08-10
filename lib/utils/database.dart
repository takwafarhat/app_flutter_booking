import 'package:app_flat/models/chambre.dart';
import 'package:app_flat/pages/Avis/Avis.dart';
import 'package:app_flat/pages/Equipement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/apartment_model.dart';

class DatabaseService {
  // final String uid;
  // DatabaseService({this.uid});

  // collection reference
  final CollectionReference hotelCollection =
      Firestore.instance.collection('hotels');

  List<ApartmentModel> _hotelListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return ApartmentModel(
          nom: doc.data['Nom'] ?? '',
          description: doc.data['Description'] ?? '',
          image: doc.data['Image'] ?? '',
          etoile: doc.data['etoile'] ?? 0,
          prix: doc.data['prix'] ?? 0,
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
          favoris: doc.data['favoris'],
          position: doc.data['position'],
          typeHotel: doc.data['typeHotel'] ?? '');
    }).toList();
  }

  Future<List<ApartmentModel>> getHotels() async {
    var postDocuments = await hotelCollection.getDocuments();
    if (postDocuments.documents.isNotEmpty) {
      List<ApartmentModel> list = postDocuments.documents
          .map((snapshot) =>
              ApartmentModel.fromMap(snapshot.data, snapshot.documentID))
          .toList();
      return list;
    } else
      return [];
  }

  Future<List<ApartmentModel>> getHotelById(String id) async {
    var postDocuments = await hotelCollection.getDocuments();
    if (postDocuments.documents.isNotEmpty) {
      List<ApartmentModel> list = postDocuments.documents
          .map((snapshot) =>
              ApartmentModel.fromMap(snapshot.data, snapshot.documentID))
          .where((mappedItem) => mappedItem.id == id)
          .toList();
      return list;
    } else
      return [];
  }

  Future<List<Equipement>> getEquipements() async {
    var postDocuments = await equipementCollection.getDocuments();
    if (postDocuments.documents.isNotEmpty) {
      List<Equipement> list = postDocuments.documents
          .map((snapshot) =>
              Equipement.fromMap(snapshot.data, snapshot.documentID))
          .toList();
      return list;
    } else
      return [];
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

  final CollectionReference equipementCollection =
      Firestore.instance.collection('Equipement');

  List<Equipement> equipementListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      Equipement(
        idHotel: doc.data['idHotel'] ?? '',
        nom: doc.data['nom'] ?? '',
        photo: doc.data['photo'] ?? '',
      );
    }).toList();
  }

  Stream<List<Equipement>> get equipement {
    return equipementCollection.snapshots().map(equipementListFromSnapshot);
  }

  Future<List<Equipement>> getEquipementByHotelId(String idHotel) async {
    var postDocuments = await equipementCollection.getDocuments();
    if (postDocuments.documents.isNotEmpty) {
      List<Equipement> list = postDocuments.documents
          .map((snapshot) =>
              Equipement.fromMap(snapshot.data, snapshot.documentID))
          .where((mappedItem) => mappedItem.idHotel == idHotel)
          .toList();
      return list;
    } else
      return [];
  }
}
