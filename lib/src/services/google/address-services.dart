import 'package:bestapp_package/src/models/address-model.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';

class AddressService{  

  static Future<AddressMdl> getAddress({@required BuildContext context, @required String addressSearch}) async{
    LocationPermission permission = await Geolocator.checkPermission();
    AddressMdl addressMdl = new AddressMdl();

    if (addressSearch == null)return null;

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
      var placemarks = await Geocoder.local.findAddressesFromQuery(addressSearch);
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