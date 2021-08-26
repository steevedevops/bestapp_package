// https://github.com/nhandrew/google_places_autocomplete/
// import 'package:bestapp_package/src/models/address-model.dart';
// import 'package:bestapp_package/src/models/place-search-model.dart';
// import 'package:bestapp_package/src/services/api/api-services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:toast/toast.dart';

import 'package:bestapp_package/bestapp_package.dart';
import 'package:bestapp_package/src/models/place-search-model.dart';
import 'package:flutter/material.dart';

class PlaceService{
  
  final String _googleApiKey;
  PlaceService(this._googleApiKey);

  // static Future<Coordinates> placesSearchCoordinates({@required BuildContext context, @required googleApiKey, String lang, String country, Widget textInfo}) async {  
  //   GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     Toast.show(
  //       'Permissão de localização negada, por favor, vá em configurações do seu dispositivo e habilite a permissāo de localizaçāo.',
  //       context,
  //       duration: Toast.LENGTH_LONG,
  //       gravity: Toast.TOP
  //     );
  //   }
  //   Prediction place;
  //   if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
  //     place = await PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: googleApiKey,
  //       mode: Mode.overlay,
  //       language: lang, // language: "us", "pt"
  //       logo: textInfo != null ? textInfo : null,
  //       components: [
  //         Component(
  //           Component.country,  
  //           country
  //         )
  //       ]
  //     );
  //   }
  //   if (place == null)return null;
  //   PlacesDetailsResponse placeInfo = await _places.getDetailsByPlaceId(place.placeId);
  //   return  Coordinates(placeInfo.result.geometry.location.lat, placeInfo.result.geometry.location.lng);
  // }

  Future<List<PlaceSearchModel>> getAutocompletePlaces({@required BuildContext context, String lang, @required String search}) async {
    ApiServices apiServices = new ApiServices('', 'https://maps.googleapis.com/maps/api');
    List<PlaceSearchModel> placeSearchs = [];

    var result = await apiServices.callApi(
      context: context,
      metodo: 'GET',
      rota: 'place/autocomplete/json',
      params: {
        'key': this._googleApiKey,
        'input': search,
        'language': lang != null ? lang : 'pt_BR'
      }
    );
    if(apiServices.reqSuccess){
      placeSearchs = PlaceSearchModel.fromJsonList(result['predictions']);
      return placeSearchs;
    }
    return placeSearchs;
  }


  Future<AddressMdl> getPlaceDetailsbyId({@required BuildContext context, String placeId}) async {
    ApiServices apiServices = new ApiServices('', 'https://maps.googleapis.com/maps/api');
    AddressMdl addressMdl = new AddressMdl();
    bool asPermission = await PermissionService.checkLocationPermission(context: context);
    
    var result = await apiServices.callApi(
      context: context,
      metodo: 'GET',
      rota: 'place/details/json',
      params: {
        'place_id': placeId,
        'key': this._googleApiKey,
      }
    );
    if(apiServices.reqSuccess){
      PlaceDetailsModel placeDetailsModel = PlaceDetailsModel.fromJson(result['result']);
      if(asPermission){
        var placemarks = await Geocoder.local.findAddressesFromCoordinates(Coordinates(placeDetailsModel.geometry.location.lat, placeDetailsModel.geometry.location.lng));
        
        if (! placemarks.asMap().containsKey(0))return addressMdl;

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
    return addressMdl;
  }


  Future<AddressMdl> getAdressByCoordinates({@required BuildContext context, @required double longitude, @required double latitude}) async {
    ApiServices apiServices = new ApiServices('', 'https://maps.googleapis.com/maps/api');
    AddressMdl addressMdl = new AddressMdl();
    bool asPermission = await PermissionService.checkLocationPermission(context: context);
    
    if(asPermission){
      var placemarks = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latitude, longitude));
      
      if (! placemarks.asMap().containsKey(0))return addressMdl;

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
    return addressMdl;
  }




  // Future<AddressMdl> placesSearch({@required BuildContext context, @required googleApiKey, String lang, String country, Widget textInfo}) async {
  //   GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   AddressMdl addressMdl = new AddressMdl();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     Toast.show(
  //       'Permissão de localização negada, por favor, vá em configurações do seu dispositivo e habilite a permissāo de localizaçāo.',
  //       context,
  //       duration: Toast.LENGTH_LONG,
  //       gravity: Toast.TOP
  //     );
  //   }
  //   Prediction place;
  //   if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
  //     place = await PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: googleApiKey,
  //       mode: Mode.overlay,
  //       language: lang, // language: "us", "pt"
  //       logo: textInfo != null ? textInfo : null,
  //       components: [
  //         Component(
  //           Component.country,  
  //           country
  //         )
  //       ]
  //     );
  //   }
  //   if (place == null)return null;
  //   PlacesDetailsResponse placeInfo = await _places.getDetailsByPlaceId(place.placeId);
  //   var placemarks = await Geocoder.local.findAddressesFromCoordinates(Coordinates(placeInfo.result.geometry.location.lat, placeInfo.result.geometry.location.lng));

  //   if (! placemarks.asMap().containsKey(0))return null;
  //   addressMdl.state = placemarks.first.adminArea;
  //   addressMdl.country = placemarks.first.countryName;
  //   addressMdl.street = placemarks.first.thoroughfare;
  //   addressMdl.city = placemarks.first.subAdminArea;
  //   addressMdl.sublocality = placemarks.first.subLocality;
  //   addressMdl.countrycode = placemarks.first.countryCode;
  //   addressMdl.postalcode = placemarks.first.postalCode;
  //   addressMdl.longitude = placemarks.first.coordinates.longitude;
  //   addressMdl.latitude = placemarks.first.coordinates.latitude;
  //   return addressMdl;
  // }
}