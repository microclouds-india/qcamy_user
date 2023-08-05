import 'dart:convert';

import '../../models/return policy.dart';
import 'package:http/http.dart' as http;

class ReturnPolicyNetworking {
 late ReturnPolicyModel model;


 Future<ReturnPolicyModel> getData(String id)async{
    try {
      var url = Uri.parse('https://cashbes.com/photography/apis/return_policy');
      var response = await http.post(url,body: {
        'trader_id':'6'
      });
      if (response.statusCode==200) {
        var json = jsonDecode(response.body);
        model = ReturnPolicyModel.fromJson(json);
      }
    } catch (e) {
      Future.error(e);
    }
    return model;
  }
  

}