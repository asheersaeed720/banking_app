class NearbyPlace {
  NearbyPlace({
    this.latitude,
    this.longitude,
    this.name,
    // this.photos,
    this.placeId,
    // this.rating,
    this.reference,
    this.userRatingsTotal,
    this.vicinity,
  });

  String? name;
  // List<PlacePhoto>? photos;
  String? placeId;
  double? latitude;
  double? longitude;
  // double? rating;
  String? reference;
  int? userRatingsTotal;
  String? vicinity;

  factory NearbyPlace.fromJson(Map<String, dynamic> json) => NearbyPlace(
        name: json["name"],
        // photos: List<PlacePhoto>.from(json["photos"].map((x) => PlacePhoto.fromJson(x))),
        placeId: json["place_id"],
        latitude: json["geometry"]["location"]["lat"],
        longitude: json["geometry"]["location"]["lng"],
        // rating: json["rating"].toDouble(),
        reference: json["reference"],
        userRatingsTotal: json["user_ratings_total"],
        vicinity: json["vicinity"],
      );
}

// class PlacePhoto {
//   PlacePhoto({
//     this.height,
//     this.htmlAttributions,
//     this.photoReference,
//     this.width,
//   });

//   int? height;
//   List<String>? htmlAttributions;
//   String? photoReference;
//   int? width;

//   factory PlacePhoto.fromJson(Map<String, dynamic> json) => PlacePhoto(
//         height: json["height"],
//         htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
//         photoReference: json["photo_reference"],
//         width: json["width"],
//       );

//   Map<String, dynamic> toJson() => {
//         "height": height,
//         "html_attributions": List<dynamic>.from(htmlAttributions!.map((x) => x)),
//         "photo_reference": photoReference,
//         "width": width,
//       };
// }
