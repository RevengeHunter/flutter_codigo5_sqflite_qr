class VaccineCardModel{
  int? id;
  String urlVaccineCard;
  String fullName;
  String? dni;

  VaccineCardModel({
    this.id,
    required this.urlVaccineCard,
    required this.fullName,
    this.dni,
  });

  factory VaccineCardModel.fromJson(Map<String, dynamic> json) => VaccineCardModel(
    id: json["id"],
    urlVaccineCard: json["urlVaccineCard"],
    fullName: json["fullName"],
    dni: json["dni"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "urlVaccineCard": urlVaccineCard,
    "fullName": fullName,
    "dni": dni,
  };
}