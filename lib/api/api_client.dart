import 'dart:convert';

import 'package:get/get.dart';
import 'package:pak_pharma/Constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as Http;

class ApiClient extends GetxService {
    String appBaseUrl= baseUrl;
     SharedPreferences sharedPreferences = prefs!;
    String noInternetMessage = 'Connection to API server failed due to internet connection';
   int timeoutInSeconds = 30;

  late String token;
  late Map<String, String> _mainHeaders;

   Future<ApiClient> init() async {
     // await GetStorage.init();
     token = sharedPreferences.getString("token")??"";
     updateHeader(token, sharedPreferences.getString("token")??"");
     return this;
   }
  ApiClient() {
    token = sharedPreferences.getString("token")??"";
    print('Token: $token');
    updateHeader(token, sharedPreferences.getString("token")??"");
  }

  void updateHeader(String token, String languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS,"
    };
  }

    Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
      try {
        final url = Uri.parse(appBaseUrl+uri);
        final newURI = url.replace(queryParameters: query);
        print("Url:  $newURI");
        Http.Response _response = await Http.get(
          newURI,
          headers: headers ?? _mainHeaders,
        ).timeout(Duration(seconds: timeoutInSeconds));
        return handleResponse(_response, uri);
      } catch (e) {
        return Response(statusCode: 1, statusText: noInternetMessage);
      }
    }
   Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
     try {
       Http.Response _response = await Http.post(
         Uri.parse(appBaseUrl+uri),
         body: jsonEncode(body),
         headers: headers ?? _mainHeaders,
       ).timeout(Duration(seconds: timeoutInSeconds));
       return handleResponse(_response, uri);
     } catch (e) {
       return Response(statusCode: 1, statusText: noInternetMessage);
     }
   }


   Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
     try {
       Http.Response _response = await Http.put(
         Uri.parse(appBaseUrl+uri),
         body: jsonEncode(body),
         headers: headers ?? _mainHeaders,
       ).timeout(Duration(seconds: timeoutInSeconds));
       return handleResponse(_response, uri);
     } catch (e) {
       return Response(statusCode: 1, statusText: noInternetMessage);
     }
   }

   Future<Response> deleteData(String uri, {Map<String, dynamic>? query,Map<String, String>? headers}) async {
     try {
       final url = Uri.parse(appBaseUrl+uri);
       final newURI = url.replace(queryParameters: query);
       print("Url:  $newURI");
       Http.Response _response = await Http.delete(
         newURI,
         headers: headers ?? _mainHeaders,
       ).timeout(Duration(seconds: timeoutInSeconds));
       return handleResponse(_response, uri);
     } catch (e) {
       return Response(statusCode: 1, statusText: noInternetMessage);
     }
   }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        // ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        // _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    print('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    return _response;
  }
}

