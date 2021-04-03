import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:toast/toast.dart';
class PlaceService{
  final String googleApiKey;
  final String lang;
  final Widget textInfo;
  
  PlaceService({@required this.googleApiKey, this.lang, this.textInfo});

  Future<PlacesDetailsResponse> placesSearch({BuildContext context}) async {

    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Toast.show(
        'Permissão de localização negada, por favor, vá em configurações do seu dispositivo e habilite a permissāo de localizaçāo.',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP
      );
    }
    Prediction place;
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      place = await PlacesAutocomplete.show(
        context: context,
        apiKey: this.googleApiKey,
        mode: Mode.overlay,
        language: this.lang, // language: "us", "pt"
        logo: textInfo != null ? textInfo : null,
        components: [
          Component(
            Component.country,  
            this.lang
          )
        ]
      );
    }
    if (place == null)return null;
    return await _places.getDetailsByPlaceId(place.placeId);
  }

}