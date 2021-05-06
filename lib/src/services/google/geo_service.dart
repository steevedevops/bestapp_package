import 'dart:async';
import 'package:bestapp_package/src/models/address-model.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';

class GeoService{  

  static Future<Coordinates> getCurrentPositionCoordinates({BuildContext context}) async {
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

  static Future<AddressMdl> getCurrentPosition({BuildContext context}) async {
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

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var placemarks = await Geocoder.local.findAddressesFromCoordinates(Coordinates(position.latitude, position.longitude));
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
    return null;
  }
}