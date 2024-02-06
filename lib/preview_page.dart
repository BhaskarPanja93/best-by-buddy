import 'dart:convert';
import 'dart:typed_data';
import 'package:bestbybuddy/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class PreviewPage extends StatelessWidget {
   PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  Future<Uint8List> convertXFileToBytes(XFile xFile) async {
    return xFile.readAsBytes();
  }

  String apiUrl = 'http://bhindi2.ddns.net:50000/imgrecv';

  @override
  Widget build(BuildContext context) {
    Color appbarcolour=Color(0xFF36D582);
    Color bgcolour=Color(0xFF000000);
    Color containercolour=Color(0xFF252525);
    Color textcolour=Color(0xFFDDF7EB);
    Color? buttoncolour=Colors.grey[800];

    return Scaffold(
      backgroundColor: bgcolour,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Preview',
          style: TextStyle(color: Color(0xFF36D582))),
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
                await availableCameras().then((value) => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
              },
              icon: Icon(Icons.refresh, color: appbarcolour,),
              label: Text('Retake',
              style: TextStyle(fontSize: 18, color: appbarcolour))
          ),

          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(containercolour),
            ),
              onPressed: () async {
                print("hi");
                var uint8List = await convertXFileToBytes(picture);
                List<int> byteList = uint8List.toList();
                String base64String = base64Encode(byteList);
                Map<String, dynamic> jsonData = {'IMG_DATA': base64String};
                print(jsonData);
                String jsonString = jsonEncode(jsonData);

                http.Response response = await http.post(
                  Uri.parse(apiUrl),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonString,
                );

                if (response.statusCode == 200) {
                  print('JSON file successfully sent to the API');
                  print(response.body);
                  final data =  jsonDecode(response.body);
                  print(data);
                } else {
                  print('Failed to send JSON file to the API. Status code: ${response.statusCode}');
                }
              },
              icon:  Icon(Icons.check, color: appbarcolour,),
              label: Text('Confirm',
              style: TextStyle(fontSize: 18, color: appbarcolour)),

          ),

        ],
      ),
    );
  }
}