import 'package:flutter/material.dart';
import 'music_sheet_widget.dart';

class ViewSheetsPage extends StatefulWidget {
  @override
  ViewSheetsPageState createState() => ViewSheetsPageState();
}

class ViewSheetsPageState extends State<ViewSheetsPage> {
  List<MusicSheetWidget> sheets = [MusicSheetWidget()];

  void _addNewSheet() {
    setState(() {
      sheets.add(MusicSheetWidget());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Music Mastery Sheets')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ...sheets, // List of MusicSheetWidgets
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _addNewSheet,
              icon: Icon(Icons.library_add),
              label: Text('Add New Sheet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
