import 'dart:ffi';
import 'dart:math';

class Chambre {
  final String nomHotel;
  final double prix;
  final String type;
  final String idhotel;
  final String id;
  final List pictures;
  final String description;
  final int ratingCount;

  final int nbChambredispo;
  final List equip;

  Chambre({
    this.prix,
    this.nomHotel,
    this.type,
    this.idhotel,
    this.id,
    this.pictures,
    this.description,
    this.ratingCount,
    this.nbChambredispo,
    this.equip,
  });

  static Chambre fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Chambre(
      nomHotel: map['nomHotel'],
      prix: (map['prix'] as num).toDouble(),
      type: map['type'] == null ? "" : map['type'],
      idhotel: map['idhotel'],
      pictures: map['pictures'] == null ? [] : map['pictures'],
      description: map['description'] ? "" : map['description'],
      nbChambredispo: map['nbChambredispo'] == null ? 1 : map['nbChambredispo'],
      id: documentId,
      ratingCount: 5,
    );
  }

  Map<String, dynamic> toMap() => {
        'nomHotel': nomHotel,
        'prix': prix,
        'type': pictures,
        'idhotel': idhotel,
        'pictures': pictures,
        'description': description,
        'nbChambredispo': nbChambredispo,
      };
}
