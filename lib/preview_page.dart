import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bestbybuddy/camera.dart';
import 'package:bestbybuddy/itemlist.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  Future<Uint8List> convertXFileToBytes(XFile xFile) async {
    return xFile.readAsBytes();
  }

  String apiUrl = 'http://bhindi1.ddns.net/imgrecv';

  Future<String> readUser() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/userFile.txt';
      File file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      print('Error reading device cookie: $e');
      return '';
    }
  }

  Future<String> readDeviceJwt() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/device_jwt.txt';
      File file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      print('Error reading device JWT: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color appbarcolour = Color(0xFF36D582);
    Color bgcolour = Color(0xFF000000);
    Color containercolour = Color(0xFF252525);

    return Scaffold(
      backgroundColor: bgcolour,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Preview',
          style: TextStyle(fontFamily: 'Gotham', color: appbarcolour, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: appbarcolour,
        ),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
        ]),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(containercolour),
            ),
            onPressed: () async {
              await availableCameras().then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => CameraPage(cameras: value)),
              ));
            },
            icon: Icon(
              Icons.refresh,
              color: appbarcolour,
            ),
            label: Text(
              'Retake',
              style: TextStyle(fontSize: 18, color: appbarcolour),
            ),
          ),
          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(containercolour),
            ),
            onPressed: () async {
              var uint8List = await convertXFileToBytes(picture);
              List<int> byteList = uint8List.toList();
              String base64String = base64Encode(byteList);
              Map<String, dynamic> jsonData = {'IMG_DATA': base64String};
              print(jsonData);
              String jsonString = jsonEncode(jsonData);

              String user = await readUser();
              print(user);
              String deviceJwt = await readDeviceJwt();
              print(deviceJwt);
              http.Response response = await http.post(
                Uri.parse(apiUrl),
                headers: {'BEARER-JWT': deviceJwt, 'USERNAME': user},
                body: jsonString,
              );

              if (response.statusCode == 200) {
                print('JSON file successfully sent to the API');
                final data = jsonDecode(response.body);
                print(data);
                Map list_data = data["DATA"];
                print(list_data);
                List<dynamic> myList = list_data.keys.toList();
                print(myList);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemList(my_list: myList),
                  ),
                );
              } else {
                print('Failed to send JSON file to the API. Status code: ${response.statusCode}');
              }
            },
            icon: Icon(
              Icons.check,
              color: appbarcolour,
            ),
            label: Text(
              'Confirm',
              style: TextStyle(fontSize: 18, color: appbarcolour),
            ),
          ),
        ],
      ),
    );
  }
}
