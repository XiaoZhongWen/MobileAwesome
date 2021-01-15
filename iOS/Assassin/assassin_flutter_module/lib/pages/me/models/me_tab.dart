class MeTab {
  String name;
  String aliasName;
  String iconUrl;
  String url;
  String type;

  MeTab({this.name, this.aliasName, this.iconUrl, this.url, this.type});

  factory MeTab.fromJson(Map<String, dynamic> json) {
    return MeTab(
      name: json["name"],
      aliasName: json["aliasName"],
      iconUrl: json["iconUrl"],
      url: json["url"],
      type: json["type"]
    );
  }
}