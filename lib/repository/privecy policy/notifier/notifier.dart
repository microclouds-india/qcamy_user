import 'package:flutter/material.dart';

import '../../../models/privecyPolicyModel.dart';
import '../network/networking.dart';

class PrivecyNotifier extends ChangeNotifier {
  late PrivecyPolicyModel model;
  final PrivecyPolicyNetworking networking =PrivecyPolicyNetworking();

Future<PrivecyPolicyModel> getData()async{
  try {
    model =await networking.getData();
  } catch (e) {
    Future.error(e);
  }
  return model;
}

}