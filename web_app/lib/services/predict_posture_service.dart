import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/enums/prediction_result.dart';

class PredictPostureService {
  //TODO: change base url based on firestore
  String baseUrl = 'https://015b-35-230-162-0.ngrok.io/';

  final Map<String, String> _commonHeaders = {
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Connection': 'keep-alive',
  };

  Future<PredictionResult> getPredictionResults() async {
    Uri endpoint = Uri.parse('${baseUrl}predictPosture/true');

    try {
      if (kDebugMode) print("Started fetching at: ${DateTime.now()}");

      var response = await http.get(endpoint, headers: _commonHeaders);
      logEndpoint(endpoint, response.statusCode);

      if (kDebugMode) print("Received results at: ${DateTime.now()}");

      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        String result = responseMap["data"];

        if (result == "correct") {
          return PredictionResult.goodPosture;
        } else {
          return PredictionResult.badPosture;
        }
      } else {
        return PredictionResult.serverError;
      }
    } on SocketException catch (exception) {
      logException(endpoint, exception);
      return PredictionResult.serverError;
    } catch (error) {
      logException(endpoint, error);
      return PredictionResult.serverError;
    }
  }

  void logEndpoint(dynamic endpoint, int statusCode) {
    if (kDebugMode) {
      print('[Calling endpoint: $endpoint]\nStatus code: $statusCode');
    }
  }

  void logException(dynamic endpoint, dynamic e) {
    if (kDebugMode) {
      print('[Endpoint: $endpoint]\nException: $e');
    }
  }
}
