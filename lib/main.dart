import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'view_sheets_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  String? studentName;
  Problem? selectedProblem;

  void updateStudentName(String name) {
    studentName = name;
    notifyListeners();
  }

  void updateSelectedProblem(Problem? problem) {
    selectedProblem = problem;
    notifyListeners();
  }
}

class Problem {
  final int id;
  final String name;

  Problem(this.id, this.name);
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: Text(
                'Login',
                style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('Profile', context, () {}),
                _buildButton('Create Music Sheet', context, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateMusicSheetPage()),
                  );
                }),
                _buildButton('View Sheets', context, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewSheetsPage()),
                  );
                }),
              ],
            ),
            SizedBox(height: 30),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Center(child: Text('Bottom Banner')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, BuildContext context, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          height: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateMusicSheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Music Sheet'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StudentForm(),
              SizedBox(height: 20),
              Container(
                color: Colors.grey[300],
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Center(child: Text('Bottom Banner')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final TextEditingController _nameController = TextEditingController();
  Problem? _selectedProblem;
  final _formKey = GlobalKey<FormState>();

  final List<Problem> _problems = [
    Problem(1, 'Intonation'),
    Problem(2, 'Shifting'),
    Problem(3, 'Rhythm'),
    Problem(4, 'Bowing'),
    Problem(5, 'String Crossings'),
    Problem(6, 'Articulation'),
    Problem(7, 'Note Clarity'),
    Problem(8, 'Tone Production'),
    Problem(9, 'Chords'),
    Problem(10, 'Two-voice Chords'),
    Problem(11, 'Three-voice Chords'),
    Problem(12, 'Four-voice Chords'),
    Problem(13, 'Dynamics'),
    Problem(14, 'Phrasing'),
    Problem(15, 'Too Slow'),
    Problem(16, 'Too Fast'),
    Problem(17, 'Memory'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter student name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text('Please select the problem you are having', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            DropdownButtonFormField<Problem>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: Text('Select a problem'),
              value: _selectedProblem,
              validator: (value) {
                if (value == null) {
                  return 'Please select a problem';
                }
                return null;
              },
              items: _problems.map((Problem problem) {
                return DropdownMenuItem<Problem>(
                  value: problem,
                  child: Text('${problem.id}. ${problem.name}'),
                );
              }).toList(),
              onChanged: (Problem? newValue) {
                setState(() {
                  _selectedProblem = newValue;
                });
                Provider.of<MyAppState>(context, listen: false)
                    .updateSelectedProblem(newValue);
              },
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the form data to app state
                    Provider.of<MyAppState>(context, listen: false)
                        .updateStudentName(_nameController.text);
                    
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully')),
                    );
                    
                    // Navigate back to home page after submission
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
