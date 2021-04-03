import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';

class GeoService{  

  static Future<Coordinates> getCurrentPosition({BuildContext context}) async {

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

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return  Coordinates(position.latitude, position.longitude);
    }
    return null;
  }


  static Future<Map<String, dynamic>> getAddress(double latitude, double longitude) async{
    if (latitude == null || longitude == null)return null;

    var placemarks = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latitude, longitude));
    if (! placemarks.asMap().containsKey(0)) {
      return null;
    }
    return {
      'number': placemarks.first.featureName,
      'state': placemarks.first.adminArea,
      'county': placemarks.first.subAdminArea,
      'street':placemarks.first.thoroughfare,
      'city': placemarks.first.locality,
      'country': placemarks.first.countryCode,
      'postalcode': placemarks.first.postalCode,
    };
  }
}