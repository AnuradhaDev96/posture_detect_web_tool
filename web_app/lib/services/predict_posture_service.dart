import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/enums/prediction_result.dart';

class PredictPostureService {
  final _firestore = FirebaseFirestore.instance;

  String _baseUrl = '';
  
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

      var response = await http.get(endpoint);
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

  Future<PredictionResult> postVideoForPredictionResults(String filePath) async {
    await _configureBaseUrl();
    Uri endpoint = Uri.parse('$_baseUrl/uploadVideoToPredict');

    try {

      if (kDebugMode) print("Started fetching at: ${DateTime.now()}");

      var multipartRequest = http.MultipartRequest('POST', endpoint);

      multipartRequest.fields.addAll({
        'video_base64': await _networkImageToBase64(filePath),
      });

      var response = await multipartRequest.send();
      logEndpoint(endpoint, response.statusCode);

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var responseMap = jsonDecode(responseBody);
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

  Future<String> _networkImageToBase64(String filePath) async {
    Uri blobPath = Uri.parse(filePath);

    http.Response response = await http.get(blobPath);
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
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
