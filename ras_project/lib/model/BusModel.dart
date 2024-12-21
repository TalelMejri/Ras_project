class RobotModel {
  int id;
  String name;
  double latitude;
  double longitude;
  bool etat;
  int battery;
  int niveau;

  RobotModel(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.etat,
      required this.battery,
      required this.niveau});

  factory RobotModel.fromJson(Map<String, dynamic> json) {
    return RobotModel(
        id: json["id"],
        latitude: json['latitude'],
        longitude: json['longitude'],
        name: json['name'],
        battery: json['battery'],
        etat: json["etat"] == 1,
        niveau: json["niveau_poubelle"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'battery': battery,
      'etat': etat,
      'niveau_poubelle': niveau
    };
  }

  @override
  String toString() {
    return 'RobotModel{id: $id, longitude: $longitude, latitude: $latitude, name: $name}';
  }
}
