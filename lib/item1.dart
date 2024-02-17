import 'package:bestbybuddy/view_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  MyApp({super.key});

  Color appbarcolour=Color(0xFF36D582);
  Color bgcolour=Color(0xFF000000);
  Color containercolour=Color(0xFF252525);
  Color textcolour=Color(0xFFDDF7EB);
  Color buttoncolour=Colors.grey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BestByBuddy',
      theme: ThemeData(
        fontFamily: 'Gotham',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFFDDF7EB), // Text color for app bar
        ),
        backgroundColor: const Color(0xFFFAF70),
        scaffoldBackgroundColor: const Color(0xFF000000),
        primaryColor: const Color(0xFF252525), // Background color for widgets
        //accentColor: const Color(0xFF596A46), // For selected items
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color(0xFFDDF7EB)),
          bodyText2: TextStyle(color: Color(0xFFDDF7EB)),
        ),
      ),
      home: const YourPage(),
    );
  }
}

class YourPage extends StatefulWidget {
  const YourPage({super.key});

  @override
  State<YourPage> createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  final List<String> _dateTimeRows = [
    '2024-01-22',
    '2024-01-21',
  ];

  final _dropdownOptions = ['1 day before', '2 days before', '5 days before'];
  String? _selectedOption = '1 day before';
  final _dateTimeFormat = DateFormat('yyyy-MM-dd');

  void _addNewRow() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020), // Limit to dates after 2020
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      final formattedDateTime = _dateTimeFormat.format(selectedDate);
      setState(() {
        _dateTimeRows.add(formattedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          //onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewMenu()),)
        ),
        title: const Text('BestByBuddy'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/logo.png'),
          ),
        ],
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/carrot.png'),
              ),
            ),
            const Text('Carrot', style: TextStyle(fontSize: 28)),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _dateTimeRows.length,
                itemBuilder: (context, index) {
                  final dateTime = _dateTimeRows[index];
                  return Dismissible(
                    key: Key(dateTime),
                    onDismissed: (direction) {
                      setState(() {
                        _dateTimeRows.removeAt(index);
                      });
                    },
                    background: Container(color: Colors.red,
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: const Icon(Icons.delete),
                    ),
                    child: Container(
                      //color: Color(0xFF252525),
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color(0xFF252525),
                      ),
                      child: ListTile(
                        title: Text(dateTime,
                        style: TextStyle(
                          color: Color(0xFFDDF7EB),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFF36D582)),
              ),
              child: DropdownButton<String>(
                value: _selectedOption,
                items: _dropdownOptions.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
                style: TextStyle(
                  color: Color(0xFF36D582), // Text color
                  fontSize: 20.0, // Text size
                  //backgroundColor: Color(0xFF252525),
                ),
                dropdownColor: Color(0xFF252525),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewRow,
        backgroundColor: Color(0xFF252525),
        foregroundColor: Color(0xFF36D582),
        child: const Icon(Icons.add),

      ),
    );
  }

}
