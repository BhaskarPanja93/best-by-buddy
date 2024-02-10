import 'package:bestbybuddy/view_menu.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.home),
        onPressed: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ViewMenu()));
        },
      ),
      backgroundColor: Colors.grey[800],
      title: Text('Camera',
        style: TextStyle(fontFamily: 'Poppins', color: Colors.black87),
      ),
      centerTitle: true,
    ),
    bottomNavigationBar: BottomAppBar(
      //color: Colors.grey[800],
      child: Container(
        height: kToolbarHeight, // Standard height of AppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.circle_outlined),
            ),
          ],
        ),
      ),
    ),
  );
}





class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);

    await cameraController.initialize().then((value) {
      if(!mounted) {
        return;
      }

      setState(() {});

    }).catchError((e){
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //if(cameraController.value.isInitialized){
    return Scaffold(
      backgroundColor: Colors.amber,
      // body: Stack(
      //   children: [
      //     CameraPreview(cameraController),
      //     Align(
      //       alignment: Alignment.bottomLeft,
      //       child: Container(
      //         margin: EdgeInsets.only(
      //           left:20,
      //           bottom:20,
      //         ),
      //         height: 50,
      //         width: 50,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.grey[800],
      //         ),
      //       )
      //     )
      //   ],
      // )
    );
  }
}


//uploadFile() async {
 // var postUri = Uri.parse("<APIUrl>");
 // var request = new http.MultipartRequest("POST", postUri);
 // request.fields['user'] = 'blah';
 // request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri("<path/to/file>").readAsBytes(), contentType: new MediaType('image', 'jpeg')))

  //request.send().then((response) {
  //  if (response.statusCode == 200) print("Uploaded!");
 // });
//}