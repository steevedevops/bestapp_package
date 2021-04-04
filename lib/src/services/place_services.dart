import 'package:bestapp_package/src/models/address-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:toast/toast.dart';
class PlaceService{

  static Future<Coordinates> placesSearchCoordinates({@required BuildContext context, @required googleApiKey, String lang, String country, Widget textInfo}) async {
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
        apiKey: googleApiKey,
        mode: Mode.overlay,
        language: lang, // language: "us", "pt"
        logo: textInfo != null ? textInfo : null,
        components: [
          Component(
            Component.country,  
            country
          )
        ]
      );
    }
    if (place == null)return null;
    PlacesDetailsResponse placeInfo = await _places.getDetailsByPlaceId(place.placeId);
    return  Coordinates(placeInfo.result.geometry.location.lat, placeInfo.result.geometry.location.lng);
  }
  
  Future<AddressMdl> placesSearch({@required BuildContext context, @required googleApiKey, String lang, String country, Widget textInfo}) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
    LocationPermission permission = await Geolocator.checkPermission();
    AddressMdl addressMdl = new AddressMdl();

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
        apiKey: googleApiKey,
        mode: Mode.overlay,
        language: lang, // language: "us", "pt"
        logo: textInfo != null ? textInfo : null,
        components: [
          Component(
            Component.country,  
            country
          )
        ]
      );
    }
    if (place == null)return null;
    PlacesDetailsResponse placeInfo = await _places.getDetailsByPlaceId(place.placeId);
    var placemarks = await Geocoder.local.findAddressesFromCoordinates(Coordinates(placeInfo.result.geometry.location.lat, placeInfo.result.geometry.location.lng));

    if (! placemarks.asMap().containsKey(0))return null;
    addressMdl.state = placemarks.first.adminArea;
    addressMdl.country = placemarks.first.countryName;
    addressMdl.street = placemarks.first.thoroughfare;
    addressMdl.city = placemarks.first.subAdminArea;
    addressMdl.sublocality = placemarks.first.subLocality;
    addressMdl.countrycode = placemarks.first.countryCode;
    addressMdl.postalcode = placemarks.first.postalCode;
    addressMdl.longitude = placemarks.first.coordinates.longitude;
    addressMdl.latitude = placemarks.first.coordinates.latitude;
    return addressMdl;
  }
}