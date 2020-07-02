class Chambre {
  String nomHotel;
  int prix;
  String type;
  String photo;
  String idhotel;
  String id;

  Chambre({
    this.prix,
    this.nomHotel,
    this.photo,
    this.type,
    this.idhotel,
    this.id,
  });

  static Chambre fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Chambre(
      nomHotel: map['nomHotel'],
      photo: map['photo'],
      prix: map['prix'],
      type: map['type'],
      idhotel: map['idhotel'],
      id: documentId,
    );
  }
}
