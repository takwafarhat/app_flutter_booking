import 'dart:math';

class Chambre {
  final String nomHotel;
  final int prix;
  final String type;
  final String photo;
  final String idhotel;
  final String id;
  final List equipement;
  final List pictures;
  final String description;
  final int ratingCount;
  final double averageRating;

  Chambre({
    this.prix,
    this.nomHotel,
    this.photo,
    this.type,
    this.idhotel,
    this.id,
    this.equipement,
    this.pictures,
    this.description,
    this.ratingCount,
    this.averageRating,
  });

  static Chambre fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Chambre(
      nomHotel: map['nomHotel'],
      photo: map['photo'],
      prix: map['prix'],
      type: map['type'],
      idhotel: map['idhotel'],
      equipement: map['equipement'],
      pictures: map['pictures'],
      description: map['description'],
      id: documentId,
      ratingCount: 5,
    );
  }
}
