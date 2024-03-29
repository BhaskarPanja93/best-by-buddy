import 'package:bestbybuddy/view_menu.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final List<dynamic> my_list;

  const ItemList({Key? key, required this.my_list}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  Color appbarcolour=Color(0xFF36D582);
  Color bgcolour=Color(0xFF000000);
  Color containercolour=Color(0xFF252525);
  Color textcolour=Color(0xFFDDF7EB);
  Color buttoncolour=Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolour,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'List of Items',
          style: TextStyle(
            fontFamily: 'Gotham',
            color: appbarcolour,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.my_list.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: containercolour,
          ),
            child: Row(
              children: <Widget>[

              ]
            )
          );
        },
      ),


      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () async {
              // Add your logic for adding items
            },
            label: Text(
              'Add Items',
              style: TextStyle(color: appbarcolour, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            icon: Icon(Icons.add, color: appbarcolour),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(containercolour)),
          ),
          TextButton.icon(
            onPressed: () async {
              // Navigator.push(
              //   context,
              //   // MaterialPageRoute(
              //   //   //builder: (context) => ViewMenu(mylist: widget.my_list), // Pass widget.my_list here
              //   // ),
              // );
            },
            label: Text(
              'Confirm',
              style: TextStyle(color: appbarcolour, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            icon: Icon(Icons.check, color: appbarcolour),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(containercolour)),
          ),
        ],
      ),
    );
  }
}
