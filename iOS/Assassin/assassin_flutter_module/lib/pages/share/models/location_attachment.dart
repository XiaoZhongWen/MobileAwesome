class LocationAttachment {
  String address;
  String lat;
  String lon;
  String url;

  LocationAttachment({this.url, this.address, this.lat, this.lon});

  factory LocationAttachment.fromJson(Map<String, dynamic> json) {
    return LocationAttachment(
      address: json["address"],
      lat: json["lat"],
      lon: json["lon"],
      url: json["url"],
    );
  }
}