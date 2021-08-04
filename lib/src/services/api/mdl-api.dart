import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

@deprecated
class ApiMdlServices{
  static bool _asError = false;
  bool get asError => _asError;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Map<String, dynamic>> mdlApi({@required BuildContext context, Map<String, dynamic> result}) async{  
    final SharedPreferences prefs = await _prefs;
    if (result['statusCode'] == 200) {
      _asError = false; 
    }else if(result['statusCode'] == 403){      
      _asError = true;
      prefs.remove('sessionid');
      Navigator.pushNamed(context, '/');
    }else{    
      _asError = true;      
    }
    return result;
  }
}