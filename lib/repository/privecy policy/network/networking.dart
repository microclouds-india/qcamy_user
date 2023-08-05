import 'dart:convert';

import '../../../models/privecyPolicyModel.dart';
import 'package:http/http.dart' as http;

class PrivecyPolicyNetworking {
  late PrivecyPolicyModel model;

Future<PrivecyPolicyModel> getData()async{
  try {
    var url = Uri.parse('https://cashbes.com/photography/apis/privacy_policy');
    var response = await http.post(url,body: {
      'id':'1'
    });
    if (response.statusCode==200) {
      var json = jsonDecode(response.body);
      model = PrivecyPolicyModel.fromJson(json);
    }
  } catch (e) {
    Future.error(e);
  }
  return model;
}

}