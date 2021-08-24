import 'dart:async';
import 'package:bestapp_package/src/models/address-model.dart';
import 'package:bestapp_package/src/services/permission-services.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

class GeoService{  
  
  static Future<Coordinates> getCurrentPositionCoordinates({BuildContext context}) async {
    bool asPermission = await PermissionService.checkLocationPermission(context: context);
    if(asPermission)  {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return  Coordinates(position.latitude, position.longitude);
    }
    return null;
  }

  static Future<AddressMdl> getCurrentPosition({BuildContext context}) async {
    bool asPermission = await PermissionService.checkLocationPermission(context: context);
    AddressMdl addressMdl = new AddressMdl();

    if (asPermission) {
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

  static Future<String> getDistanceBetweenlatLng({LatLng latLng, BuildContext context}) async {
    bool asPermission = await PermissionService.checkLocationPermission(context: context);
    if (asPermission) {
      Coordinates coordinates = await getCurrentPositionCoordinates(context: context);
      num distance = Geodesy().distanceBetweenTwoGeoPoints(LatLng(coordinates.latitude, coordinates.longitude), latLng);
      
      // Convertindo de metro para KM
      double covertTokm = distance / 1000;
      return '${double.parse(covertTokm.toStringAsFixed(1)).toString()} km';
    }
    return null;
  }
}