class EquipementChambre {
  String idChamber;
  String nom;
  String photo;

  EquipementChambre({
    this.idChamber,
    this.nom,
    this.photo,
  });
  static EquipementChambre fromMap(
      Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return EquipementChambre(
      idChamber: map['idChamber'],
      nom: map['nom'],
      photo: map['photo'],
    );
  }

  Map<String, dynamic> toMap() => {
        'idChamber': idChamber,
        'nom': nom,
        'photo': photo,
      };
}
