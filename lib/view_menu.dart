import 'package:bestbybuddy/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:bestbybuddy/item1.dart';

class ViewMenu extends StatefulWidget {
  const ViewMenu({super.key});

  @override
  State<ViewMenu> createState() => _ViewMenuState();
}



class _ViewMenuState extends State<ViewMenu> {
  Color appbarcolour=Color(0xFF36D582);
  Color bgcolour=Color(0xFF000000);
  Color containercolour=Color(0xFF252525);
  Color textcolour=Color(0xFFDDF7EB);
  Color buttoncolour=Colors.grey;

  @override
  Widget build(BuildContext context) {
    //ThemeData(fontFamily: 'Gotham');
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gotham'),
      home: Scaffold(

        backgroundColor: bgcolour,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Items in Your Pantry',
          style: TextStyle(fontFamily: 'Gotham', color: appbarcolour, fontWeight: FontWeight.bold),
          ),

          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: containercolour,
              ),
              child: Row(
                children: <Widget>[
                  Text('Carrot',
                  style: TextStyle(color: textcolour, fontSize: 23)),
                  Spacer(),
                  ElevatedButton.icon(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),);
                  },
                      icon: Icon(Icons.info_outline, color: textcolour,),
                      label: Text('View',
                      style: TextStyle(fontSize: 17, color: textcolour)),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(appbarcolour)),
                  ),
                ]
              ),
            ),
          ]
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () async {
                await availableCameras().then((value) => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
              },
              label: Text('Add Items',
              style: TextStyle(color: appbarcolour, fontWeight: FontWeight.bold, fontSize: 18)),
              icon: Icon(Icons.add_a_photo, color: appbarcolour,),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(containercolour)),
            ),
          ],
        ),
      ),
    );
  }
}
