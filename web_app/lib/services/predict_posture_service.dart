import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/enums/prediction_result.dart';

class PredictPostureService {
  final _firestore = FirebaseFirestore.instance;
  
  //TODO: change base url based on firestore
  String _baseUrl = '';

  final Map<String, String> _commonHeaders = {
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Connection': 'keep-alive',
  };
  
  Future<void> _configureBaseUrl() async {
    await _firestore.collection('baseUrls').doc('default').get().then((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      _baseUrl = data['httpsUrl'];
    });
  }

  Future<PredictionResult> getPredictionResults() async {
    await _configureBaseUrl();
    final valueParams = ['true', 'false'];

    Uri endpoint = Uri.parse('$_baseUrl/predictPosture/${valueParams[Random().nextInt(valueParams.length)]}');

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
