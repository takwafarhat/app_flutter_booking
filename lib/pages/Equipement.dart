class Equipement {
  String idHotel;
  String nom;
  String photo;

  Equipement({
    this.idHotel,
    this.nom,
    this.photo,
  });
  static Equipement fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Equipement(
      idHotel: map['idHotel'],
      nom: map['nom'],
      photo: map['photo'],
    );
  }
}
