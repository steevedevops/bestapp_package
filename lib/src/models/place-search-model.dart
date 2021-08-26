class PlaceSearchModel {
  String description;
  String placeId;

  PlaceSearchModel(
      {this.description,
      this.placeId});

  PlaceSearchModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
  }

  static List<PlaceSearchModel> fromJsonList(jsonList) {
    return jsonList.map<PlaceSearchModel>((obj) => PlaceSearchModel.fromJson(obj)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['place_id'] = this.placeId;
    return data;
  }
}