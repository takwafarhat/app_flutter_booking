class Avis {
  String idhotel;
  String iduser;
  String description;
  double etoile;

  Avis({
    this.idhotel,
    this.iduser,
    this.description,
    this.etoile,
  });

  static Avis fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Avis(
      idhotel: map['idhotel'],
      iduser: map['iduser'],
      description: map['description'],
      etoile: map['etoile'].toDouble(),
    );
  }
}
