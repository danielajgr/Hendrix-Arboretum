// https://docs.flutter.dev/cookbook/networking/fetch-data

class Tree {
  final int id;
  final String buildingName;
  final String directionName;
  final String scientificName;
  final String latitude;
  final String longitude;
  final String imageURL;
  final String commonName;

  const Tree({
    required this.id,
    required this.buildingName,
    required this.directionName,
    required this.scientificName,
    required this.latitude,
    required this.longitude,
    required this.imageURL,
    required this.commonName,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'buildingName': String buildingName,
        'directionName': String directionName,
        'scientificName': String scientificName,
        'latitude': String latitude,
        'longitude': String longitude,
        'imageURL': String imageURL,
        'commonName': String commonName,
      } =>
        Tree(
          id: id,
          buildingName: buildingName,
          directionName: directionName,
          scientificName: scientificName,
          latitude: latitude,
          longitude: longitude,
          imageURL: imageURL,
          commonName: commonName,
        ),
      _ => throw const FormatException('Failed to load tree.'),
    };
  }
}

/*
Random:
[
  {
    "id": 319,
    "buildingName": "Staples Parking ",
    "directionName": "N",
    "scientificName": "Sapindus saponaria L. var drummondii",
    "latitude": "35.09954",
    "longitude": "-92.44394",
    "imageURL": "https://cs21003bffd8ab40343.blob.core.windows.net/hendrix-arboretum/Tree.0319.Soapberry.jpg",
    "commonName": "Soapberry, Western"
  }
]

id 2:
[
  {
    "id": 2,
    "buildingName": "Bailey ",
    "directionName": "W",
    "scientificName": "Pinus taeda L.",
    "latitude": "35.101325",
    "longitude": "-92.4442722",
    "imageURL": "https://cs21003bffd8ab40343.blob.core.windows.net/hendrix-arboretum/Tree.0002.Pine.jpg",
    "commonName": "Pine, Loblolly"
  }
]
*/
