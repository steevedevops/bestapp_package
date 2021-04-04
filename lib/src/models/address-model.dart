class AddressMdl {
  int number;
  String state;
  String country;
  String street;
  String city;
  String countrycode;
  String postalcode;
  String sublocality;
  double latitude;
  double longitude;


  AddressMdl(
      {this.number,
      this.state,
      this.country,
      this.street,
      this.city,
      this.countrycode,
      this.postalcode,
      this.sublocality,
      this.longitude,
      this.latitude
    });

  AddressMdl.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    state = json['state'];
    country = json['country'];
    street = json['street'];
    city = json['city'];
    countrycode = json['countrycode'];
    postalcode = json['postalcode'];
    sublocality = json['sublocality'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['state'] = this.state;
    data['country'] = this.country;
    data['street'] = this.street;
    data['city'] = this.city;
    data['countrycode'] = this.countrycode;
    data['postalcode'] = this.postalcode;
    data['sublocality'] = this.sublocality;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}