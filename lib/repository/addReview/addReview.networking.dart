import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/addReview.model.dart';
import 'package:qcamyapp/models/allReview.model.dart';
import 'package:http_parser/http_parser.dart';


class AddReviewNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/send_review";
  static const String urlENDPOINT2 = "https://cashbes.com/photography/apis/reviews_all";

  final client = http.Client();

  late AddReviewModel addReviewModel;
  late AllReviewsModel allReviewsModel;
  late String addReviewStatusCode ;

 Future<AddReviewModel> addReviewData({
  required String id,
  required String token,
  required String rating,
  required String comment,
  required List<dynamic> images,
}) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(urlENDPOINT));
    request.fields['token'] = token;
    request.fields['rating'] = rating;
    request.fields['comment'] = comment;
    request.fields['product_id'] = id;

    if (images.isEmpty) {
      // If the images list is empty, add an empty string to the 'file[]' field.
      request.fields['file[]'] = '';
    } else {
      for (var i = 0; i < images.length; i++) {
        var image = images[i];
        if (image is String) {
          // If the image is a URL, download it and add it to the request as a file.
          var response = await http.get(Uri.parse(image));
          var imageName = 'image$i.jpg'; // Provide a suitable filename here.
          request.files.add(http.MultipartFile.fromBytes(
            'file[]',
            response.bodyBytes,
            filename: imageName,
            contentType: MediaType('image', 'jpeg'),
          ));
        } else if (image is File) {
          // If the image is a local file, add it directly to the request.
          var imageName = image.path.split('/').last;
          request.files.add(http.MultipartFile(
            'file[]',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: imageName,
            contentType: MediaType('image', 'jpeg'),
          ));
        }
      }
    }

    var response = await request.send();
    print("oooooooooooo${response.statusCode}");
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      final decodedData = json.decode(responseData);
       if (decodedData['status']=='200') {
        print(responseData);
         addReviewModel = AddReviewModel.fromJson(decodedData);
       addReviewStatusCode = response.statusCode.toString();
       }
    }else{
      addReviewStatusCode = response.statusCode.toString();
    }
  } catch (e) {
    return Future.error(e);
  }
  return addReviewModel; // Return an empty model if the response status code is not 200.
}


  Future<AllReviewsModel> allReviews({required String id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT2),body: {
        'product_id':id
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        if (response['status']=='200') {
          allReviewsModel = AllReviewsModel.fromJson(response);
           return allReviewsModel;
        }else{
          allReviewsModel.data.clear();
        }
      }
    } catch (e) {
      return Future.error(e);
    }
   return allReviewsModel;
  }
}
