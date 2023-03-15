import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DownloadAssetsDemo extends StatefulWidget {

  String? files;
  DownloadAssetsDemo(String files) : super();

  final String title = "Download & Extract ZIP Demo";

  @override
  DownloadAssetsDemoState createState() => DownloadAssetsDemoState();
}

class DownloadAssetsDemoState extends State<DownloadAssetsDemo> {
  //
  bool _downloading = false;
  String _dir = "";
  bool downloading = false;
  var progress2 = "";
  var _onPressed;
  var path = "No Data";
  late List<String> _images, _tempImages;
  String _zipPath = 'https://coderzheaven.com/youtube_flutter/images.zip';
  String _localZipFileName = 'images.zip';

  getHistoryImageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _images = prefs.getStringList("images")!;
    });
  }

  @override
  void initState() {
    super.initState();
    _images = [];
    // getHistoryImageList();
    widget.files = 'https://coderzheaven.com/youtube_flutter/images.zip';
    downloadFile(pdfUrl: widget.files!);
    _downloadZip();
    _tempImages = [];
    _downloading = false;
    _initDir();
  }

  _initDir() async {
    if (_dir == "") {
      _dir = (await getApplicationDocumentsDirectory()).path;
      print("init $_dir");
    }
  }

  Future<File> _downloadFile(String url, String fileName) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$_dir/$fileName');
    print("file.path ${file.path}");
    return file.writeAsBytes(req.bodyBytes);
  }

  Future<void> _downloadZip() async {
    setState(() {
      _downloading = true;
    });

    // _images.clear();
    // _tempImages.clear();

    var zippedFile = await _downloadFile(_zipPath, _localZipFileName);
    await unarchiveAndSave(zippedFile);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("images", _tempImages);
    setState(() {
      _images = List<String>.from(_tempImages);
      _downloading = false;
    });
  }

  unarchiveAndSave(var zippedFile) async {
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = '$_dir/${file.name}';
      print("fileName ${fileName}");
      if (file.isFile && !fileName.contains("__MACOSX")) {
        var outFile = File(fileName);
        //print('File:: ' + outFile.path);
        _tempImages.add(outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  buildList() {
    return _images == null
        ? Container()
        : Expanded(
      child: ListView.builder(
        itemCount: _images.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.file(
            File(_images[index]),
            fit: BoxFit.fitWidth,
          );
        },
      ),
    );
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
          await dio.download(
              pdfUrl, dirloc + convertCurrentDateTimeToString() + ".zip",
              onReceiveProgress: (receivedBytes, totalBytes) {
                downloading = true;
                progress2 =
                    ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
              });
        }
      } catch (e) {
        print(e);
      }

      downloading = false;
      progress2 = "Download Completed.";
      path = dirloc + convertCurrentDateTimeToString() + ".zip";
    } else {
      progress2 = "Permission Denied!";
      _onPressed = () {
        downloadFile(pdfUrl: pdfUrl);
      };
    }
  }

  progress() {
    return Container(
      width: 25,
      height: 25,
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 20.0),
      child: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          _downloading ? progress() : Container(),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              _downloadZip();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            buildList(),
          ],
        ),
      ),
    );
  }
}
