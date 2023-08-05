import 'package:flutter/material.dart';
import 'package:qcamyapp/repository/return%20policy/networking.dart';

import '../../models/return policy.dart';

class ReturnPolicyNotifier extends ChangeNotifier {
  late ReturnPolicyModel model;
  final ReturnPolicyNetworking networking =ReturnPolicyNetworking();
  

  Future<ReturnPolicyModel> getData(String id)async{
    try {
      model = await networking.getData(id); 
    } catch (e) {
      Future.error(e);
    }
    return model;
  }

}