import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';

class PermissionService{
  
  static Future<bool> checkLocationPermission({@required BuildContext context}) async {
    LocationPermission permission = await Geolocator.checkPermission();
    
    // Verifica se a permissao foi negado alguma vez para pedir a permiccao novamente
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.deniedForever){
      Toast.show(
        'Permissão de localização negada, por favor, vá em configurações do seu dispositivo e habilite a permissāo de localizaçāo.',
        context,
        backgroundColor: Colors.orange,
        duration: 4,
        gravity: Toast.TOP
      );
    }
    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always)return true;
    return false;
  }
}