import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/allReview.model.dart';
import 'package:qcamyapp/models/supportQuestions.model.dart';


class SupportQuestionsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/support_question_all";

  final client = http.Client();

  late SupportQuestionsModel supportQuestionsModel;

  Future<SupportQuestionsModel> allSupportQuestions({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        supportQuestionsModel = SupportQuestionsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return supportQuestionsModel;
  }

}
