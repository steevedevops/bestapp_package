import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices{
  final _token;
  final _baseUrl;
  final _appVersion = "/api/v1/";    
  static bool _reqSuccess = false;
  bool get reqSuccess => _reqSuccess;
  Dio dio = new Dio();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ApiServices(this._token, this._baseUrl);

  Future<Map<String, dynamic>> callApi({
    @required metodo,
    BuildContext context,
    @required rota,
    String redirectTo,
    Map<String, dynamic> params,
    Map<String, dynamic> payload,
    ProgressCallback onSendProgress
  }) async {
    var response;
    SharedPreferences prefs = await _prefs;

    Map<String, dynamic> headers = {
      "Content-Type": "application/json", 
      "Accept": "application/json"
    };
    if(_token != '') headers['Cookie'] = 'sessionid=$_token';
    dio.options.baseUrl = this._baseUrl+this._appVersion;
    dio.options.headers = headers;
    dio.options.method = metodo;
    dio.options.responseType = ResponseType.json;    
    Map<String, dynamic> jsonReturned = {};
    try {
      response = await dio.request(
        rota,
        onSendProgress: onSendProgress,
        data: payload,
        queryParameters: params
      );
      _reqSuccess = true;
      jsonReturned = (response.data is String) ? {'msg': ''} : response.data;
      jsonReturned['statusCode'] = response.statusCode;
    } on DioError catch (e) {
      _reqSuccess = false;

      if(e.response != null){        
        jsonReturned['statusCode'] = e.response.statusCode;
        switch (e.response.statusCode) {          
          case 400:
            jsonReturned = e.response.data;
            break;
          case 403: //unauthorized OR forbidden            
            prefs.remove('sessionid');
            prefs.remove('pkUser');
            prefs.remove('groupUser');
            jsonReturned = {'msg': e.response.data['msg']};
            Navigator.pushNamed(context, redirectTo != null ? redirectTo : '/login');
            return jsonReturned;
            break;
          default:
            jsonReturned = {'msg': 'Ops, tivemos problemas ${e.response.statusCode}!'};
        }
      }else{
        jsonReturned = {'msg': 'Ops, tivemos problemas ${e.message}!'};
      }      
      return jsonReturned;
    }
    return jsonReturned;
  }

  Future<Map> uploadFile({
    @required String rota, 
    @required File file,     
    @required BuildContext context,
    Map<String, dynamic> paramsData,
    ProgressCallback onSendProgress,
    String redirectTo,
  }) async {        
    SharedPreferences prefs = await _prefs;
    var dio = new Dio();
    var response;
    Map<String, dynamic> jsonReturned = {};

    if (this._token != null) {        
      dio.options.baseUrl = this._baseUrl+this._appVersion;
      FormData formData = new FormData.fromMap({
        ...paramsData,
        'file': await MultipartFile.fromFile(file.absolute.path, filename: DateTime.now().millisecondsSinceEpoch.toString()+'.jpg')
      });

      try {
        response = await dio.post(
          rota,
          data: formData,
          onSendProgress: onSendProgress,
          options: Options(
            method: 'POST',
            responseType: ResponseType.json,
            followRedirects: false,
            headers: {
              'Cookie': 'sessionid=${this._token}',
              'X-Requested-With': 'XMLHttpRequest',
            }
          )          
        );
        _reqSuccess = true;
        jsonReturned = response.data;
        jsonReturned['statusCode'] = response.statusCode;

      } on DioError catch (e) {
        _reqSuccess = false;

        if(e.response != null){        
          jsonReturned['statusCode'] = e.response.statusCode;
          switch (e.response.statusCode) {          
            case 400:
              jsonReturned = e.response.data;
              break;
            case 403: //unauthorized OR forbidden            
              prefs.remove('sessionid');
            prefs.remove('pkUser');
            prefs.remove('groupUser');
              jsonReturned = {'msg': e.response.data['detail']};
              Navigator.pushNamed(context, redirectTo != null ? redirectTo : '/login');
              break;
            default:
              jsonReturned = {'msg': 'Ops, tivemos problemas ${e.response.statusCode}!'};
          }
        }else{
          jsonReturned = {'msg': 'Ops, tivemos problemas ${e.message}!'};
        }      
        return jsonReturned;
      }
      return jsonReturned;      
    }
    return null;
  }
}