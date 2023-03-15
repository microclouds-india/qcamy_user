import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qcamyapp/models/firmware.model.dart';
import 'package:qcamyapp/repository/firmware/firmware.networking.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:file_utils/file_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class FirmwareNotifier extends ChangeNotifier {
  final FirmwareNetworking _firmwareNetworking = FirmwareNetworking();

  late FirmwareModel firmwareModel;

  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  late Directory externalDir;

  loading(bool downloading) {
    this.downloading = downloading;
    notifyListeners();
  }

  Future searchData() async {
    try {
      firmwareModel = await _firmwareNetworking.searchData();

      return const BoxConstraints.expand();
    } catch (e) {
      return Future.error(e);
    }
  }

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
        DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future downloadFile({required String pdfUrl}) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/storage/emulated/0/Download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        if (await Permission.manageExternalStorage.request().isGranted) {
          FileUtils.mkdir([dirloc]);
          loading(true);
          await dio.download(
              pdfUrl, dirloc + convertCurrentDateTimeToString() + ".zip",
              onReceiveProgress: (receivedBytes, totalBytes) {
                progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
              });
        }
      } catch (e) {
        print(e);
      }

      loading(false);
      progress = "Download Completed.";
      path = dirloc + convertCurrentDateTimeToString() + ".zip";
    } else {
      loading(false);
      progress = "Permission Denied!";
      _onPressed = () {
        downloadFile(pdfUrl: pdfUrl);
      };
    }
  }

}
