import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final List<MapEntry> my_list;

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
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gotham'),
      home: Scaffold(
        backgroundColor: bgcolour,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('List of Items',
            style: TextStyle(fontFamily: 'Gotham', color: appbarcolour, fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: true,
        ),
      body: ListView.builder(
        itemCount: widget.my_list.length,
        itemBuilder: (context, index) {
          return ListTile(
        title: Text(widget.my_list[index].key.toString()), // Accessing the key of the MapEntry
            );
          },
        ),
      ),
    );
  }
}
