extension ExMap on Map<String, Object?> {
  Map<String, Object?> convertBoolToInt() {
    Map<String, Object?> json = Map.from(this);
    forEach((key, value) {
      if(value is bool) {
        value = value?1:0;
        json[key] = value;
      }
      if(value is Map) {
        convertBoolToInt();
      }
    });
    return json;
  }

  Map<String, Object?> convertIntToBool(List<String> keys) {
    Map<String, Object?> json = Map.from(this);
    forEach((key, value) {
      if(keys.contains(key) && value is int) {
        value = value == 0? false: true;
        json[key] = value;
      }
      if(value is Map) {
        convertIntToBool(value.keys as List<String>);
      }
    });
    return json;
  }
}