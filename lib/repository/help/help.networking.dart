import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/help.model.dart';


class HelpNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/send_support_question";

  final client = http.Client();

  late HelpModel helpModel;

  Future<HelpModel> addHelpData({required String token, required String question}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
        "question": question,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        helpModel = HelpModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return helpModel;
  }
}
