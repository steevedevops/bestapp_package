import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiServices{
  final _token;
  final _baseUrl;
  final _appVersion = "/api/v1/";
  Dio dio = new Dio();
  ApiServices(this._token, @required this._baseUrl);

  Future<Map<String, dynamic>> callApi({
    @required metodo,
    @required rota,
    Map<String, dynamic> params,
    Map<String, dynamic> payload,
  }) async {
    var response;
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
        data: payload,
        queryParameters: params
      );
      jsonReturned = response.data;
      jsonReturned['statusCode'] = response.statusCode;
    } catch (e) {
      jsonReturned = e.response.statusCode == 400 ? e.response.data : e.response.statusCode == 403 ? {'msg': e.response.data['detail']} :  {'msg': 'Ops, tivemos problemas ${e.response.statusCode}!'};
      jsonReturned['statusCode'] = e.response.statusCode;
      return jsonReturned;
    }
    return jsonReturned;
  }

  Future<Map> uploadFile({@required String rota, @required File file, Map<String, dynamic> paramsData}) async {
    var dio = new Dio();
    var response;

    if (this._token != null) {        
      dio.options.baseUrl = this._baseUrl+this._appVersion;
      FormData formData = new FormData.fromMap({
        ...paramsData,
        'file': await MultipartFile.fromFile(file.absolute.path, filename: DateTime.now().millisecondsSinceEpoch.toString()+'.jpg')
      });

      response = await dio.post(rota,
          data: formData,
          options: Options(
              method: 'POST',
              responseType: ResponseType.json,
              followRedirects: false,
              headers: {
                'Cookie': 'sessionid=${this._token}',
                'X-Requested-With': 'XMLHttpRequest',
              }), onSendProgress: (int sent, int total) {
          print(((sent / total) * 100).toStringAsFixed(0) + " %");
      });

      Map responseResturn = json.decode(response.toString());
      responseResturn["statusCode"] = response.statusCode;
      responseResturn["msg"] = responseResturn['msg'];
      return responseResturn;
    }
  }
}